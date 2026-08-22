# AGENT.md

## Purpose

- This repository treats Executable Specification as first-class documentation.
- Scala + functional programming minimizes example-based unit tests.
- Agents must follow the order: rules -> spec -> design -> code.

> Note on Symlinks and Local README
>
> Adopting projects expose `AGENT.md`, `AGENTS.md`, and `RULE.md` at the
> project root via symbolic links to shared authoritative documents under
> `ai/directive/core/`.
>
> These are not separate documents. They are the same canonical content,
> shared across adopting projects. File location never implies authority.
>
> `README.md` is NOT symlinked. It is a project-local document created from a template
> and edited for human-oriented overview. If `README.md` appears to conflict with
> `AGENT.md` or `RULE.md`, the symlinked core documents take precedence.

## Repository-Local Extensions

Root directive files MUST remain shared symlinks. Repository-specific
information belongs in these conventional files:

- `docs/rules/repository-rules.md`
  - normative repository-specific rules and architecture boundaries;
  - may add detail to the shared rules;
  - must not silently contradict the shared rules.
- `docs/ai/repository-agent-guide.md`
  - repository reading order, canonical documents, package-specific guidance,
    and operational notes for agents;
  - is guidance and must not override rules, specs, or design.
- `docs/rules/shared-directive-exceptions.md`
  - explicit, reviewed exceptions to shared rules;
  - use only when a real repository contract requires an exception.

When present, agents MUST read the repository-local rule and guide before
editing. The authority order is:

1. shared `RULE.md`;
2. `docs/rules/repository-rules.md`;
3. explicit exceptions in `docs/rules/shared-directive-exceptions.md`;
4. specs and design for the affected subsystem;
5. non-normative agent guidance and notes.

## How to Read This Repository (for Agents)

1. `AGENTS.md` or `AGENT.md` (this shared entry point)
2. `RULE.md` (shared code, API, and AI behavior rules)
3. `docs/rules/repository-rules.md`, when present
4. `docs/ai/repository-agent-guide.md`, when present
5. `README.md` (human-oriented overview and entry point)
6. remaining documents under `docs/rules/`
7. `docs/spec/`
8. `docs/design/`
9. `src/main/scala/`
10. `src/test/scala/`

## Command-Group Execution Policy

Agents MUST classify an execution request before invoking a command:

- Publication: classify local/warehouse and remote/public publication
  separately before SBT. An explicit `$cncf-lib-publish`, `$cncf-car-publish`,
  `$cncf-car-publish-recursive`, or equivalent explicit user request is the
  sole semantic authorization for its discovered exact publication scope. For
  remote `publish`, the parent MUST freeze and attach a matching Publication
  Authorization Envelope and current Publication Execution Binding to the
  registered `cncf_command_runner` delegation; the runner accepts that
  parent-authoritative evidence without asking the user to run `sbt publish`
  manually or repeat approval. Scoped execution escalation remains separate
  and required. For local/warehouse publication, use the project-declared
  local publication task through the SBT group; never substitute it for public
  release publication. If explicit publication authority, a matching binding or
  envelope, target, version, or dependency order is absent or ambiguous, stop
  and report the exact blocker; never use manual `sbt publish` as a workaround.
- Top-level SBT, including a script that starts SBT and any local/warehouse
  publication task after its Publication classification: registered
  `cncf_command_runner` plus the shared `cncf-sbt-serial-execution` wrapper.
  The first attempt requests scoped escalation for normal SBT boot/home,
  dependency, and local-artifact caches. Direct or sandbox-only SBT and
  isolated-cache or symlink permission workarounds are prohibited. Accept
  completion only with terminal lock-release evidence. A boot-lock denial is
  an execution-permission failure, not a project build, test, or publish
  failure, and stops for a correctly privileged rerun.
- Exact Cozy or Dox CLI: registered `cozy_command_runner`, with first-attempt
  scoped escalation.
- Reviewed one-shot project script or launcher: registered
  `cncf_runtime_runner`.
- Long-lived script or launcher with readiness or session ownership: registered
  `cncf_runtime_session_runner`.
- Frozen Commit Manifest: registered `cncf_commit_runner`, which stages and
  commits only the manifest and never edits files.
