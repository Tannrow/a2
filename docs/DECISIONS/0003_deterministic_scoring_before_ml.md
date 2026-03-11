# ADR 0003: Deterministic Scoring Before ML


## Status
Accepted

## Context
Reliable baselines and auditability are required before introducing probabilistic models.

## Decision
Implement deterministic/statistical scoring first; ML models are disallowed until deterministic checkpoints and calibration pass.

## Consequences
Forces clear rule-based scores and explanations; delays ML experimentation but improves trust and debuggability. ML adoption will need a new ADR and phase gate.
