# Project plan and scope

## Objective

Translate the manual bacterial variant-calling workflow into a samplesheet-driven Nextflow pipeline without changing its core analytical logic.

## Questions

1. Can the manual stages be represented as independent processes with explicit inputs and outputs?
2. Does the workflow-managed implementation reproduce the manual variant summary?
3. Can execution reports and cached processes improve traceability and rerunning?
4. Which additions would be required before the pipeline could be considered production-ready?

## Deliverables

- `main.nf` and `nextflow.config`;
- a samplesheet-based input structure;
- automated quality control, alignment, calling, filtering and summarisation;
- pipeline trace, timeline, report and DAG outputs;
- methods, interpretation and limitations documents.

## Design choices

The pipeline retains familiar command-line tools so that differences between the manual and managed versions arise from orchestration rather than from a new variant-calling method. Final counts are compared with the manual workflow as an implementation check.

## Boundaries

The project does not benchmark accuracy, support every organism or provide containerised production deployment. It is a clear transition from sequential shell execution to an explicit workflow graph.

## Next extensions

Priority improvements are a small automated test dataset, container profiles, MultiQC aggregation, parameter validation and testing across multiple samples.