- Planning, inspection, normal shell or Git utilities, semantic decisions, and
  editing: parent agent, except an applicable workflow may separately assign an
  admitted editing worker.

If the required runner is unavailable or scoped escalation is denied, stop and
report; never fall back to direct execution or another command group.


## Executable Specification Policy

- `src/test/scala` stores Executable Specifications by default.
- Tests should be written as Executable Specifications by default.
- Avoid simple example-based unit tests.
- Executable Specifications must:
  - use Given / When / Then structure
  - place Given / When / Then at the setup / action / expectation boundaries
  - use `should` matchers or reusable specification vocabulary instead of bare `assert`
  - use `should` / `which` / `in` grouping for large behavior surfaces
  - use Property-Based Testing (ScalaCheck) actively
  - read as behavior documentation

## Implementation-Time Naming Gate

Agents MUST apply `RULE.md` naming while creating Scala source and specs, not
after review. Do not draft new code using ordinary Scala lowerCamel names and
then rely on review, `sbt`, or release checks to find violations. Before adding
a class, trait, enum, object, type alias, method, value, helper, parameter,
local variable, private case class field, or spec fixture helper, determine its
declaration category and visibility/scope and choose the rule-compliant name
immediately.

Common authoring rules that MUST be applied up front:

- classes, case classes, traits, enums, objects, case objects, and type aliases:
  `UpperCamelCase` without a leading or trailing underscore, regardless of
  visibility; companion objects use exactly the companion class name;
- public API and required overrides: `camelCase`;
- public and protected method parameters: `camelCase`, because parameter names
  are source API through Scala named arguments;
- private member methods/values declared with `def`, `val`, `var`, or
  `lazy val`, including spec helpers: `_snake_case`; do not apply this rule to
  `object` declarations;
- method-local helper functions: `_snake_case_`;
- private method parameters and ordinary local variables: flatcase;
- internal private model fields: flatcase unless they are serialized/public
  schema fields or required overrides.

Named-argument labels MUST follow the callee declaration. A deprecated label,
compatibility alias, or `@deprecatedName` annotation does not make a
nonconforming canonical public/protected parameter name compliant. Rename the
canonical parameter and its call sites when applying this rule; retain a
compatibility label only when an explicit compatibility contract requires it.

This is an authoring requirement, not a cleanup checklist. A naming issue found
by review in newly created code should be treated as a process failure.

## Structured Failure Policy

- Treat `Consequence.failure("...")` as a last resort only.
- Treat `Consequence.fail(...)` as the low-level structured failure builder for
  application-side or library-side cases where a semantic utility does not exist
  yet and the caller must provide taxonomy, cause, and facets explicitly.
- Prefer structured failures using `Observation`, `Taxonomy`, `Cause`, `Conclusion`,
  and typed `Consequence` utility methods.
- New `Consequence` error utilities should use the error name itself, for example
  `notImplemented(message)` or `securityPermissionDenied(message)`.
- Do not add new `failXxx(...)` utility names. Existing `failXxx(...)` helpers are
  deprecated legacy aliases and should be migrated gradually when touched.
- This applies to both `Consequence.failXxx(...)` and `Conclusion.failXxx(...)`
  compatibility aliases.
- When an error category is missing, extend the Observation / Taxonomy vocabulary
  and add suitable `Conclusion` / `Consequence` helpers instead of introducing
  new string-only failures.
- When a direct `Consequence.fail(...)` call becomes repeated or semantically
  recognizable, add a named utility and migrate the call sites to that utility.
- Existing string-only failures should be migrated incrementally when touched.


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
- **Scala 2 / Scala 3 type-modeling rule**: `type-modeling.md`
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

### SmartDox Authoring Rules

- **smartdox-authoring.md**
  The mandatory authoring rules for public-facing SmartDox `.dox` documents and generated Dox scaffolds.

  Governs:
  - Dox section title termination and metadata subsection spacing
  - SmartDox-vs-Markdown authoring differences
  - parser/API source-of-truth requirements for Dox metadata

  Read this before editing or generating `.dox` files.

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

### Scala 2 / Scala 3 Type Modeling

- **Scala 2 / Scala 3 type-modeling rule**: `type-modeling.md`
  Governs semantic type selection for Scala 2 and Scala 3.

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
