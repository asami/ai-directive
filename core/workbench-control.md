# Single-user Git-managed Workbench Control

## Scope and Authority

This shared core rule applies to workbench applications and their local workflow
helpers when they run in a Git-managed personal environment under one user's
control. This is their execution model, not a reduced version of a multi-user
system. Competing users, independent application writers and contested workflow
claims are outside this model.

Development-environment skills themselves are workbench applications in this
model, including their instructions, helper programs and saved control state.
Their agent or command-line interface does not change the operating premise.
For authoring them, apply
[Skill Authoring](skill-authoring.md), including its development-environment
specialization.

Its place in the shared rule set is defined by the
[Core Rule Map](AGENT.md#core-rule-map). It specializes the
[Defensive Complexity and Failure Model Rules](RULE.md) for this execution
model; the workbench-specific rule body is owned only by this document.
It does not impose a single-user model on unrelated multi-user services.

## Background and Rationale

A workbench is operated by its owner, who controls the environment, execution
and adoption of changes. Development changes are separated and integrated at
the repository boundary through Git worktrees, merges or pull requests under
that user's control. Parallel development does not establish a requirement for
competing writers inside the workbench application.

Hash-based pseudo-exclusion adds a second, unnecessary control plane over this
model. Digest snapshots, freshness guards and recovery branches can reject an
authorized operation because its representation changed, contradict other
partial checks, or require repairs and repeated approvals unrelated to the
intended workflow. Such mechanisms are harmful complexity, not harmless extra
safety. Avoiding them is an architectural constraint, not an optimization.

This rule promotes the user-directed policy recorded in sm-workflow's
`docs/journal/2026/10/2026-10-02-sm-workflow-single-user-typed-control-policy.md`
and the clarification that Git owns development isolation and integration.
That journal supplies context; it is not an implementation, validation or
acceptance claim, and consumers need not load it to apply this rule.

## Repository Integration, Not Application Exclusion

- Handle development isolation, conflicting changes and adoption through the
  repository's Git worktree, merge or pull-request workflow. Do NOT duplicate
  that responsibility with an application-side exclusion protocol.
- Do NOT introduce management hashes, digest-based freshness guards,
  application locks, writer claims or leases, compare-and-swap guards,
  optimistic-locking protocols or contention retries for competing writers
  excluded by this model. Replacing a hash-based exclusion guard with a
  revision-based exclusion guard or application lock does not conform to this
  rule.
- Do NOT reinterpret multiple development agents, tasks or worktrees as
  evidence that application workflow state needs multi-user arbitration.
- If a concrete requirement needs independent writers or a shared mutable
  runtime, report an execution-model/specification gap before adding a
  mechanism. Changing the declared model requires an explicit architectural
  decision; a hypothetical future need or an implementation comment is not
  such a decision.

Git integration is not a runtime lock or a database transaction. This rule
separates those responsibilities; it does not claim that Git serializes
application execution.

## Typed Control Specifications

- Do NOT use hashes as substitutes for workflow identities, state, references,
  provenance, receipts or consistency decisions. Do NOT keep a hash-backed
  route as an adapter or fallback.
- Express state, transitions, ownership and reference relationships in
  dedicated types and validated construction rules. Prevent incomplete,
  contradictory or invalid executable states from being freely constructed.
  Replacing a digest with an unconstrained string is insufficient.
- Use explicit identities and revisions with defined semantics. A revision
  selects a data version; it does not imply optimistic locking or a contention
  protocol. A typed owner reference describes ownership, not a writer claim.
- When semantic comparison is needed, compare the relevant complete typed
  data, not a digest. This does not require complete-data comparison at every
  call boundary. References and stored claims alone do not prove authority or
  execution.

## Minimal, Coherent Checks

- Do NOT repeatedly recheck invariants already guaranteed by types and
  validated construction. Prefer coherent construction/loading boundaries to
  scattered partial checks or continuous exhaustive consistency monitoring.
- Remove a partial internal check that adds complexity or bugs without
  enforcing a clear specification; do not compensate with another defensive
  layer. More checks are not themselves evidence of correctness.
- Validate stored data at a natural, well-defined boundary when useful. On a
  contradiction, stop with a clear explanation instead of inventing automatic
  repair, arbitration or retry machinery.
- Keep external-input validation, execution permissions and
  destructive-operation safety separate from internal consistency checks.
  Necessary checks at those boundaries do not justify speculative internal
  exclusion or repeated validation.

## Preserved Boundaries and Conformance

Required storage transactions, crash-consistent writes, external-command safety
and independent machine-wide build serialization retain their own actual
contracts. In particular, this rule does not remove the workstation's SBT
serialization policy. Native Git object IDs remain repository revisions, not
application management hashes. A checksum required for artifact integrity is
not permission to reuse that checksum as workflow control or pseudo-exclusion.

New or changed workbench control MUST conform to this model. Existing
hash-dependent control and defensive protocols are not grandfathered in
because focused tests pass. Within an authorized change scope, simplify or
remove conflicting machinery while preserving required workflow behavior;
record out-of-scope nonconformance rather than performing an unrelated mass
refactor. Review MUST reject reintroducing the excluded mechanisms under names
such as integrity, freshness, consistency or safety without a distinct actual
requirement outside application control.
