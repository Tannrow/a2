# ADR 0002: End-of-Day Only for v1

- Status: Accepted
- Context: Early phases need deterministic, low-ops processing; intraday adds complexity and noise.
- Decision: Limit v1 to end-of-day batch workflows; no intraday or streaming features.
- Consequences: Simplifies scheduling and reproducibility; users must wait for daily cycles. Any intraday expansion requires later phase approval.
