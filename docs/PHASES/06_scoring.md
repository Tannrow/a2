# Phase 06 - Scoring and Trade Hypothesis

## Objective
Score classified setups deterministically and produce structured trade hypotheses.

## Scope
Apply scoring rules/weights to setups, generate hypotheses with rationale, and log outputs.

## Inputs
- Labeled setups and no-trade outcomes
- Scoring rules and weights
- Hypothesis schema

## Outputs
- Scored setups and trade hypotheses with explanations and metadata

## Artifact
CLI that scores setups and emits hypotheses conforming to `score_schema` and `trade_hypothesis_schema`.

## Acceptance
- Scores reproducible given identical inputs and weights.
- Hypotheses include supporting factors and confidence rationale.
- No-trade outcomes preserved and propagated.

## Commands
- `./scripts/score_setups.sh --date YYYY-MM-DD`
- `duckdb :memory: "SELECT AVG(score) FROM 'data/scores/*.parquet'"`

## Do Not Build Yet
LLM-based scoring, auto-execution, reporting, or orchestration.

## Allowed Paths
`scripts/`, `data/scores/`, `data/hypotheses/`, `docs/CONTRACTS/score_schema.md`, `docs/CONTRACTS/trade_hypothesis_schema.md`, `docs/PHASES/06_scoring.md`

## Failure Modes
- Weight changes without versioning.
- Scores not aligned with documented factors.
- Dropping no-trade cases or missing rationale fields.
