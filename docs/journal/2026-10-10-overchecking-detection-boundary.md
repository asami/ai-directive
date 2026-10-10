# Overchecking detection boundary

Date: 2026-10-10
Status: design alignment

## Context

The existing Defensive Complexity and Failure Model rules already prohibit speculative checks and require mechanisms to be justified by the declared execution/failure model. Literal directives alone cannot reliably prevent semantic workarounds: a model can replace a prohibited hash with copying, rereading, comparison, recovery state, or another mechanism that preserves the same unnecessary defensive intent.

## Direction

Keep ai-directive focused on a small number of strong generation principles. Do not grow an open-ended blacklist for every newly observed overchecking technique.

Enforcement and learning are split:

- cbd-support CAR lint detects known, cheap, deterministic suspicious patterns;
- cbd-support Review uses AI for semantic judgment about model-unjustified defensive complexity;
- human review decides ambiguous design findings;
- confirmed recurring patterns may become future deterministic lint rules;
- sm-workflow schedules these mechanisms according to cost, keeping heavy semantic scans out of the ordinary commit-time lint path.

ai-directive remains preventive guidance, not the repository of every observed failure pattern.

The authoritative design principle remains: prefer guarantees already supplied by the Execution Model and architecture; defensive mechanisms require traceable requirements rather than implementation intuition.
