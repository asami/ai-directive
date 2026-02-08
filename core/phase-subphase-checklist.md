# Phase / Subphase / Step / Checklist Rules

scope  = core
status = authoritative

This document is the single authoritative source for all Phase, Subphase, Step, Stage, and Checklist semantics in the AI Directive. It defines how labels, checklists, and stage status statements work together to make progress visible, auditable, and recoverable while preventing conflicting interpretations.

---

## 1. Purpose

These rules exist to:

- Make progress visible and auditable
- Prevent false completion signals
- Allow interruption and recovery without loss of context
- Align human and AI understanding of project state

This model is descriptive and operational, not ceremonial.

---

## 2. Core Principles

### 2.1 Phase Is a Label, Not a Workflow

A **Phase**:

- Names a broad objective or capability set
- Does **not** define a linear process
- Does **not** guarantee completion of contained work

Phases answer:

> “What kind of work is this project currently doing?”

They must not be used to avoid unfinished work.

### 2.2 Subphase Is a Scoped Focus

A **Subphase**:

- Narrows focus within a Phase
- Exists to bound discussion and execution scope
- May be entered, exited, and re-entered freely

Subphases are labels for attention, not gates.

### 2.3 Step Is a Structured Commitment

A **Step** bridges Subphase focus to the concrete checklist items that capture progress.

- Steps define the immediate scope of execution within a Subphase
- Each Step references the checklist items it progresses or validates
- Steps help Stage Status statements describe what is happening without redefining the checklist ledger

Steps are optional but recommended when a Subphase covers multiple distinct outcomes.

### 2.4 Checklist Is the Source of Truth

A **Checklist**:

- Enumerates concrete, verifiable items
- Represents the actual progress state
- Is the only authoritative indicator of completion

Narrative status without a checklist is non-authoritative.

---

## 3. Phase Semantics

### 3.1 Declaring a Phase

A Phase must have:

- A clear name
- A written purpose
- An associated checklist

A Phase may span multiple releases or time periods.

### 3.2 Phase Status

Typical Phase statuses include:

- `open`
- `in-progress`
- `closed`

A Phase must not be marked **closed** unless:

- Its checklist completion criteria are satisfied, or
- The remaining items are explicitly deferred and recorded

---

## 4. Subphase Semantics

### 4.1 Declaring a Subphase

A Subphase must:

- Belong to exactly one Phase
- Declare its focus explicitly
- Reference the checklist items it is responsible for

Subphases should be lightweight and short-lived.

### 4.2 Subphase Transitions

- Subphases may overlap
- Leaving a Subphase does not imply its checklist items are complete
- Re-entering a Subphase is allowed and expected

Subphases exist to structure effort, not to enforce order.

---

## 5. Step Semantics

### 5.1 Declaring a Step

A Step must:

- Belong to exactly one Subphase
- Define the immediate, observable goal that the Step’s checklist items follow
- Identify the checklist items or evidence that demonstrate completion

Steps often correspond to consecutive Stage Status observations, keeping Stage narratives synchronized with checklist ledger entries.

### 5.2 Step Transitions

- Steps may overlap when work spans multiple Stage Status observations
- Steps are evidence-driven; a Step is complete when its referenced checklist items are checked
- Steps may be subdivided further only by adding more checklist items or referencing sub-Steps explicitly within the Stage Status narrative

Steps are the binding layer between Subphase intent and Checklist reality.

---

## 6. Checklist Semantics

### 6.1 Checklist Items

Each checklist item must be:

- Concrete
- Observable
- Verifiable

Checklist items should describe outcomes, not activities.

### 6.2 Checklist States

Checklist items typically transition through:

- `[ ]` not started
- `[~]` in progress (optional)
- `[x]` completed

Additional states may be used if explicitly defined.

### 6.3 Completion Discipline

- A checklist item is complete only when its condition is met
- Partial completion must not be marked as complete
- Completion claims must be evidence-based

---

## 7. Stage Status and Checklist Relationship

