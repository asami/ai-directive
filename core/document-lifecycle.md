# Document Lifecycle

This rule defines how the various documentation layers interrelate. Each layer carries a distinct semantic weight and intended use:

- **Phase** records current engineering work state, scope, checklist status, and handoff position. It is a work-management layer, not a design or specification layer.
- **Notes** capture exploratory thinking, incident summaries, and hypotheses. They carry no binding force and may change or be discarded freely; they are explicitly non-normative.
- **Design** records decisions that must remain stable and defines the intended boundaries, responsibilities, and invariants of a feature or subsystem.
- **Spec** elaborates the behavior that the implementation must satisfy; it references rules, examples, and testable properties.
- **Journal** records chronological events (e.g., outages, releases, diary entries) and does not alter behavior.

## Lifecycle Model

Promotion follows the sequence **notes → design → spec**:

- an idea may start in notes
- mature into a design statement
- and finally be codified as a spec

At each hand-off the material should be reviewed for completeness, clarity,
and alignment with upstream rules.

`Phase` is not part of the promotion chain.
It exists in parallel as the current execution ledger for engineering work.

`Journal` is also outside the promotion chain.
It preserves historical traceability, but does not define behavior by itself.

## Layer Semantics

### Phase

- answers "where are we now?" and "what is next?"
- may record open / in-progress / closed status
- may hold checklists, handoff references, and current work boundaries
- must remain thin
- must not become a design note, reasoning log, or speculative proposal

### Notes

- exploratory only
- non-normative
- may be discarded or replaced freely

### Design

- stable design intent
- responsibilities, invariants, and boundaries
- not a work log

### Spec

- authoritative behavior contract
- implementation-facing requirements and testable properties

### Journal

- chronological record
- decisions, handoffs, retrospectives, incident summaries, and execution trace
- may explain why something happened
- must not introduce new normative behavior on its own

## Placement Rule

- Put current work tracking, phase status, and resumability information in `docs/phase`
- Put exploratory thinking and provisional analysis in `docs/notes`
- Put stable design intent in `docs/design`
- Put authoritative behavior contracts in `docs/spec`
- Put chronological trace and historical record in `docs/journal`

## Interpretation Rule

Because notes are exploratory, they remain unbounded and do not impose
requirements on implementation.

Because phase documents are operational ledgers, they do not become design or
spec authority merely by being current.

Because journal entries are historical records, they do not impose new
requirements unless the same content is promoted into design or spec.

No portion of this rule describes executable code or implementation-level
steps; it only governs documentation placement and expectations.
