# AGENT.md

## Purpose

- This repository treats Executable Specification as first-class documentation.
- Scala + functional programming minimizes example-based unit tests.
- Agents must follow the order: rules -> spec -> design -> code.

> Note on Symlinks and Local README
>
> This project exposes `AGENT.md` and `RULE.md` at the project root via symbolic links
> to shared authoritative documents under `ai/directive/core/`.
>
> These are not separate documents. They are the same canonical content,
> shared across adopting projects. File location never implies authority.
>
> `README.md` is NOT symlinked. It is a project-local document created from a template
> and edited for human-oriented overview. If `README.md` appears to conflict with
> `AGENT.md` or `RULE.md`, the symlinked core documents take precedence.

## How to Read This Repository (for Agents)

1. `AGENTS.md` (this file)
2. `RULE.md` (top-level rules for code, API, and AI behavior)
3. `README.md` (human-oriented overview and entry point)
4. `docs/rules/` (documentation rules and policies; see document-boundary.md first)
5. `docs/spec/` (static specifications)
6. `docs/design/` (design intent and boundaries; start with `docs/design/protocol-core.md`)
7. `src/main/scala/` (implementation)
8. `src/test/scala/` (Executable Specifications)

## Canonical Design Documents

- `docs/design/protocol-core.md`  
  Primary design entry for protocol boundaries and invariants.  
  MUST be read before modifying protocol-related code.

- `docs/design/protocol-introspection.md`  
  Projection / introspection design for CLI help, REST OpenAPI, MCP get_manifest.  
  Read this when working on projection generation.


## Executable Specification Policy

- `src/test/scala` stores Executable Specifications by default.
- Avoid simple example-based unit tests.
- Executable Specifications must:
  - use Given / When / Then structure
  - use Property-Based Testing (ScalaCheck) actively
  - read as behavior documentation


## Specification Categories (by Package)

Executable Specifications are organized by package.

### org.goldenport.protocol

- Fixes Protocol / Model semantics (semantic boundary).
- Covers datatype normalization and parameter resolution.
- Example:
  - `OperationDefinitionResolveParameterSpec.scala`

### org.goldenport.scenario

- Usecase -> usecase slice -> BDD specs.
- Scenario descriptions in Given / When / Then style.
- Human-readable behavior specifications.


## Rules / Spec / Design Boundaries

### rules

- naming rules
- **type modeling rule (abstract class vs trait)**: `docs/rules/type-modeling.md`
- spec style rules
- operation / parameter definition rules
- rules only; no exploration notes

### spec

- static specification documents
- linking to Executable Specifications
- specification itself, not executable

### design

- immutable design decisions
- boundaries, responsibilities, intent
- no exploration notes

### notes

- design exploration memos
- trial and error history
- not normative


## Do / Don't for Agents

### Do

- treat Executable Specifications as the source of truth
- keep Given/When/Then + PBT style
- preserve existing spec semantics
- confirm completion claims against the checklist ledger in `phase-subphase-checklist.md` before closing a stage or phase

### Don't

- change behavior without updating specs
- change meaning without Executable Specification
- refactor against rules or design guidance


## Core Rule Map

This section defines the **authoritative map of the core rule set**
under `ai/directive/core/`.

All agents MUST use this map to determine
which document governs a given question or decision.

---

### Entry Point

- **AGENT.md**  
  The mandatory entry point for all AI collaboration.

  Responsibilities:
  - Defines the role and expectations of the acting agent
  - Establishes the reading and priority order of core rules
  - Declares that **Executable Specs are the source of truth**
  - Requires completion claims to be validated against checklists

  If unsure where to start, start here.

---

### Normative Rules (Code-Level Contracts)

- **RULE.md**  
  The authoritative normative ruleset.

  Governs:
  - Naming conventions
  - Code-level contracts and invariants
  - AI-assisted change constraints
  - Context handling, logging, and defect semantics

  RULE.md defines **what MUST be obeyed** at the implementation level.
  It does not define process or progress semantics.

---

### Work and Execution Discipline

- **work-process.md**  
  The authoritative execution discipline.

  Governs:
  - Work A / B / C classification
  - Execution responsibility and completion rules
  - Resumability and interruption handling
  - The principle that work is not complete unless execution succeeds

  References checklist-based completion defined elsewhere.

---

### Progress and Completion Semantics

- **phase-subphase-checklist.md**  
  The **single authoritative source** for progress semantics.

  Governs:
  - Phase, Subphase, and Step definitions
  - Stage status (open / in-progress / closed)
  - Checklist structure and ledger rules
  - DONE / CLOSED semantics and deferral handling
  - AI obligations regarding progress reporting

  All completion and closure claims MUST be validated here.

---

### Documentation Semantics and Lifecycle

- **document-lifecycle.md**  
  The authoritative documentation lifecycle definition.

  Governs:
  - Semantic roles of notes, design, spec, and journal
  - Promotion rules between documentation layers
  - Authority and interpretation constraints

  Determines when a document becomes normative.

---

### Executable Specification Style

- **spec-style.md**  
  The authoritative specification writing guide.

  Governs:
  - Executable Spec structure and conventions
  - Given / When / Then semantics
  - Placement and organization of specs
  - Criteria for spec completeness

  References:
  - `document-lifecycle.md` for lifecycle authority
  - `phase-subphase-checklist.md` for checklist-driven completion

---

### Interpretation Rules

When multiple documents are involved:

1. Start from **AGENT.md** to determine intent and priority.
2. Apply **RULE.md** for any normative or code-level constraint.
3. Use **work-process.md** for execution responsibility.
4. Use **phase-subphase-checklist.md** to determine progress and completion.
5. Use **document-lifecycle.md** and **spec-style.md** for documentation and specs.

If two documents appear to conflict,
the document higher in this map takes precedence,
or the conflict MUST be surfaced explicitly.

---

### Extension Rule

New core documents MUST:

- Declare their scope explicitly
- Reference this Core Rule Map
- Avoid redefining concepts already owned by another document

There MUST be exactly one authoritative definition source
for each core concept.

---

### Summary

This Core Rule Map ensures that:

- Authority is explicit
- Definitions are non-overlapping
- Progress is verifiable
- AI and humans share the same execution reality

All agents are expected to navigate the core rules
using this map as their guide.

END OF AGENTS.md
