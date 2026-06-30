# Project plan

## Project title

Nextflow Variant Calling Pipeline

## Purpose

This project demonstrates how a bacterial variant-calling workflow can be automated using Nextflow.

It is intended as a portfolio project showing workflow engineering, reproducibility, samplesheet-driven execution, and practical genomics pipeline development.

## Workflow stages

1. Prepare a reference genome and paired-end FASTQ files.
2. Read sample information from a samplesheet.
3. Run FastQC on paired-end reads.
4. Align reads to the reference genome using BWA.
5. Sort and index alignments using SAMtools.
6. Call variants using BCFtools.
7. Filter variants using quality, depth, and mapping-quality criteria.
8. Summarise filtered variants using Python.
9. Generate organised output directories.

## Planned outputs

- FastQC reports
- alignment summary
- raw VCF
- filtered VCF
- variant summary CSV
- variant type count table
- Nextflow execution reports
- README and methods documentation

## Portfolio value

This project demonstrates the ability to convert a manual bioinformatics workflow into a reproducible pipeline. It shows practical use of Nextflow, command-line genomics tools, structured inputs, organised outputs, and reproducible analysis design.
