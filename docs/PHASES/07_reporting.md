# Phase 07 - Reporting and Chart Pack

## Objective
Produce text-first reports and static chart packs summarizing scores, hypotheses, and no-trade cases.

## Scope
Generate reports that synthesize outputs; optional static charts; LLM allowed only for summarization based on deterministic data.

## Inputs
- Scores and hypotheses
- No-trade records
- Reporting templates

## Outputs
- Report bundle (text/markdown) and static chart files

## Artifact
CLI that assembles report and chart pack from prior outputs.

## Acceptance
- Reports cite data sources, scores, hypotheses, and no-trade cases.
- Static assets are reproducible; no live dashboards.
- LLM usage, if any, is constrained to summarization of provided data.

## Commands
- `./scripts/generate_report.sh --date YYYY-MM-DD`
- `ls reports/YYYY-MM-DD/`

## Do Not Build Yet
Interactive dashboards, web UI, live data fetching, orchestration scheduling.

## Allowed Paths
`scripts/`, `reports/`, `docs/PHASES/07_reporting.md`

## Failure Modes
- Allowing interactive UI creep.
- Reports lacking traceability to inputs.
- Non-deterministic chart generation.
