# Skill Authoring

## Scope and Authority

This shared core rule governs creating, changing and reviewing skills. It
covers `SKILL.md`, supporting instructions, helper programs, control-data
schemas, saved state and agent handoffs. Its place is defined by the
[Core Rule Map](AGENT.md#core-rule-map).

The coordination boundary below applies to skills generally. The subsequent
development-environment specialization applies to this Git-managed personal
development environment; it does not impose a single-user execution model on
unrelated production or multi-user environments.

## General Coordination Boundary

A skill describes a task and invokes operations; it MUST NOT become the owner
of a mutual-exclusion protocol among independent executions. Skill text, agent
messages and task-local state do not provide atomic synchronization or reliable
cross-process ownership and lifecycle guarantees.

- When mutual exclusion is actually required, delegate it to an established
  external execution or resource-management mechanism with those guarantees.
  The skill may invoke that mechanism and consume its authoritative result;
  it MUST NOT implement competing claims, ownership leases, lock arbitration,
  stale-lock recovery or contention retries as its own workflow protocol.
- External means that coordination and its lifecycle are owned outside the
  skill's workflow, not merely that lock code was moved into a helper file.
  Do NOT recreate the protocol in supporting scripts or handoff schemas.
- If the required external mechanism is absent, report the infrastructure or
  architecture gap. Developing it requires a separately authorized
  infrastructure scope, not a defensive addition to the skill.
- Do NOT add external coordination merely because it is available. An actual
  execution/resource requirement must need it. Git worktree, merge and
  pull-request handling govern development isolation and integration; they
  are not runtime locks for shared application resources.

## Development-environment Specialization

Skills for this personal development environment themselves are workbench
applications operated under the user's control, not multi-user coordination
services. This classification is not limited to applications a skill runs.
Read and apply [Single-user Git-managed Workbench Control](workbench-control.md)
before authoring them. That document owns the execution model, its rationale
from the 2026-10-02 sm-workflow policy journal, the management-hash prohibition
and minimal-checking policy. The following authoring requirements apply within
that model; they do not define a separate concurrency or integrity policy.

## Author the Actual Execution Model

- Keep the normal path within the requested development task and the user's
  control. Do NOT start from a multi-user design and later disable its defenses.
- Use Git worktrees, merges or pull requests for development isolation and
  integration. Multiple agents, tasks or worktrees do not justify competing
  writer claims or exclusion inside a skill's workflow control.
- Do NOT add management hashes, content-derived control identities, hash-based
  freshness gates or optimistic exclusion. Do NOT substitute revision-based
  exclusion, application locks, claims, writer leases or contention retries.
  A concrete need outside this model must be surfaced as an execution-model
  decision before adding a mechanism.
- Add state, persistence or a helper only when the workflow actually needs it.
  Do NOT generate extra records, snapshots, sidecars or control layers solely
  to protect against interference excluded by the execution model.

## Specify Needed Control in Types

- Where state or handoffs are needed, express states, transitions, ownership
  and reference relationships with dedicated types and validated construction.
  Do NOT replace a digest with an unconstrained string or freely construct
  incomplete, contradictory or invalid executable states.
- Use explicit identities and revisions for their semantic purpose, not as
  locking tokens. Compare relevant complete typed data when comparison is
  needed, not a digest; do not require comparison at every call boundary.
- Retain actual user direction and observed execution evidence where required.
  Stored references and claims are not authorization or proof of execution.
  Do NOT invent a hash-backed authority, receipt or fallback to fill missing
  evidence.

## Keep Checks and Stops Coherent

- Do NOT repeat checks already guaranteed by types and validated construction.
  Prefer useful construction/loading boundaries over scattered partial checks
  or continuous exhaustive monitoring. Remove an unjustified partial check
  rather than compensating with another defensive layer.
- On an actual contradiction, stop with a clear explanation. Do NOT invent
  automatic repair, arbitration or retry machinery to preserve an unnecessary
  control protocol.
- Keep external-input validation, real execution permissions and
  destructive-operation safety separate from internal consistency. Required
  storage transactions and independent SBT serialization remain governed by
  their own actual contracts; they are not skill-local pseudo-exclusion.

## Verify the Executable Contract, Not Only the Wording

- Keep instructions, mandatory gates, helper inputs, schemas and saved-state
  interpretation consistent. A prohibition in `SKILL.md` is insufficient if
  a mandatory helper still requires the prohibited mechanism. Do NOT advertise
  that route as executable or restore it as a fallback.
- For executable changes, verify the normal path and relevant stop/resume
  behavior proportionately. A passing focused test does not grandfather
  conflicting hash control or speculative defensive machinery.
- Apply the policy to new and changed skills. Simplify existing nonconformance
  within the authorized scope; record out-of-scope work rather than rewriting
  unrelated skills. A rule-document update alone is not evidence that existing
  helpers have been converted, tested or accepted.
