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


## 2026-10-11 clarification: assurance can reduce quality

Recent sm-workflow work exposed a stronger failure mode than wasted checks alone. Low-value exceptional-path assurance can consume substantial AI development cost, prevent a Phase from closing and block subsequent work, while also increasing the implementation state space until the added complexity itself causes defects in the normal path.

The directive therefore treats development completion and main-route simplicity as quality concerns, not as concerns subordinate to hypothetical robustness. For operational accidents or misuse that are outside the declared Failure Model, a failed/stopped execution and a fresh restart may be the correct contract. Intermediate-state consistency, winner selection, replay equivalence, and complete recovery are not automatically desirable guarantees.

Tests are part of this boundary. A test for an unnecessary guarantee turns that guarantee into continuing specification and maintenance cost. Exceptional-path tests therefore require the same semantic justification as the defensive implementation they exercise.

The intended optimization target is not maximum assurance. It is the simplest implementation that satisfies the authoritative requirements while preserving main-route reliability, development cost, and the ability to finish the current work.
