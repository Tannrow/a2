# Architecture Overview

## System Restatement
CLI-first, private, end-of-day ticker intelligence and trade-probability system. Deterministic/statistical processing produces setup classification, scoring, and trade hypotheses; LLMs only synthesize evidence and write reports. "No-trade" is a first-class outcome.

## Objective
Generate clear, repeatable trade-quality probabilities and hypotheses from end-of-day data with strict gating, traceability, and auditability.

## Scope for v1
- End-of-day batch only.
- Deterministic feature extraction, setup classification, and scoring before any ML consideration.
- Text-first CLI interactions; optional static report artifacts.

## Explicit Non-goals (early phases)
- Browser UI, dashboards, or charting services.
- Intraday or streaming ingestion.
- Auto-trading or broker integration.
- Vector DBs, agent frameworks, or sentiment analysis pipelines.
- Unconstrained LLM decisioning.

## Architecture Principles
- Deterministic first, ML later after calibration checkpoints.
- Reproducible runs: fixed seeds, versioned inputs, logged parameters.
- Traceable artifacts with minimal dependencies; local-first storage.
- Hard phase gates; every phase emits a runnable/checkable artifact.
- No-trade decisions are preserved and logged, not discarded.
- CLI-first ergonomics: scripts and commands over services.

## Core Pipeline (conceptual)
1. Raw data ingestion
2. Canonical snapshot construction
3. Feature engineering
4. Setup classification (includes no-trade gate)
5. Scoring
6. Trade hypothesis generation
7. Report and chart pack (static)
8. Prediction log
9. Evaluation
10. Calibration and ranking (later)

## Components and Responsibilities
- Ingestion: pull end-of-day data, record provenance, normalize to staging.
- Snapshot builder: create canonical, versioned snapshots (e.g., DuckDB/Parquet) with schema contracts.
- Feature engine: deterministic feature set generation with explicit definitions.
- Setup classifier: map features to labeled setups and no-trade outcomes.
- Scoring: deterministic scorecards with explainable factors; no ML until calibrated.
- Hypothesis generator: assemble trade hypotheses (entry/exit ideas, confidence rationale) from scores.
- Reporting: synthesize findings and evidence; LLM limited to summarization and narrative.
- Prediction log: append-only record of hypotheses, scores, and no-trade events.
- Evaluation: measure hit rates, drawdown filters, and rule adherence.
- Calibration/Ranking: later-stage weighting and ordering after evaluation maturity.

## Data Flow
Raw sources → staging → canonical snapshot → feature tables → setup classifications → scores → trade hypotheses → report bundle → prediction log → evaluation outputs → calibration insights.

## Storage Approach
- Prefer local Parquet files managed via DuckDB for simplicity and reproducibility before introducing Postgres or cloud stores.
- Versioned snapshots and features with checksums; append-only logs for predictions and evaluations.

## Why CLI-first and End-of-Day
- Keeps scope tight, avoids UI drift, and favors automation scripts.
- End-of-day batches reduce operational risk and simplify reproducibility.

## Why Deterministic Scores Before ML
- Establishes baseline fidelity and debuggability; ML only after deterministic baselines and calibration checkpoints succeed.

## No-Trade as First-Class Output
- No-trade outcomes prevent forced trades, help evaluate discipline, and must be logged alongside scores.

## LLM Allowlist vs Denylist
- Allowed: summarize evidence, draft reports, explain scenarios, highlight risks using deterministic outputs as inputs.
- Not allowed: direct scoring, gating, or autonomous execution decisions; no unsourced data pulls.
