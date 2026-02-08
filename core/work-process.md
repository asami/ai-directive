# Work Process Rules

This document defines the **authoritative work process model**
for projects operating under the AI Directive.

It governs how work is structured, advanced, paused, resumed,
and completed by humans and AI systems.

scope = core
status = authoritative

---

## 1. Purpose

These rules exist to ensure that:

- Work progresses intentionally
- Partial progress is visible and resumable
- AI assistance does not fragment or derail execution
- Engineering effort converges toward runnable outcomes

This document defines **process discipline**, not project policy.

---

## 2. Core Principles

### 2.1 Work Is Primary

All activity MUST be associated with a clearly identified **Work**.

- Discussion without a Work context is non-authoritative
- Exploration is allowed only if its relationship to Work is stated

The primary question at all times is:

> **What is the current Work?**

---

### 2.2 Work Completion Rule

A Work is NOT complete unless:

- The program runs, or
- The defined execution outcome is achieved

Checklist-led progress reporting and Stage Status declarations must align with `phase-subphase-checklist.md`, which defines the canonical ledger for determining when Work can be considered complete.

Documentation-only progress does not complete a Work
unless the Work is explicitly documentation-scoped.

---

### 2.3 No Escape by Reframing

The following are NOT allowed as a way to avoid difficulty:

- Creating a new Phase
- Redefining scope mid-Work
- Declaring items “out of scope” without resolution

If a Work is difficult, it must be **confronted**, not bypassed.

---

## 3. Work Classification

### 3.1 Work A / B / C

Work is classified into three categories:

- **Work A** — Primary execution work  
  The main task whose completion defines progress.

- **Work B** — Supporting or preparatory work  
  Tooling, refactoring, documentation, or setup required to advance A.

- **Work C** — Exploratory or investigative work  
  Hypotheses, experiments, or probes that may inform A or B.

Rules:

- At any time, exactly one Work A MUST be identified.
- Work B and C MAY occur, but MUST explicitly support Work A.
- Work MUST always return to Work A.

---

### 3.2 Declaring Work

Each Work SHOULD have:

- A short identifier (e.g. A-1, B-2)
- A clear completion condition
- A recorded current state

Work declarations MAY live in:

- `docs/work/`
- `docs/journal/`
- Session context (temporarily)

---

## 4. Phase and Stage Semantics

### 4.1 Phases Are Labels, Not Control Flow

Phases and Stages:

- Describe *where* the project is
- Do NOT prescribe *how* work must proceed

They are:

- Non-linear
- Re-enterable
- Descriptive only

---

### 4.2 Stage Advancement

Advancing a Stage:

- Does NOT imply completion of all related Work
- MUST NOT invalidate unfinished Work

Stages MAY overlap.
Work continuity is more important than stage purity.

---

## 5. Execution Discipline

### 5.1 Explicit Execution Boundary

AI systems MUST distinguish between:

- **Design / reasoning**
- **Execution / modification**

Execution requires:

- Explicit instruction
- Clear scope
- Runnable end condition

AI MUST NOT perform execution implicitly.

---

### 5.2 Resumability Requirement

At any interruption point, the state MUST be:

- Recoverable
- Explainable
- Restartable without guesswork

This implies:

- Clear Work identification
- Recorded decisions
- Avoidance of hidden state

---

## 6. AI Participation Constraints

AI systems:

- MUST help clarify Work boundaries
- MUST surface incomplete or missing completion conditions
- MUST resist over-fragmentation of tasks
- MUST ask to stop if multiple interpretations exist

AI MUST NOT:

- Invent new Phases to simplify reasoning
- Close Work without execution evidence
- Substitute process theory for actual progress

---

## 7. Failure Handling

Failure is treated as:

- Information
- Input to Work refinement

On failure:

- The current Work remains active
- Causes SHOULD be recorded
- Work MAY be re-scoped, but not abandoned

---

## 8. Completion and Closure

A Work MAY be closed only when:

- Completion conditions are met
- Or it is explicitly superseded by another Work
  with rationale recorded

Closed Work SHOULD be recorded in `docs/journal`.

---

## 9. Summary

These rules enforce a simple discipline:

- Always know what Work you are doing
- Finish what you start
- Do not escape difficulty by process manipulation
- Treat AI as a disciplined collaborator

The goal is not speed, but **steady, resumable progress**.
