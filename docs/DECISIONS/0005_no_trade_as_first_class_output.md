# ADR 0005: No-Trade as First-Class Output

- Status: Accepted
- Context: Avoiding low-quality trades is as important as entering good ones; discipline must be measurable.
- Decision: Treat no-trade decisions as primary outputs with rationale, logging, and evaluation parity.
- Consequences: Pipelines must propagate and log no-trade outcomes; reporting and evaluation must include them. Scoring cannot force trades when gates indicate abstain.
