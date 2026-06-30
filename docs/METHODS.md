# Methods

## Data preparation

The workflow uses a small real paired-end E. coli sequencing dataset and the E. coli REL606 reference genome.

Data are prepared using:

    bash scripts/download_data.sh

This creates the reference FASTA, paired-end FASTQ files, and `samplesheet.csv`.

## Pipeline engine

The workflow is implemented in Nextflow using DSL2.

The main pipeline file is:

    main.nf

Configuration is stored in:

    nextflow.config

## Quality control

FastQC is run on both paired-end FASTQ files.

## Alignment

Reads are aligned to the reference genome using BWA MEM.

The output is converted to BAM, sorted, and indexed using SAMtools.

An alignment summary is generated using:

    samtools flagstat

## Variant calling

Variants are called using:

    bcftools mpileup
    bcftools call

The `--ploidy 1` option is used because the workflow is based on a bacterial haploid genome.

## Filtering

Raw variants are filtered using:

    QUAL>=20 && INFO/DP>=10 && INFO/MQ>=30 && INFO/MQ0F<0.1

This keeps variants with sufficient quality, read depth, mapping quality, and low zero-mapping-quality read fraction.

## Variant summarisation

A Python script parses the filtered VCF and generates:

- `called_variants_summary.csv`
- `variant_type_counts.csv`

Variants are classified as either:

- SNP
- indel or complex
