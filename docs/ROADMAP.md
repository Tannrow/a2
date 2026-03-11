# Roadmap

Phases must be executed in order with hard checkpoints. Each ends with a runnable artifact and clear acceptance.

## 1. 01 foundation and contracts
- Goal: establish governance, architecture, contracts, and task system.
- Builds: constitution, phase docs, contracts, ADRs, task YAMLs.
- Working artifact: repository execution framework.
- Checkpoint: docs and tasks reviewed; NEXT_TASK set; no product code added.
- Avoid: implementing data pipelines or features.

## 2. 02 raw ingestion
- Goal: ingest end-of-day raw data with provenance.
- Builds: ingestion CLI and schemas for raw landing.
- Working artifact: command to fetch/store raw files with logs.
- Checkpoint: deterministic run produces stored raw dataset with checksums.
- Avoid: snapshot shaping, features, or ML.

## 3. 03 canonical snapshot
- Goal: create reproducible canonical snapshots.
- Builds: snapshot builder using contracts and versioned outputs.
- Working artifact: CLI to transform raw → canonical Parquet/DuckDB.
- Checkpoint: snapshot validation against schema and checksum.
- Avoid: feature calculations or scoring.

## 4. 04 feature engineering
- Goal: deterministic feature set derived from snapshot.
- Builds: feature definitions, generation CLI, validation.
- Working artifact: feature table stored with schema/version.
- Checkpoint: feature generation passes schema checks and reproducibility spot-checks.
- Avoid: ML modeling or classification logic.

## 5. 05 setup classification and no-trade gate
- Goal: map features to setups and explicit no-trade outcomes.
- Builds: rule-based classifiers and gating rules.
- Working artifact: classifier CLI producing labeled setups/no-trade.
- Checkpoint: classifications deterministic across runs and logged with rationale.
- Avoid: probabilistic scoring or hypothesis generation.

## 6. 06 scoring and trade hypothesis
- Goal: score setups and form trade hypotheses.
- Builds: scoring rules, weightings, hypothesis structuring.
- Working artifact: CLI producing scored hypotheses with explanations.
- Checkpoint: scores stable for identical inputs; hypotheses logged with rationale.
- Avoid: LLM-driven decisioning or auto-execution.

## 7. 07 reporting and chart pack
- Goal: synthesize outputs into text reports and static visuals.
- Builds: report generator, chart pack scripts (static files only).
- Working artifact: CLI producing report bundle.
- Checkpoint: report references inputs, scores, hypotheses, and no-trade cases.
- Avoid: live dashboards or interactive UIs.

## 8. 08 prediction log and evaluation
- Goal: maintain append-only log and evaluate performance.
- Builds: logging format, evaluation metrics CLI.
- Working artifact: prediction log updater and evaluation run.
- Checkpoint: evaluations reproducible with clear metrics; logs append-only.
- Avoid: calibration/ranking changes.

## 9. 09 calibration and ranking
- Goal: calibrate scores and rank hypotheses after evaluation maturity.
- Builds: calibration routines, ranking criteria.
- Working artifact: calibration CLI adjusting weights; ranking output.
- Checkpoint: calibration tested against historical runs; stability documented.
- Avoid: orchestration or deployment work.

## 10. 10 orchestration and Azure jobs
- Goal: orchestrate phase workflows and schedule EOD runs in Azure.
- Builds: pipelines/jobs, monitoring hooks, error handling.
- Working artifact: orchestrated job definitions and runbooks.
- Checkpoint: scheduled runs produce expected artifacts and logs.
- Avoid: scope creep into UI/ML beyond prior phase guarantees.
