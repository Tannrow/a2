# ADR 0001: CLI-First Private System


## Status
Accepted

## Context
The system is for private personal use with tight scope, requiring low overhead and high reproducibility without UI drift.

## Decision
Build the system CLI-first with text outputs and optional static artifacts; keep the repo private with no external UI scaffolding.

## Consequences
Developer ergonomics focus on scripts and commands; avoids front-end complexity and reduces attack surface. Any future UI requires a new ADR and phase gate.