Stages are narrative checkpoints that summarize checklist progress. Stages must rely on the checklist ledger described above.

### 7.1 Required Placement

Each Stage section must contain a Stage Status block. The Stage Status block must appear immediately after the Stage header.

### 7.2 Stage Status Block

Stage Status:
- Current status: `<OPEN | IN_PROGRESS | DONE | CLOSED>`
- Owner: `<human or team label>`
- Update rule: `<when and how this block must be updated>`

`Current status` must contain only a stable state name (e.g., Work in progress, DONE, CLOSED, BLOCKED). `Current step` may be added as an optional field to describe the active checklist step or sub-step, but completion judgment must be based on checklist state, not on `Current step` text.

### 7.3 Checklist Notation Rules

The checklist used in Phase/Subphase/Stage documents is a **state ledger**, not a task board.

- `[x]` **DONE / DECIDED**
  - The item is completed within the current Phase scope, **or** the item is **decided** in the current Phase as a *Future Development Candidate*.
  - If marked as a Future Development Candidate, the checklist line must include:
    - An explicit marker such as `(Future Development Candidate)`
    - A reference to the candidate list number, e.g. `DP-03`
  - No further work on this item is allowed in the same Phase.
- `[ ]` **OPEN**
  - The item is identified and in scope for the current Phase.
  - No implementation work has started yet.

Additional rules:

- Checklist entries must always represent a **stable state**.
- Checklist entries must not encode narrative intent such as “next phase assumption” or “future expectation”.
- Items not in scope for the current Phase must not be represented as OPEN.
- No checklist entry is ever deleted; reduction is allowed only by consolidating/merging it into another explicit item.
- Future Development Candidates must remain in the checklist. They are closed by marking the item as `[x]` with the required candidate marker and `DP-xx` reference.

These rules prevent ambiguity between unfinished work and intentionally deferred work, and provide a stable, machine-aligned reference model.

### 7.4 Checklist Relationship (Mandatory)

- Each Stage must include at least one explicit checklist.
- The Stage Status block must reference the checklist as the closure basis.
- A Stage is DONE or CLOSED only when all checklist items are checked.
- If any checklist item is unchecked, the Stage must not be marked DONE or CLOSED.

### 7.5 DONE / CLOSED Determination Rule

- **DONE:** All required checklist items are checked and no outstanding items remain.
- **CLOSED:** DONE plus any deferred items have explicit relocation targets outside the Stage.

### 7.6 Optional Progress Detail

In addition to the mandatory `Current status` field, a Stage may include an optional `Current step` field describing the active checklist step or sub-step. This field may give readers context, but completion must still be based solely on checklist state.

---

## 8. Relationship to Work (A/B/C)

- **Work A** corresponds to the primary checklist-driving effort
- **Work B** supports checklist progress
- **Work C** explores uncertainties affecting checklist items

Checklist progress must remain aligned with Work A.

---

## 9. AI Participation Rules

AI systems:

- Must treat checklists as authoritative state
- Must not infer completion from narrative alone
- Must surface unchecked or deferred items explicitly
- Must resist marking items complete without evidence

AI must not:

- Declare a Phase complete without checklist confirmation
- Invent new phases or subphases to simplify reasoning
- Ignore deferred items

---

## 10. Recovery and Continuity

Checklists enable recovery:

- An interrupted Phase must be resumable by reading its checklist
- Deferred items must be explicitly listed
- No progress may be “lost” due to context switching

A checklist is a **restart point**, not just a report.

---

## 11. Closing a Phase

A Phase may be closed only when:

- All checklist items are complete, or
- Remaining items are explicitly deferred, with rationale recorded

Deferred items must be tracked in:

- A future Phase, or
- A dedicated deferred list

Implicit abandonment is not allowed.

---

## 12. Summary

This model enforces a simple rule:

> **Labels describe intent.  
> Checklists describe reality.**

Phases, Subphases, and Steps organize thinking. Checklists determine truth. Stage Status blocks summarize progress against the checklist ledger so both humans and AI share a single view of completion.
