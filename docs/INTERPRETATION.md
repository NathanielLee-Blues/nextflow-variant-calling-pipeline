# Interpretation

## Analytical result

The Nextflow pipeline produced a filtered set of 407 candidate variants, comprising 353 SNPs and 54 indel or complex records. These counts are consistent with the manual command-line workflow because the two repositories use the same reference, reads, variant-calling logic and filtering strategy.

The agreement is useful as an implementation check. It indicates that moving the analysis into Nextflow did not alter the final variant summary. It does not establish that the calls are biologically correct.

## What Nextflow changes

Nextflow represents each analytical stage as a process with declared inputs and outputs. This reduces reliance on manually running commands in the correct order and permits completed work to be resumed from cached results. The trace, timeline and report also make resource use and process execution easier to inspect.

These are improvements in reproducibility and workflow management. They do not compensate for unsuitable biological assumptions or weak input data.

## Meaning of the VCF

The filtered records are candidate differences between the sequencing sample and the REL606 reference under the current caller and filters. Without a truth set, replicate or orthogonal validation, sensitivity and precision remain unknown.

## Relationship to the manual workflow

The manual repository is useful for understanding each command and intermediate file. The Nextflow version is useful for formalising dependencies and scaling the same logic to samplesheet-driven execution. Maintaining both versions makes the distinction between analytical method and workflow engine explicit.

## Conclusion

The pipeline successfully reproduces the manual result in a workflow-managed form. Its principal contribution is reliable orchestration and traceability. Biological interpretation remains constrained by the same assumptions and limitations as the underlying variant-calling method.
