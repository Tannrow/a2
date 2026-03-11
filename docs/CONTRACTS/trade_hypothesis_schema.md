# Trade Hypothesis Schema Contract

## Purpose
Structure trade hypotheses built from scored setups for reporting and prediction logging.

## Required Fields
- `as_of`: ISO date.
- `symbol`: ticker string.
- `score_run_id`: reference to scoring run.
- `hypothesis_id`: unique identifier per hypothesis.
- `thesis`: concise description of trade idea.
- `entry_plan`: deterministic entry conditions.
- `exit_plan`: deterministic exit/invalidations.
- `risk_notes`: key risks or blockers.
- `checksum`: hash of hypothesis payload.

## Optional Fields
- `llm_summary`: LLM-generated narrative based on deterministic data (not decisioning).
- `tags`: list of category tags.

## Determinism and Traceability
- Hypotheses must reference scores and setups; LLM summaries cannot alter decisions.
- Entry/exit plans grounded in deterministic factors; checksum verifies integrity.

## Example JSON Stub
```json
{
  "as_of": "2026-03-10",
  "symbol": "AAPL",
  "score_run_id": "score-20260310-001",
  "hypothesis_id": "hypo-20260310-01",
  "thesis": "Breakout retest holds above 170 with improving breadth",
  "entry_plan": "Enter on close > 170 with volume above 10-day average",
  "exit_plan": "Exit if close < 168 or if volume dries below 5-day average",
  "risk_notes": ["High event risk this week"],
  "checksum": "sha256:mno345",
  "llm_summary": "Setup shows strength; risk is event-driven volatility",
  "tags": ["breakout", "pullback"]
}
```

## Validation Expectations
- Linkage to score_run_id verified.
- Entry/exit plans checked for completeness.
- Checksum confirms payload stability; LLM summary treated as optional text only.
