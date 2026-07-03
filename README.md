# Nextflow Variant Calling Pipeline

![Nextflow](https://img.shields.io/badge/Nextflow-Workflow%20pipeline-green)
![Bioinformatics](https://img.shields.io/badge/Bioinformatics-Variant%20calling-purple)
![Status](https://img.shields.io/badge/Status-Version%201%20complete-lightgrey)

## Project overview

This repository demonstrates a small reproducible Nextflow pipeline for bacterial variant calling from paired-end sequencing reads.

The pipeline uses a real E. coli paired-end FASTQ dataset and the E. coli REL606 reference genome. It performs quality control, read alignment, BAM processing, variant calling, variant filtering, and VCF summarisation.

This project builds on a manual command-line variant-calling workflow and converts the same analysis logic into a workflow-managed Nextflow pipeline.

## Aim

To demonstrate how a variant-calling workflow can be automated and made reproducible using Nextflow.

## Workflow

~~~text
samplesheet.csv
        ↓
FastQC quality control
        ↓
BWA read alignment
        ↓
SAMtools BAM sorting and indexing
        ↓
BCFtools variant calling and filtering
        ↓
Python VCF summarisation
        ↓
Summary tables and pipeline reports
~~~

## Headline results

The pipeline called and filtered candidate variants from one E. coli sequencing sample.

The filtered VCF contained **407 candidate variants**:

| Variant type | Count |
|---|---:|
| SNP | 353 |
| Indel or complex | 54 |
| Total filtered variants | 407 |

## Input data

The data are downloaded using:

~~~bash
bash scripts/download_data.sh
~~~

This prepares:

| File | Description |
|---|---|
| `data/reference/ecoli_rel606.fasta` | E. coli REL606 reference genome |
| `data/reads/sample_R1.fastq` | Read 1 FASTQ file |
| `data/reads/sample_R2.fastq` | Read 2 FASTQ file |
| `samplesheet.csv` | Sample sheet used by the Nextflow pipeline |

Large FASTQ files and intermediate workflow files are excluded from version control.

## How to run the pipeline

Install required tools:

~~~bash
sudo apt update
sudo apt install -y openjdk-17-jre bwa samtools bcftools fastqc python3
~~~

Install Nextflow if needed:

~~~bash
curl -fsSL https://get.nextflow.io | bash
mkdir -p ~/.local/bin
mv nextflow ~/.local/bin/
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
~~~

Prepare the data:

~~~bash
bash scripts/download_data.sh
~~~

Run the pipeline:

~~~bash
nextflow run main.nf
~~~

## Outputs

| Output | Description |
|---|---|
| `results/qc/` | FastQC HTML reports |
| `results/alignment/` | SAMtools alignment summary |
| `results/variants/` | Raw and filtered VCF files |
| `results/tables/called_variants_summary.csv` | Variant-level summary table |
| `results/tables/variant_type_counts.csv` | Count of SNP and indel/complex variants |
| `results/pipeline_info/` | Nextflow timeline, report, trace, and DAG files generated locally |

## Repository structure

~~~text
nextflow-variant-calling-pipeline/
├── data/
│   ├── reference/
│   └── reads/
├── scripts/
│   ├── download_data.sh
│   └── summarise_variants.py
├── results/
│   ├── qc/
│   ├── alignment/
│   ├── variants/
│   └── tables/
├── docs/
│   ├── PROJECT_PLAN.md
│   ├── METHODS.md
│   ├── INTERPRETATION.md
│   └── LIMITATIONS.md
├── main.nf
├── nextflow.config
├── samplesheet.csv
├── environment.yml
└── README.md
~~~

## Skills demonstrated

This project demonstrates:

- Nextflow workflow development
- samplesheet-driven pipeline execution
- FASTQ quality control with FastQC
- BWA read alignment
- BAM processing with SAMtools
- variant calling and filtering with BCFtools
- Python-based VCF summarisation
- reproducible pipeline organisation
- separation of raw data, intermediate files, and final outputs

## Interpretation

This pipeline reports candidate variants from real sequencing data. Because this version uses real data rather than simulated reads, the variants are not compared against a known truth set.

The results should be interpreted as candidate calls produced by this pipeline, reference genome, aligner, caller, and filtering strategy.

For more detail, see [`docs/INTERPRETATION.md`](docs/INTERPRETATION.md).

