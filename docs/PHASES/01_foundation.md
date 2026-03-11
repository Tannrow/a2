# Phase 01 - Foundation and Contracts

## Objective
Establish the repository governance, architecture direction, contracts, ADRs, and task system for the project.

## Scope
Define documents and controls that guide future implementation; align phase order, artifacts, and acceptance criteria.

## Inputs
- Problem statement and constraints
- Existing repository structure (if any)

## Outputs
- Constitution, architecture overview, roadmap, phase docs, contracts, ADRs, tasks, and status files

## Artifact
Complete repository execution framework with CURRENT_PHASE and NEXT_TASK set.

## Acceptance
- All required docs exist and are consistent on scope, phase order, and constraints.
- NEXT_TASK references the first actionable task for this phase.
- No product feature code introduced.

## Commands
- `ls docs`
- `cat NEXT_TASK.md`

## Do Not Build Yet
Ingestion logic, data schemas beyond contracts, feature code, classifiers, scoring, reporting, orchestration, UI, ML, or storage layers.

## Allowed Paths
`AGENTS.md`, `docs/**`, `TASKS.md`, `NEXT_TASK.md`, `STATUS.md`, `tasks/phase_01/*.yaml`, `README.md`

## Failure Modes
- Inconsistent phase names or numbering.
- Allowing future-phase work or UI/ML drift.
- Missing acceptance gates or unclear tasks.
