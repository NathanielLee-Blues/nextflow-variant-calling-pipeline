# Limitations

This project is a small portfolio demonstration of a Nextflow variant-calling pipeline.

Important limitations include:

- The dataset is small and intended for workflow demonstration.
- The workflow uses real data, so there is no simulated truth set for validation.
- Variant calls are candidate calls, not experimentally validated variants.
- Filtering thresholds are simple and may not be optimal for every dataset.
- The workflow does not include read trimming.
- The workflow does not include variant annotation.
- The workflow currently processes one sample.
- The pipeline runs locally and does not yet include container profiles.
- Large FASTQ and BAM files are excluded from version control.

Future improvements could include adding trimming, MultiQC, variant annotation, multiple-sample support, containers, and cloud/HPC profiles.
