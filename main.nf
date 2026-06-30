#!/usr/bin/env nextflow

nextflow.enable.dsl=2

params.samplesheet = params.samplesheet ?: "samplesheet.csv"
params.reference = params.reference ?: "data/reference/ecoli_rel606.fasta"
params.outdir = params.outdir ?: "results"

process FASTQC {
    tag "$sample_id"

    publishDir "${params.outdir}/qc", mode: 'copy'

    input:
    tuple val(sample_id), path(r1), path(r2)

    output:
    path "*_fastqc.html"

    script:
    """
    fastqc ${r1} ${r2}
    """
}

process ALIGN_READS {
    tag "$sample_id"

    publishDir "${params.outdir}/alignment", mode: 'copy', pattern: "*.flagstat.txt"

    input:
    tuple val(sample_id), path(r1), path(r2)
    path reference

    output:
    tuple val(sample_id), path("${sample_id}.sorted.bam"), path("${sample_id}.sorted.bam.bai"), path("${sample_id}.flagstat.txt")

    script:
    """
    bwa index ${reference}
    samtools faidx ${reference}

    bwa mem ${reference} ${r1} ${r2} \
      | samtools view -bS - \
      | samtools sort -o ${sample_id}.sorted.bam

    samtools index ${sample_id}.sorted.bam
    samtools flagstat ${sample_id}.sorted.bam > ${sample_id}.flagstat.txt
    """
}

process CALL_VARIANTS {
    tag "$sample_id"

    publishDir "${params.outdir}/variants", mode: 'copy'

    input:
    tuple val(sample_id), path(bam), path(bai), path(flagstat)
    path reference

    output:
    tuple val(sample_id), path("${sample_id}.raw.vcf"), path("${sample_id}.filtered.vcf")

    script:
    """
    samtools faidx ${reference}

    bcftools mpileup \
      -Ou \
      -f ${reference} \
      ${bam} \
      | bcftools call \
          -mv \
          --ploidy 1 \
          -Ov \
          -o ${sample_id}.raw.vcf

    bcftools filter \
      -i 'QUAL>=20 && INFO/DP>=10 && INFO/MQ>=30 && INFO/MQ0F<0.1' \
      ${sample_id}.raw.vcf \
      -Ov \
      -o ${sample_id}.filtered.vcf
    """
}

process SUMMARISE_VARIANTS {
    tag "$sample_id"

    publishDir "${params.outdir}/tables", mode: 'copy'

    input:
    tuple val(sample_id), path(raw_vcf), path(filtered_vcf)

    output:
    path "*.csv"

    script:
    """
    mkdir -p summary
    python3 ${projectDir}/scripts/summarise_variants.py ${filtered_vcf} summary
    cp summary/*.csv .
    """
}

workflow {
    reference_ch = file(params.reference)

    samples_ch = Channel
        .fromPath(params.samplesheet)
        .splitCsv(header: true)
        .map { row -> tuple(row.sample, file(row.r1), file(row.r2)) }

    FASTQC(samples_ch)
    aligned_ch = ALIGN_READS(samples_ch, reference_ch)
    variants_ch = CALL_VARIANTS(aligned_ch, reference_ch)
    SUMMARISE_VARIANTS(variants_ch)
}
