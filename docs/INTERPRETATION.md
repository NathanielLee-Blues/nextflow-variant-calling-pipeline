# Interpretation

## Summary of findings

This project implemented a small bacterial variant-calling workflow as a Nextflow pipeline.

The pipeline processed one paired-end E. coli sequencing sample and produced a filtered VCF containing 407 candidate variants.

The filtered variant set contained:

- 353 SNPs
- 54 indel or complex variants

## Interpretation of the pipeline output

The filtered VCF represents candidate genetic differences between the sequencing reads and the selected E. coli reference genome.

The SNP calls represent single-base substitutions. The indel or complex calls represent insertions, deletions, or more complex local differences.

Because the project uses real sequencing data rather than simulated reads, the pipeline does not compare the calls against a known truth set. The results should therefore be interpreted as candidate variants produced by this workflow and filtering strategy.

## Workflow interpretation

The main value of this project is pipeline reproducibility.

The analysis is controlled by a samplesheet, uses defined processes, and writes outputs into structured folders. This makes the workflow easier to rerun, inspect, and adapt than a collection of manual shell commands.

## Overall conclusion

This project demonstrates how a real-data bacterial variant-calling workflow can be automated using Nextflow.

It provides evidence of workflow engineering skills, command-line genomics experience, and understanding of common sequencing file formats including FASTQ, FASTA, BAM, and VCF.
