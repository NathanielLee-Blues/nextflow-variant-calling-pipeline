# Methods

## Input model

`samplesheet.csv` records the sample identifier and paths to the paired FASTQ files. The reference genome is supplied separately. Nextflow channels transfer these inputs to the relevant processes and ensure that downstream stages wait for the required outputs.

## Pipeline stages

1. **FastQC** assesses read-level quality for each FASTQ file.
2. **BWA alignment** maps paired reads to the REL606 reference.
3. **SAMtools processing** sorts and indexes the alignment and produces summary statistics.
4. **BCFtools calling** calculates variant evidence and produces a raw VCF under a haploid model.
5. **Filtering** applies the quality and depth rules defined in the pipeline.
6. **Python summarisation** converts the filtered VCF into variant-level and aggregate CSV outputs.

## Workflow configuration

`main.nf` defines the processes and their dependencies. `nextflow.config` contains execution and reporting settings. Pipeline reports are written to `results/pipeline_info/` when the workflow is run locally.

## Execution

```bash
bash scripts/download_data.sh
nextflow run main.nf
```

Nextflow can reuse completed process outputs from its work directory when the pipeline is resumed, provided the relevant inputs and process definitions have not changed.

## Reproducibility

The environment is described in `environment.yml`, while the ordered process graph is encoded in `main.nf`. Reproducibility still depends on retaining tool versions, input accessions, the reference build and filter parameters.
