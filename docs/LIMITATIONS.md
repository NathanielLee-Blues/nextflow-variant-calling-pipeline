# Limitations

## Biological validation

The pipeline has no validated truth set, so the accuracy of the 407 filtered candidates cannot be quantified. Agreement with the manual workflow confirms implementation consistency rather than biological correctness.

## Single example sample

Although the samplesheet structure supports clearer input management, the repository is currently exercised with one *E. coli* sample. Multi-sample behaviour, failure handling and resource scaling have not been evaluated across a larger cohort.

## Environment portability

The workflow relies on locally installed tools and an environment specification. Containers would provide stronger isolation from operating-system and package-version differences.

## Fixed analytical assumptions

The reference genome, haploid model, caller settings and filters are specific to the example. Nextflow automates these choices but does not determine whether they are suitable for a different organism or study.

## Limited automated testing

The pipeline result can be compared with known output counts, but the repository does not yet include a formal continuous-integration test using a minimal fixture dataset.

## Small-variant focus

The analysis targets SNPs and short indel/complex records. It does not detect structural variants, copy-number changes or large rearrangements.

## Reporting scope

Nextflow reports describe process execution and resource use. They should not be confused with biological quality-control reports or validation of the VCF.

## Practical implication

The pipeline is appropriate for learning and for reproducible execution of this defined example. A production workflow would benefit from containers, automated tests, parameter validation, MultiQC, stronger error handling and benchmarking against known variants.
