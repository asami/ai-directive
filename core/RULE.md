> Note on Authority and Local README
>
> This `RULE.md` may be accessed from the project root or from `ai/directive/core/`
> via symbolic links. All such references point to the same authoritative rule set.
>
> `README.md` is a project-local document edited from a template and is not authoritative
> for normative behavior. When guidance conflicts, `AGENT.md` and `RULE.md` take precedence.

Naming Conventions (2025-12-26)
==================

This document defines the naming conventions used in the programs on this site.

These conventions are introduced to improve the readability of example code.
They are **not intended as general recommendations**, but as project‑specific rules
to keep the codebase consistent and easy to read.

## Scope Clarification

`RULE.md` contains the normative code-level naming, lifecycle, and AI-change contracts. Process and progress semantics—such as Work A/B/C discipline and checklist status reporting—live in `work-process.md` and `phase-subphase-checklist.md`. Documentation-layer semantics and placement rules live in `document-lifecycle.md`. Together, these documents form the dedicated canon for work, checklist, and document governance referenced by agents.

# Release and Local Publish Safety

Published release versions are immutable.

- Do NOT modify source, commit changes, or run `publishLocal`, `publishM2`, or
  equivalent local-publication tasks while the project is on a published release
  coordinate such as `version := "x.y.z"`.
- Before fixing code for a published artifact, bump the project to the next
  development coordinate, such as `x.y.(z+1)-SNAPSHOT`, in the same change set.
- A fix commit under the original release coordinate is forbidden, even when the
  release artifact is not locally published.
- Do NOT locally publish an artifact using the same coordinate as an already
  published release version, even for temporary validation.
- Published release artifacts MUST be validated through the normal repository
  resolution path into the dependency cache. Do not validate a release by
  placing the same coordinate in `.ivy2/local`, local Maven, or another
  local-publication repository.
- If a release coordinate was accidentally installed locally, remove that local
  publication before testing downstream dependency resolution.
- Development changes that need local publication MUST use a SNAPSHOT or otherwise
  clearly development-only version.
- If a project is currently on a release version and local validation requires a
  published artifact, first change the development coordinate to a SNAPSHOT
  version or use a project/dev-dir launcher path that does not overwrite release
  coordinates.
- If a published artifact needs a fix before the next release, do not reuse the
  published release coordinate. Bump the development coordinate to a strictly
  higher `-SNAPSHOT` version and make downstream projects depend on that
  SNAPSHOT until the next release is cut.
- The replacement SNAPSHOT must be distinguishable from both the published
  release and any already-consumed local SNAPSHOT. Prefer incrementing the next
  patch or minor version, for example `0.1.3` to `0.1.4-SNAPSHOT`.

Rationale:
- Local publication of release coordinates makes the local machine disagree with
  public repositories.
- It can hide release reproducibility problems and contaminate later builds.
- Tools such as Ivy and Coursier may cache release artifacts aggressively, making
  overwritten local releases unreliable and difficult to reason about.
- Local publication of a release coordinate bypasses the repository-to-cache
  route that downstream projects must actually use.

# AI Directive Submodule Operation

`ai-directive` is an external, versioned contract when mounted in a consuming
project as `ai/directive`.

- Do NOT edit files under a consuming project's `ai/directive` submodule working
  tree to change shared directive behavior.
- Shared directive changes MUST be made in the standalone `ai-directive`
  repository first.
- Consuming projects MUST receive directive changes by updating the
  `ai/directive` submodule pointer to a committed directive revision.
- If local validation needs a directive change before publication, use an
  explicitly coordinated branch or commit of the standalone `ai-directive`
  repository, then update the consuming project's submodule pointer. Do not leave
  uncommitted directive edits inside the consuming project.
- Project-specific rules may be added outside `ai/directive`, but they MUST NOT
  mutate or contradict the shared directive unless an explicit exception is
  documented.

## Repository-Local Rule Location

Adopting repositories MUST expose the shared directive through root symlinks:

```text
AGENT.md  -> ai/directive/core/AGENT.md
AGENTS.md -> ai/directive/core/AGENT.md
RULE.md   -> ai/directive/core/RULE.md
```

Repository-specific normative rules MUST be placed in
`docs/rules/repository-rules.md`. Repository-specific agent reading guidance
MUST be placed in `docs/ai/repository-agent-guide.md`.

Do not maintain copied or independently edited root `AGENT.md`, `AGENTS.md`, or
`RULE.md` files. A repository-specific rule may add detail to the shared
contract but must not silently contradict it. A required exception must be
declared explicitly in `docs/rules/shared-directive-exceptions.md`.

# Naming Authoring Discipline

Naming rules MUST be applied while code is being written. They are not a
post-implementation lint checklist. Agents and contributors MUST NOT create new
Scala code using ordinary Scala lowerCamel conventions for private helpers,
parameters, local variables, or internal private model fields and then defer
cleanup to review.

Before introducing a new Scala identifier, first decide its scope:

- class, case class, trait, enum, object, case object, or type alias,
  regardless of visibility -> `UpperCamelCase` without a leading or trailing
  underscore;
- public API or required override -> `camelCase` where the public API requires it;
- public/protected method parameter -> `camelCase`; Scala named-argument labels
  make these parameter names part of the source API;
- protected member -> snake_case without leading underscore unless an override
  role rule says otherwise;
- private member method/value (`def`, `val`, `var`, or `lazy val`), including
  spec fixture helpers -> `_snake_case`; this rule does not apply to `object`
  declarations;
- method-local helper -> `_snake_case_`;
- private method parameter or ordinary local variable -> flatcase;
- private/internal case class field -> flatcase unless it is a serialized/public
  schema field, Java/Scala API compatibility field, or required override.

Review finding a naming violation in newly created code indicates that the
authoring process was not followed. Moving the same check to `sbt` does not fix
the problem; the correction point is identifier creation.

# Type and Structural Declaration Names

- Classes, case classes, traits, enums, objects, case objects, and type aliases
  MUST start with an uppercase letter and use `UpperCamelCase`.
- This rule applies equally to public, protected, package-private, and private
  declarations, including nested declarations.
- These declaration names MUST NOT have a leading or trailing underscore.
- A companion object MUST use exactly the same name as its companion class.
- The private `_snake_case` rule applies only to term members declared with
  `def`, `val`, `var`, or `lazy val`; it MUST NOT be applied to an `object`
  merely because a Scala object is also a stable value.

Valid:

```scala
private class ImportSource
private object ImportSource
private val _import_source: ImportSource
private def _resolve_import_source(): ImportSource
```

Invalid:

```scala
private class _ImportSource
private object _ImportSource
private object _import_source
```

### Example

```
case class PurchaseOrder()
```

# Method Names

Naming rules for methods vary depending on their visibility and scope.

## Public Methods

- Start with a lowercase letter
- Use camelCase

### Example

```
def purchaseOrder(cmd: PurchaseOrder): Consequence[PurchaseResult]
```

## Protected Methods

- Start with a lowercase letter
- Use snake_case
- This is the default protected method rule. Override-oriented protected hooks
  use the `xxx_Yyy` form described in
  [Role Categories for Protected Methods](#role-categories-for-protected-methods).

### Example

```
protected def purchase_order(cmd: PurchaseOrder): Consequence[PurchaseResult]
```

## Private Methods


- Start with an underscore (`_`)
- Use snake_case

### Example

```
private def _purchase_order(cmd: PurchaseOrder): Consequence[PurchaseResult]
```

#### Trailing Underscore Prohibition

- Private helper methods MUST use **only a single leading underscore**.
- Trailing underscores MUST NOT be used unless required to escape Scala keywords.

Valid:
```
private def _parameter_definition(...)
```

Invalid:
```
private def _parameter_definition_(...)
```

Rationale:
- A leading underscore expresses internal scope.
- Trailing underscores introduce artificial or generated semantics
  and reduce readability.

#### Private vs Method-Local Helper Naming

This project distinguishes **private member helpers** from
**method-local helper functions** by underscore placement.

##### Private Member Helpers

- Represent class-level or object-level implementation details
- May be referenced from multiple methods
- MUST use a single leading underscore
- MUST NOT use trailing underscores

Example:
```
private def _resolve_config(key: String): Value
private val _default_priority: Int
```

##### Method-Local Helper Functions

- Defined inside a method body
- Intended to be short-lived, local utilities
- MUST start and end with an underscore

Example:
```
def load(): Result =
  def _parse_value_(raw: String): Parsed =
    ...
  ...
```

Rationale:
- Leading underscore indicates non-public scope
- Trailing underscores clearly signal *method-local lifetime*
- This visual distinction improves readability and prevents
  accidental promotion of local helpers to class-level APIs

## Method‑Local Helper Methods

- Start and end with an underscore (`_`)
- Use snake_case

### Example

```
def _validate_order_(cmd: PurchaseOrder): Boolean
```

# Variable Names

Naming rules for variables also depend on visibility and scope.

## Public Variables

- Start with a lowercase letter
- Use camelCase

### Example

```
val reservationCount: Int
```

## Protected Variables

- Start with a lowercase letter
- Use snake_case

### Example

```
protected val reservation_count: Int
```

## Private Variables

- Start with an underscore (`_`)
- Use snake_case

### Example

```
private val _reservation_count: Int
```

## Method Parameters

Method parameter naming follows method visibility because Scala exposes
parameter names as named-argument labels and therefore as source API.

### Public and Protected Method Parameters

- Start with a lowercase letter.
- Use camelCase.
- Preserve the parameter names required by an overridden parent API.

### Example

```
protected def authorizeAggregate(
  aggregateName: String,
  targetId: EntityId
): Result
```

### Private Method Parameters

- Start with a lowercase letter.
- Use flatcase (all lowercase, no separators).

### Example

```
private def _authorize_aggregate(
  aggregatename: String,
  targetid: EntityId
): Result
```

### Named Arguments and Migration

- A named-argument label MUST use the parameter name declared by the callee.
- Calls to an external or public/protected camelCase API keep camelCase labels
  even when the local value is flatcase, for example
  `aggregateName = aggregatename`.
- Calls to a private flatcase API use flatcase labels.
- A deprecated label, compatibility overload, forwarding alias, or
  `@deprecatedName` annotation does not make a nonconforming canonical
  public/protected parameter name compliant.
- When this rule is applied to an existing public/protected flatcase
  parameter, rename the canonical parameter and update named-argument call
  sites. Keep a compatibility label only when an explicit source-compatibility
  contract requires it; do not introduce one merely to avoid completing the
  naming migration.

## Method‑Local Variables

- Start with a lowercase letter
- Use flatcase

### Example

```
val rc: Int = ???
```

## Constants

- Use SCREAMING_SNAKE_CASE

### Example

```
val RESERVATION_COUNT: Int = ???
```

# Naming Aids for API Safety and Stability

This section defines auxiliary naming rules that express **API safety, trust level, and stability**
directly in method and class names.

These name properties act as *lightweight contracts* for readers, reviewers, and tools,
and are especially important at component and componentlet boundaries.

## Visibility-Aware Composition Rule

When safety or stability properties are attached to a method name,
they must follow the visibility-based naming rules already defined.

- **Public methods** use camelCase
- **Protected methods** use snake_case
- **Private methods** use snake_case with a leading underscore
- Name properties are composed as semantic modifiers, not as part of the base verb

### Examples

Public:
```
def experimentalParseUnsafe(input: String): Ast
```

Protected:
```
protected def experimental_parse_unsafe(input: String): Ast
```

Private:
```
private def _experimental_parse_unsafe(input: String): Ast
```

---

## Experimental

### Meaning

- The API contract is not yet stable
- Signature, semantics, or existence may change in future releases

### Naming Rule

Prefix:
```
experimental
```

Snake case:
```
experimental_
```

### Example

```
def experimentalStreamApply(cmd: Command): Result
protected def experimental_stream_apply(cmd: Command): Result
```

---

## Unsafe

### Meaning

- Validation, checks, or error handling are intentionally skipped
- May throw exceptions or cause undefined behavior
- The caller bears full responsibility

### Naming Rule

Suffix:
```
Unsafe
```

Snake case:
```
_unsafe
```

### Requirements

- A safe alternative **must exist** when exposed publicly
- Unsafe behavior must never be hidden behind a neutral name

### Example

```
def parse(input: String): Either[ParseError, Ast]
def parseUnsafe(input: String): Ast
```

```
protected def parse_unsafe(input: String): Ast
```

---

## Unchecked

### Meaning

- Preconditions are assumed to be satisfied
- Typically used for internal or framework-level APIs
- Safer than `Unsafe`, but still trust-based

### Naming Rule

Suffix:
```
Unchecked
```

Snake case:
```
_unchecked
```

### Example

```
protected def load_unchecked(id: Id): Entity
private def apply_unchecked(cmd: ValidatedCommand): Result
```

---

## Composition Order

When multiple name properties are combined, they must appear
in the following order (from strongest to weakest):

```
experimental > unsafe > unchecked
```

### Valid Examples

```
experimentalParseUnsafe
experimentalLoadUnchecked
```

Snake case:
```
experimental_parse_unsafe
experimental_load_unchecked
```

### Invalid Examples

```
unsafeExperimentalParse
uncheckedUnsafeApply
```

---

## Additional Recommended Name Properties

The following properties may be attached to method or class names
when they add clear semantic value.

### Internal

Indicates framework-internal usage and non-public contracts.

```
internalResolveDependency
internal_resolve_dependency
```

### Temporary

Indicates short-lived or transitional code that should be removed.

```
temporaryFixRouting
temporary_fix_routing
```

### Legacy

Indicates deprecated or backward-compatibility behavior.

```
legacyApplyRule
legacy_apply_rule
```

### Derived

Indicates computed or synthesized behavior rather than primary state.

```
derivedStatus
derived_status
```

## Execution naming

- execute: evaluate or run a prepared expression/program (algebra evaluation)
- run: drive an interpreter or execution process
- prepare: build meaning/structure only (expression/program/AST), no execution

Do not mix these responsibilities in a single API.

## Collection idiom

Collection/Group types MUST provide:
- a canonical empty value
- a zero-arg apply() for binary compatibility

---


## Design Principles



# AI Incremental Change Rule

This rule defines mandatory constraints when using AI-assisted tools
(e.g. Codex, ChatGPT, Copilot) to modify existing code in this project.

## Core Principle

AI-assisted changes MUST be **incremental by default**.

Unless explicitly stated otherwise, AI tools are NOT permitted to
rewrite, redesign, or refactor existing implementations.

This rule exists to prevent accidental responsibility shifts,
architectural drift, and silent semantic changes.

## Default Constraints (Mandatory)

When requesting AI-assisted code changes, the following constraints apply
unless the instruction explicitly overrides them.

AI tools MUST NOT:

- Rewrite entire files
- Replace existing algorithms wholesale
- Change class or method responsibilities
- Introduce new abstractions or layers
- Rename public classes or methods
- Add features not required by the working specification
- Perform refactoring, optimization, or “cleanup”

AI tools MUST:

- Modify only the minimum number of lines required
- Preserve existing logic, structure, and comments
- Treat existing implementations as correct by default
- Follow the working specification exactly
- Prefer small, local changes over global edits

## Working Specification Priority

When a working specification (ScalaTest) exists:

- The working specification is the **single source of truth**
- Behavior not required by the spec MUST NOT be implemented
- Improvements or extensions MUST be introduced only via new specs

Spec > Existing Code > AI Intuition

When in doubt, AI tools must **do less**, not more.

## Explicit Rewrite Permission

Full rewrites or redesigns are allowed ONLY when the instruction
contains an explicit rewrite directive, such as:

- "rewrite entirely"
- "full redesign"
- "replace the implementation"

In the absence of such phrases, incremental change is mandatory.

## Scope Awareness Rule

AI tools must respect the intended scope expressed by names,
packages, and surrounding context.

For example:

- `CommandResolver` resolves command names only
- It does NOT implement command search engines,
  ranking systems, or discovery mechanisms

Expanding scope beyond the working specification
constitutes a rule violation.

## Design Intent

This rule ensures that AI-assisted development:

- Remains predictable and reviewable
- Preserves architectural intent
- Scales safely as specifications evolve
- Treats AI as a controlled collaborator, not an autonomous designer

- Names must clearly communicate **risk, trust, and stability**
- Dangerous behavior must never be implicit
- Naming is part of the API contract, not an implementation detail

# Source Size and Responsibility Rule

This rule keeps hand-written source and Executable Specifications small enough
to understand, review, and change safely. Line counts are review triggers, not
substitutes for responsibility analysis.

## Scope And Exceptions

This rule applies to hand-written product source and Executable Specifications.
Generated output, vendored or third-party code, build output, and intentionally
tabular static data are excluded. A repository may define a reviewed exception
in `docs/rules/shared-directive-exceptions.md` when one physical file is part of
a required external or generated contract.

Reviewers MUST consider both the physical file and its primary class, trait,
enum, or object. Multiple independent top-level definitions in one file are
themselves evidence that a file split may be appropriate.

## Ordinary Source Size Guidance

For an ordinary class, trait, enum, object, or its primary source file:

- 200 to 500 lines is the preferred working range.
- 500 to 800 lines is acceptable when the source still has one cohesive
  responsibility.
- At 800 to 1,000 lines, authors and reviewers MUST actively evaluate a split.
- More than 1,000 lines is source-size debt by default and requires either a
  recorded split disposition or a documented exception.
- 1,500 lines is the normal upper limit for hand-written ordinary source.
- More than 2,000 lines is high-priority source-size debt and MUST NOT be
  introduced as a new ordinary source file without an explicit exception.

Line count is not the only trigger. A split MUST also be considered when any of
the following makes the source difficult to review as one responsibility:

- more than roughly 15 to 20 public methods;
- three or more independently changing responsibilities;
- more than roughly 7 to 10 constructor dependencies;
- several private helper groups that can be named as independent roles;
- multiple unrelated reasons to change the same class or file;
- a reviewer cannot explain the whole source and its invariants in one bounded
  review pass.

Crossing one approximate structural threshold does not automatically require a
split when the source remains cohesive. Crossing the line-count debt threshold
does require an explicit review disposition.

## Executable Specification Size Guidance

Executable Specifications may be larger than ordinary classes because they
serve as behavior documentation, but they MUST remain reviewable:

- Prefer 50 to 80 behavior examples or fewer in one Spec.
- Treat roughly 100 behavior examples as the normal upper limit for one Spec.
- Prefer 3,000 to 5,000 lines or fewer in one Spec.
- More than 5,000 lines or 100 behavior examples is specification-size debt by
  default and requires a split disposition or documented exception.
- Keep one example's Given / When / Then flow focused; roughly 3 to 7 major
  steps is the normal readable range.

Split Specs by observable behavior surface, not by arbitrary line ranges. A
split MUST preserve executable coverage and the semantic grouping expressed by
`should`, `which`, `in`, and Given / When / Then.

## Review Detection And Disposition

Every source review MUST check touched source files and directly affected source
files for source-size debt. The review report MUST classify each newly detected
item in exactly one of these ways:

1. **Current Review Finding / FIX**
   - Use this when the correction is a mechanical file split.
   - The split may add the destination file or files and update the original
     file, but it requires no changes to any other existing source file.
   - It MUST preserve behavior, public API, package identity, initialization
     order, serialization, lifecycle, and dependency direction.
   - It MUST be small enough to validate inside the current review-fix cycle.
   - Once admitted by review, this rule is explicit authorization for that
     bounded split despite the default no-refactoring rule above.

2. **Existing Debt / Hygiene Follow-up**
   - Use this when a safe split requires changes to any other existing source
     file, including call sites, imports, public or protected APIs, dependency
     injection, wiring, lifecycle, serialization, ABI, or broad specification
     restructuring.
   - Record the item in the active Phase Hygiene Ledger with a stable ID,
     affected source, reason the split is non-local, and intended follow-up
     Phase, Step, or task.
   - Do not expand the current review-fix scope to perform this work.

A pre-existing oversized source is not automatically a release blocker merely
because of its size. It becomes a current blocker when the active change makes
the debt worse, creates a new oversized source, depends on an unsafe structure,
or the size/responsibility problem contributes to a correctness or reviewability
failure in the current scope. A correctness defect MUST remain a normal finding;
it MUST NOT be downgraded to Hygiene merely because splitting the source is
large or difficult.

Reviewers MUST report the measured line count, the threshold crossed, the
responsibility evidence, and the selected FIX or Hygiene disposition. Authors
MUST NOT evade the rule with cosmetic whitespace removal, compressed formatting,
or arbitrary partial extraction that leaves the same responsibility tangle.

## AI Interaction Command Catalog

AI-assisted development in this project uses a standardized
**command shorthand catalog** to control and constrain AI behavior
(ChatGPT, Codex, Copilot, etc.).

These commands define *interaction-level contracts* and are distinct from
coding rules or design principles defined in this document.

The authoritative command catalog is defined in:

    docs/ai/chappie-commands.md

When issuing AI instructions for code or specification changes,
contributors SHOULD reference the appropriate command shorthand
(e.g. incremental-only, rewrite-allowed) to prevent accidental
scope expansion or unintended refactoring.

## Project-Specific Rules

This project defines additional, project-specific rules
that do not scale beyond this codebase.

These rules are documented under:

    docs/rules/README.md

## Experimental and Exploratory Code Policy

This project explicitly allows **exploratory and transitional implementations**
as part of its design and research process.

### Policy

- Exploratory code MAY coexist with stable code temporarily
- Such code MUST be clearly marked using naming conventions
  (e.g. `experimentalXXX`, `temporaryXXX`)
- Multiple variants (e.g. `UnitOfWork`, `UnitOfWork2`) are acceptable
  during exploration phases

### Requirements

- Exploratory code must NOT silently replace stable APIs
- Public exposure of exploratory APIs must be intentional and explicit
- A cleanup or consolidation plan should be recorded in `TODO.md`

### Design Intent

This policy allows design evolution without losing historical context,
while keeping API risk visible to readers, reviewers, and tools.

# Naming Aids for Concurrency and Execution Model

This section defines naming properties that clarify **how and when a method executes**.
These rules are especially important in concurrent, asynchronous, and cloud-native environments.

## Blocking

### Meaning

- The method may block the calling thread
- Execution time is unbounded or depends on external resources

### Naming Rule

Suffix:
```
Blocking
```

Snake case:
```
_blocking
```

### Example

```
def loadBlocking(id: Id): Entity
protected def load_blocking(id: Id): Entity
```

---

## NonBlocking

### Meaning

- The method does not block the calling thread
- Execution is asynchronous or uses callbacks / futures

### Naming Rule

Suffix:
```
NonBlocking
```

Snake case:
```
_non_blocking
```

### Example

```
def loadNonBlocking(id: Id): Future[Entity]
protected def load_non_blocking(id: Id): Future[Entity]
```

---

## Async / Sync

### Async

#### Meaning

- Execution is asynchronous
- The result is delivered later (Future, IO, Task, etc.)

#### Naming Rule

Suffix:
```
Async
```

Snake case:
```
_async
```

#### Example

```
def fetchAsync(req: Request): Future[Response]
protected def fetch_async(req: Request): Future[Response]
```

### Sync

#### Meaning

- Execution is synchronous
- The result is returned directly

#### Naming Rule

Suffix:
```
Sync
```

Snake case:
```
_sync
```

#### Example

```
def fetchSync(req: Request): Response
protected def fetch_sync(req: Request): Response
```

---

## Idempotent

### Meaning

- Repeated execution produces the same effect
- Safe to retry

### Naming Rule

Suffix:
```
Idempotent
```

Snake case:
```
_idempotent
```

### Example

```
def applyIdempotent(cmd: Command): Result
protected def apply_idempotent(cmd: Command): Result
```

---

# Naming Aids for Semantic and Behavioral Properties

This section defines naming properties that express **semantic or behavioral characteristics**
of methods and values.

## Pure

### Meaning

- No side effects
- Output depends only on input

### Naming Rule

Suffix:
```
Pure
```

Snake case:
```
_pure
```

### Example

```
def normalizePure(input: String): String
protected def normalize_pure(input: String): String
```

---

## Impure

### Meaning

- Has side effects (I/O, mutation, time, randomness)
- Execution may affect external state

### Naming Rule

Suffix:
```
Impure
```

Snake case:
```
_impure
```

### Example

```
def readConfigImpure(): Config
protected def read_config_impure(): Config
```

---

## Cached

### Meaning

- Returns cached data when available
- May not reflect the latest underlying state

### Naming Rule

Suffix:
```
Cached
```

Snake case:
```
_cached
```

### Example

```
def lookupCached(key: Key): Value
protected def lookup_cached(key: Key): Value
```

---

## Memoized

### Meaning

- Results are memoized per input
- Cache lifetime is bound to process or instance

### Naming Rule

Suffix:
```
Memoized
```

Snake case:
```
_memoized
```

### Example

```
def computeMemoized(x: Int): Int
protected def compute_memoized(x: Int): Int
```

---

## Composition Guidance

- Execution-model properties (`Blocking`, `Async`, etc.) should appear **after**
  safety/stability properties
- Semantic properties (`Pure`, `Cached`, etc.) should appear **last**
- Avoid over-composition; names should remain readable

### Example

```
experimentalLoadNonBlockingCached
experimental_load_non_blocking_cached
```

---

## Design Principles (Extended)

- Execution characteristics must be visible at the call site
- Semantic guarantees should not rely on documentation alone
- Naming is an executable form of design intent

# Localization Principles

These rules express library-level principles for message content and localization.
They are intentionally abstract and do not reference concrete classes.

- Internal messages should be deterministic and language-neutral by default
- Localization should be performed outside core logic when context is available
- When context is unavailable, deferred resolution should be preferred



# Error Handling and Result Conventions

This section defines conventions for representing errors, failures, and results in the codebase.


## Principle

## Defect vs Domain Failure (Normative)

This project makes a strict semantic distinction between **Defect** and **Domain Failure**.

### Domain Failure

- Represents expected, valid outcomes defined by the domain model
- MUST be modeled as values
- MUST use `Consequence` / `Conclusion`
- MUST NOT use exceptions
- MUST be composable and inspectable

Examples:
- Validation failure
- Business rule violation
- Invalid state transition
- Missing or invalid user input

### Defect

- Represents system-level failures or broken assumptions
- Indicates programming errors, misconfiguration, or invariant violations
- MAY use exceptions
- MUST NOT encode domain meaning
- MUST be contained at system or boundary layers

Examples:
- Null pointer access
- Illegal state
- Broken invariant
- Unexpected runtime failure

### Throwable Boundary Rule

- `Throwable` MUST be treated as a boundary signal only
- `Throwable` MUST NOT cross domain boundaries
- Domain logic MUST NOT depend on `Throwable`

The normative definition and rationale are documented in:

    docs/notes/defect-vs-domain-failure.md

- **Domain errors** and **expected failures** should be modeled as values, not exceptions.
- Use the `Consequence` type (or similar) to represent recoverable errors and business rule violations.
- Use exceptions only for programming errors, contract violations, or truly exceptional conditions.


## Dual-API Rule for Rarely-Failing Operations

Some operations are expected to succeed in almost all normal usages,
but **cannot be guaranteed to never fail** due to environmental,
I/O, or data-dependent conditions.

For such operations, the API MUST provide **two parallel variants**:

1. **Exception-based variant**
   - Returns a plain value
   - Throws an exception on failure
   - Intended for:
     - Convenience
     - Internal use
     - Scenarios where failure is considered exceptional

2. **Consequence-based variant**
   - Returns `Consequence[T]`
   - Captures failures as values
   - Intended for:
     - Boundary layers
     - External input handling
     - Error-aware control flow

### Naming Convention

- The exception-based variant uses the base name:
  ```
  toText
  ```
- The Consequence-based variant appends the suffix `C`:
  ```
  toTextC
  ```

### Design Rationale

- Preserves API ergonomics for common-case usage
- Makes error handling explicit where required
- Avoids forcing pervasive error wrapping
- Keeps failure semantics visible at the call site

### Examples

```
def toText: String
def toTextC: Consequence[String]
```

```
def loadConfig: Config
def loadConfigC: Consequence[Config]
```

```
def readBytes: Array[Byte]
def readBytesC: Consequence[Array[Byte]]
```

## Quasi-Error I/O (Practically Unrecoverable Failures)

Some I/O-related failures are **theoretically possible** but
**practically unrecoverable under correct system operation**.

These failures indicate that the runtime environment or system state
is already severely degraded, and meaningful recovery or branching
at the application level is not realistic.

Such failures are treated as **Quasi-Errors**.

### Examples of Quasi-Error I/O

- A file that was just created by the same process cannot be opened
- A guaranteed-existing temporary file suddenly disappears
- A process-owned path becomes unreadable without configuration change
- Local temporary directories (e.g. `/var/tmp`) become inaccessible

### Handling Rule

- Quasi-Error I/O MAY be handled using **exceptions only**
- A `Consequence`-based variant is **NOT required** for these operations
- Callers are NOT expected to recover or branch on these failures

### Rationale

- Retrying is ineffective
- Recovery logic adds no semantic value
- Wrapping such failures in `Consequence` degrades signal quality
- These failures are operationally equivalent to `Error` conditions

### Design Guideline

- Use exception-only APIs for:
  - Resource opening that is guaranteed by construction
  - Internal file or stream access owned by the current process
- Use Dual-API (exception + `Consequence`) for:
  - Data interpretation failures
  - Boundary input validation
  - Semantically recoverable errors

## Consequence Type

The `Consequence` type is used to represent the outcome of an operation that may fail.

### Example

```
def reserve(cmd: ReserveCommand): Consequence[Reservation]
```

### Guidelines

- Do not use exceptions for validation failures or business rule violations.
- Use `Consequence` for all domain-level errors.
- Only throw exceptions for contract violations or unrecoverable errors.

### Structured Failure Rule

- `Consequence.failure("...")` is a last resort.
- `Consequence.fail(...)` is a low-level structured failure builder for cases
  where no semantic utility exists yet and the caller must provide the
  taxonomy, cause, and facets explicitly.
- Known failure categories MUST be represented with structured errors:
  - `Observation`
  - `Taxonomy`
  - `Cause`
  - `Conclusion`
  - typed `Consequence` utility methods
- If an appropriate failure vocabulary does not exist, extend the Observation /
  Taxonomy model and add suitable `Conclusion` / `Consequence` helpers.
- Do not introduce new string-only failures when the failure category is known.
- Existing string-only failures SHOULD be migrated incrementally when touched.
- If a low-level `Consequence.fail(...)` call becomes common or names a
  recognizable failure category, add a semantic utility and migrate callers to it.

### Consequence Error Utility Naming

- New `Consequence` / `Conclusion` error utilities MUST use the error name
  itself as the method name.
- Preferred examples:
  - `notImplemented(message)`
  - `securityPermissionDenied(message)`
  - `securityAuthenticationRequired(message)`
- Do not introduce new `failXxx(...)` utility names.
- Existing `Consequence.failXxx(...)` and `Conclusion.failXxx(...)` utility
  methods are deprecated legacy compatibility surface and SHOULD be migrated
  gradually when touched.
- The utility method should create or delegate to a structured `Conclusion`
  built from the appropriate `Observation`, `Taxonomy`, `Cause`, and descriptor
  facets.

### Monadic vs Applicative Composition

`Consequence` supports **both monadic and applicative-style composition**.
These two styles serve different purposes and MUST be used intentionally.

#### Monadic Composition (`flatMap`)

- Use `flatMap` (or for-comprehension) for **sequential, dependent operations**
- Later steps may depend on the values produced by earlier steps
- Evaluation order is significant
- Failure short-circuits subsequent computation

Example:

```
for {
  a <- loadA
  b <- loadB(a)
} yield b
```

#### Applicative Composition (`zip` / `zipN`)

- Use `zip` / `zipN` for **independent operations**
- No step depends on the value of another
- Evaluation order is not semantically significant
- **All failures MUST be collected**

Semantics:

- If all composed `Consequence` values succeed:
  - The result succeeds
  - Values are combined (tuple or sequence)
- If one or more composed values fail:
  - The result fails
  - All failure `Conclusion`s are combined

Example:

```
Consequence.zip3(
  validateName(name),
  validateAge(age),
  validateEmail(email)
)
```

#### Design Intent

- `flatMap` expresses **process and dependency**
- `zip / zipN` express **validation and aggregation**
- Applicative composition MUST NOT short-circuit on first failure
- `zip / zipN` are the preferred mechanism for validation-style logic

---

# Design by Contract (DbC) Conventions

This section defines conventions for applying **Design by Contract (DbC)**
in a pragmatic and lightweight manner.

The goal is to make **assumptions, guarantees, and responsibilities**
explicit, without overusing exceptions or heavy assertion frameworks.

These are **guiding conventions**, not strict enforcement rules.

## Basic Principles

- Contracts describe **expected usage**, not defensive programming
- Violations of contracts indicate **programming errors**, not domain errors
- Domain errors should be represented using `Consequence`, not DbC failures

---

## DbC and Defect Detection

### Clarified Understanding

Yes — in this codebase, **Design by Contract (DbC) is primarily used for defect detection**.

DbC is *not* a general-purpose error-handling mechanism.
Instead, it is used to detect violations that indicate **bugs, incorrect usage, or broken assumptions**
during development and testing.

### What DbC Is Used For

DbC is used to detect:

- Incorrect usage by the caller (precondition violations)
- Broken invariants in domain objects
- Implementation defects inside a method
- Unexpected states that should be impossible by design

These failures typically indicate **defects that must be fixed**, not situations to be recovered from.

### What DbC Is NOT Used For

DbC must NOT be used for:

- Business rule validation
- Expected validation failures
- User input errors
- I/O or external system failures

These cases must be modeled explicitly using `Consequence`.

### Practical Rule of Thumb

- If a failure should lead to **bug fixing**, use DbC (exceptions are acceptable)
- If a failure should lead to **error handling or branching**, use `Consequence`
- If a failure can occur during correct and expected usage, it is **not** a DbC concern

### Design Intent

By restricting DbC to defect detection:

- Contracts remain simple and meaningful
- Exception usage stays limited and intentional
- Domain error handling remains explicit and composable
- Runtime behavior becomes easier to reason about

## Preconditions

### Meaning

- Conditions that must be satisfied by the caller
- Violations indicate incorrect usage by the caller

### Expression

- Use `require` or equivalent checks
- May throw an exception when violated

### Example

```
def transfer(from: Account, to: Account, amount: Money): Consequence[Result] =
  require(amount.isPositive)
  ...
```

### Guideline

- Preconditions should be **simple and cheap**
- Do not use preconditions for business rule validation
- Prefer `Consequence` for recoverable or expected failures

---

## Postconditions

### Meaning

- Conditions guaranteed by the method upon successful completion
- Violations indicate implementation errors

### Expression

- Use `ensure`-like checks or assertions
- May throw an exception if violated

### Example

```
def normalize(value: Int): Int =
  val result = ...
  assert(result >= 0)
  result
```

### Guideline

- Use postconditions sparingly
- Focus on **invariants**, not incidental properties

---

## Invariants

### Meaning

- Conditions that must always hold for an object
- Checked at construction time or at key mutation points

### Expression

- Validate invariants in constructors or factory methods
- May use assertions or validation helpers

### Example

```
case class Percentage(value: Int):
  require(value >= 0 && value <= 100)
```

---

## DbC vs Error Handling

### DbC (Exceptions Allowed)

- Violated preconditions
- Broken invariants
- Internal logic errors

### Consequence (Preferred)

- Validation failures
- Business rule violations
- I/O and external system errors

---

## Naming Conventions Related to DbC

### requireXXX

Indicates that a precondition is being enforced.

```
requireValidState(state)
```

### ensureXXX

Indicates that a postcondition is being checked.

```
ensureNormalized(result)
```

### assertXXX

Indicates internal consistency checks, typically non-public.

```
assertInvariant()
```

---

## Design Rationale

- DbC clarifies **responsibility boundaries**
- Preconditions protect implementations, not callers
- Consequence represents **recoverable domain errors**
- Contracts complement, but do not replace, type-based design

# Protected Method Role Conventions

This section defines **role-based naming conventions for protected methods**.
These rules clarify how a protected method is intended to be used by subclasses.

The goal is to make subclassing intent explicit **from the method name alone**,
without relying on comments or documentation.

## Role Categories for Protected Methods

Protected methods MUST fall into one of the following categories.

---

## 1. Subroutine (Not Intended for Override)

### Intent

- Used as an internal subroutine
- Called by other methods in the same class
- **Not intended to be overridden**

### Naming Rule

- Use snake_case
- Mark as `final`

### Example

```
protected final def do_test(p: XXX): Result
```

### Design Notes

- Declaring the method as `final` enforces the intent
- Subclasses may call this method, but must not override it

---

## 2. Template Method (Override Rare and Discouraged)

### Intent

- Acts as a template method
- Provides a default implementation
- Overriding is possible but **not expected in normal use**

### Naming Rule

- Use snake_case
- Do NOT mark as `final`

### Example

```
protected def do_test(p: XXX): Result
```

### Design Notes

- This is the default choice for most protected extension points
- Overriding should be exceptional and well-justified

---

## 3. Overridable Hook (Override Expected)

### Intent

- Designed explicitly for subclass override
- Represents a customization or extension point

### Naming Rule

- Use `xxx_Yyy` form.
- Capitalize the following word to signal override intent.

### Example

```
protected def do_Test(p: XXX): Result
protected def build_Program: Program
```

### Design Notes

- The `xxx_Yyy` form visually distinguishes hooks from protected subroutines
- Subclasses are expected to override this method

---

## Abstract vs Default Implementation

- If a reasonable default implementation exists,
  the method **must not** be declared abstract
- Abstract protected methods should be used only when
  no meaningful default behavior can be provided

### Rationale

Providing a default implementation:

- Reduces subclass boilerplate
- Preserves backward compatibility
- Allows incremental extension without forcing overrides

---

## Design Principles

- Protected methods must clearly communicate **override intent**
- `final` is part of the semantic contract, not an implementation detail
- Naming conventions are used to express inheritance design explicitly


# Method Naming Conventions for Creation

This section defines naming conventions for **creation-oriented methods**.
These conventions clarify **assumptions, side effects, and reliability**
of object creation from the method name alone.

These are **conventions**, not strict enforcement rules, and may be extended over time.

## apply(...)

### Intended Use

- Used primarily in constructors or companion objects
- Represents the most basic and predictable form of creation

### Guarantees

- Must **never fail** under normal usage
  - Domain errors must not occur
  - Recoverable failures must not be represented
- DbC violations (defects) are the only acceptable failures
- Must NOT call other modules or external services
- Must NOT perform complex or heavy computation
- Must be deterministic and context-independent

### Typical Characteristics

- Pure or nearly pure
- No I/O
- No environment or runtime dependency

### Example

```
def apply(value: Int): Percentage =
  require(value >= 0 && value <= 100)
  new Percentage(value)
```

---

## create(...)

### Intended Use

- Represents standard creation logic
- Used when creation may reasonably fail or involve external effects

### Characteristics

- May involve I/O (database, file system, network, configuration)
- May return `Consequence[T]`, `Either`, or effect types (`IO`, `Future`, etc.)
- Failure is considered part of normal control flow

### Example

```
def create(cmd: CreateOrder): Consequence[Order]
```

```
def createFromStorage(id: Id): IO[Entity]
```

---

## make(...)

### Intended Use

- Represents **best-effort or heuristic-based creation**
- Creation logic relies on assumptions, inference, or contextual interpretation

### Characteristics

- May depend on runtime context, locale, configuration, or heuristics
- Results may vary depending on input interpretation or environment
- Still expected to succeed in most practical cases

### Typical Use Cases

- Language or format inference
- Context-sensitive object construction
- Convenience factories that trade strictness for usability

### Example

```
def makeName(input: String): Consequence[Name]
```

```
def makeText(input: String, context: Context): Text
```

---

## Comparative Summary

| Method | Failure Model | Side Effects | Context Dependence |
|------|---------------|--------------|--------------------|
| apply | No (DbC only) | None | None |
| create | Yes | Possible | Low |
| make | Yes | Possible | High |

---

## Extension Policy

- New creation-related verbs may be introduced when they convey
  a clearly distinct semantic contract
- Any new verb must be documented in this section before use

# Method Naming Conventions for Parsing and Encoding

This section defines naming conventions for **parsing, decoding, and encoding operations**.
These conventions clarify **input assumptions, failure models, and semantic intent**
from the method name alone.

These are **conventional rules** and may be extended as needed.

---

## parse(...)

### Intended Use

- Converts **unstructured or loosely structured input** into a structured model
- Typical inputs:
  - Free-form text
  - User input
  - Configuration text
  - DSL or source-like strings

### Characteristics

- Input may be malformed or invalid
- Failure is **expected and normal**
- Should not rely on strong external context unless explicitly documented

### Error Model

- Must NOT throw exceptions for input-related errors
- Must return `Consequence[T]`, `Either`, or an effect type

### Example

def parse(input: String): Consequence[Ast]

def parseConfig(text: String): Either[ParseError, Config]

### Design Note

- `parse` is about **syntax and structure**
- Domain validation should happen *after* parsing

---

## decode(...)

### Intended Use

- Converts a **well-defined encoded representation** into a domain object
- Typical inputs:
  - Binary formats
  - JSON / XML
  - Protocol or schema-driven data

### Characteristics

- Input is assumed to follow a known format or protocol
- Failures indicate:
  - Invalid or corrupted data
  - Schema or version mismatch
- Often used at **system boundaries**

### Error Model

- Return `Consequence[T]`, `Either`, or effect types
- Exceptions are allowed **only for DbC violations**

### Example

def decode(bytes: Array[Byte]): Consequence[Message]

def decodeJson(json: String): Either[DecodeError, DomainEvent]

### Design Note

- `decode` is about **schema and protocol correctness**
- Business rules do NOT belong here

---

## encode(...)

### Intended Use

- Converts a domain object into a **serialized or transferable representation**
- Used for:
  - Persistence
  - Messaging
  - External communication

### Characteristics

- Should **not fail under normal usage**
- Must NOT perform I/O
- Failures indicate defects or broken invariants

### Error Model

- Returns a plain value
- DbC violations (exceptions) are acceptable
- Must NOT return `Consequence`

### Example

def encode(event: DomainEvent): Array[Byte]

def encodeJson(event: DomainEvent): String

### Design Note

- `encode` assumes the domain object is already valid
- Validation belongs before encoding

---

## Comparative Summary

| Method | Direction | Failure Expected | Error Model |
|------|-----------|------------------|-------------|
| parse | Text → Model | Yes | Consequence / Either |
| decode | Encoded → Model | Yes | Consequence / Either |
| encode | Model → Encoded | No (DbC only) | Exception (Defect) |

---

## Relationship to Other Conventions

- `parse / decode`
  → Similar to `create / make` in that failure is expected
- `encode`
  → Similar to `apply` in that failure indicates a defect
- DbC is used only for **defect detection**
- Domain errors must use `Consequence`

---

## Design Intent

- Method names communicate **trust level and responsibility**
- Boundary-related failures are explicit
- Encoding assumes correctness; decoding assumes uncertainty

# Method Naming Conventions for Loading and Fetching

This section defines naming conventions for **loading, fetching, and reading data**.
These conventions clarify **data source, latency expectations, side effects,
and failure models** from the method name alone.

These are **conventional rules** and may be extended as needed.

---

## load(...)

### Intended Use

- Loads data from a **local or relatively stable source**
- Typical sources:
  - Database
  - File system
  - In-memory cache
  - Local persistent storage

### Characteristics

- May involve I/O
- Latency is expected but generally bounded
- Often used inside application or infrastructure layers

### Error Model

- Failures are expected and must be represented explicitly
- Return `Consequence[T]`, `Either`, or an effect type (`IO`, `Future`, etc.)
- Must NOT throw exceptions for expected failures

### Example

def load(id: Id): Consequence[Entity]

def loadFromFile(path: Path): IO[Config]

### Design Note

- `load` implies **data already exists**
- Absence or failure is part of normal control flow

---

## fetch(...)

### Intended Use

- Retrieves data from a **remote or volatile source**
- Typical sources:
  - Remote services
  - External APIs
  - Network resources
  - Distributed systems

### Characteristics

- Involves network I/O
- Latency is variable and potentially high
- Failures are common and expected

### Error Model

- Must return `Consequence[T]`, `Either`, or an effect type
- Timeouts, connectivity issues, and partial failures are normal outcomes

### Example

def fetchUser(id: UserId): Consequence[User]

def fetchFromApi(req: Request): IO[Response]

### Design Note

- `fetch` implies **unreliable or remote access**
- Callers should assume retries or fallback may be required

---

## read(...)

### Intended Use

- Reads data from an **already available or provided source**
- Typical sources:
  - Input streams
  - Buffers
  - In-memory representations
  - Already-opened resources

### Characteristics

- Minimal side effects
- No resource acquisition
- Usually cheap compared to `load` or `fetch`

### Error Model

- Failures are possible but usually local (format, state)
- Return `Consequence[T]`, `Either`, or a plain value when safe

### Example

def read(buffer: ByteBuffer): Consequence[Message]

def readLine(reader: Reader): String

### Design Note

- `read` does NOT imply persistence or remote access
- It assumes the source is already under the caller’s control

---

## Comparative Summary

| Method | Source Type | Latency | Failure Expected |
|------|-------------|---------|------------------|
| load | Local / Stable | Medium | Yes |
| fetch | Remote / Volatile | High | Yes |
| read | In-Memory / Open | Low | Sometimes |

---

## Relationship to Other Conventions

- `load / fetch / read`
  → Concern **data access**, not creation
- Combine with `getXXX / takeXXX` to express safety expectations
- Combine with `blocking / async` to express execution model
- Domain-level failures must use `Consequence`

---

## Design Intent

- Method names communicate **where data comes from**
- Latency and reliability expectations are visible at call sites
- I/O boundaries are explicit and reviewable


# Method Naming Conventions for Building and Assembling

This section defines naming conventions for **building and assembling composite objects**.
These conventions clarify **construction strategy, dependency handling,
and failure expectations** from the method name alone.

These are **conventional rules** and may be extended as needed.

---

## build(...)

### Intended Use

- Constructs an object by **explicitly following a defined plan or specification**
- Often used when:
  - Multiple parts must be combined
  - Construction follows a known sequence or recipe
  - Dependencies are already resolved or provided

### Characteristics

- Deterministic given the same inputs
- May involve moderate computation
- May fail if required components are missing or inconsistent

### Error Model

- Failures are expected and must be represented explicitly
- Return `Consequence[T]`, `Either`, or an effect type
- Must NOT hide failures behind partial results

### Example

def buildPlan(parts: Parts): Consequence[Plan]

def buildComponent(config: Config, deps: Dependencies): Component

### Design Note

- `build` emphasizes **process and structure**
- Inputs are assumed to be intentional and prepared by the caller

---

## Builder Output Method Naming

For Builder-style classes that produce immutable values:

- The method that finalizes construction and returns the built value
  MUST be named `build`.
- Alternative names such as `result`, `get`, or `toX` MUST NOT be used.
- Calling `build` semantically indicates that the builder is finalized
  and MUST NOT be used afterward.

Rationale:
- Clarifies destructive finalization semantics
- Aligns method naming with builder intent
- Prevents misinterpretation as a pure accessor

---

## Builder Effect Type Rule

Builder-style APIs that accumulate state and produce an immutable value
MUST use `Consequence` as their primary effect type.

### Rule

- Builder methods that may fail during accumulation or finalization
  MUST return `Consequence[T]`.
- Builder APIs MUST NOT expose `IO` as their primary effect type.
- `IO` MAY be used only:
  - At infrastructure or boundary layers
  - For explicit execution control (`unsafeRun`, CLI, daemon, etc.)
  - Via adapters such as `ConsequenceT[IO]`

### Rationale

- Prevents mixed monadic pipelines (`IO` + `Consequence`)
- Keeps domain construction semantics explicit and composable
- Avoids meaningless `IO` wrapping when failure, not execution, is the concern
- Aligns builder APIs with domain-level error modeling

### Example

```
final class BagBuilder {
  def write(bytes: Array[Byte]): Consequence[Unit]
  def writeFrom(in: InputStream): Consequence[Unit]
  def build(): Consequence[Bag]
}
```

### Anti-Example

```
final class BagBuilder {
  def write(bytes: Array[Byte]): IO[Unit]      // ❌
  def build(): IO[Bag]                         // ❌
}
```

---

## assemble(...)

### Intended Use

- Assembles an object by **wiring together pre-existing components**
- Focuses on composition rather than creation logic
- Typical use cases:
  - Component wiring
  - Dependency injection
  - Runtime configuration binding

### Characteristics

- Little to no complex computation
- Mostly structural composition
- Often used near application or infrastructure boundaries

### Error Model

- Failures may occur due to incompatible components or missing bindings
- Return `Consequence[T]` or an effect type when failure is expected
- DbC may be used when incompatibility indicates a defect

### Example

def assembleService(repo: Repository, cache: Cache): Service

def assembleApplication(modules: Modules): Consequence[Application]

### Design Note

- `assemble` emphasizes **wiring and configuration**
- Logic should be minimal; behavior belongs elsewhere

---

## Comparative Summary

| Method | Focus | Computation | Failure Expected |
|------|-------|-------------|------------------|
| build | Process / Recipe | Medium | Yes |
| assemble | Wiring / Composition | Low | Sometimes |

---

## Relationship to Other Conventions

- `build / assemble`
  → Concern **composition**, not raw creation
- Often used after `create / make` or `load / fetch`
- May be combined with `experimental`, `unsafe`, or execution-model modifiers
- Domain-level failures must use `Consequence`

---

## Design Intent

- Method names communicate **how an object comes together**
- Construction logic and wiring logic are clearly separated
- Large object graphs remain understandable and reviewable

# Method Naming Conventions for Resolving and Querying

This section defines naming conventions for **resolving, looking up, finding,
and searching values or objects**.
These conventions clarify **assumptions, completeness, cost, and failure models**
from the method name alone.

These are **conventional rules** and may be extended as needed.

---

## resolve(...)

### Intended Use

- Resolves a reference, identifier, or dependency into a concrete object
- Often used when:
  - A reference must be mapped to an actual instance
  - Dependencies are wired or selected based on rules
  - Resolution is expected to succeed under correct configuration

### Characteristics

- Assumes the target *should* exist or be resolvable
- Failure usually indicates misconfiguration or defect
- Often used in framework or infrastructure code

### Error Model

- May throw exceptions for resolution failure (DbC / defect)
- May return `Consequence[T]` when failure is an expected domain outcome
- Must NOT silently return `null`

### Example

def resolveService(name: ServiceName): Service

def resolveHandler(key: Key): Consequence[Handler]

### Design Note

- `resolve` implies **logical necessity**
- Failure is exceptional unless explicitly documented otherwise

---

## lookup(...)

### Intended Use

- Looks up a value by key in a **known collection or registry**
- Absence is a normal and expected outcome

### Characteristics

- Usually cheap (map, cache, index)
- No inference or heuristics
- No guarantee that a value exists

### Error Model

- Return `Option[T]` or `Consequence[T]`
- Must NOT throw exceptions for missing values

### Example

def lookupUser(id: UserId): Option[User]

def lookupConfig(key: ConfigKey): Consequence[Config]

### Design Note

- `lookup` emphasizes **explicit absence**
- Prefer over `resolve` when non-existence is normal

---

## find(...)

### Intended Use

- Retrieves a value that is **expected to exist in most cases**
- Absence is possible but relatively rare

### Characteristics

- Often used for repository or collection access
- Semantically stronger than `lookup`, weaker than `resolve`

### Error Model

- Return `Option[T]` or `Consequence[T]`
- May throw exceptions only when absence indicates a defect

### Example

def findOrder(id: OrderId): Option[Order]

def findActiveSession(user: User): Consequence[Session]

### Design Note

- `find` suggests **reasonable expectation**, not certainty
- Use `lookup` when absence is common

---

## search(...)

### Intended Use

- Performs a **query over a potentially large or open-ended space**
- Returns zero or more results

### Characteristics

- Potentially expensive
- Often involves filtering, ranking, or pattern matching
- May involve I/O or external systems

### Error Model

- Return a collection (`List`, `Seq`, etc.) or `Consequence[Seq[T]]`
- Empty result is normal
- Must NOT throw exceptions for “not found”

### Example

def searchUsers(query: Query): Consequence[List[User]]

def searchLogs(criteria: Criteria): IO[Seq[LogEntry]]

### Design Note

- `search` emphasizes **exploration**, not direct access
- Callers should assume cost and latency

---

## Comparative Summary

| Method  | Expectation | Absence | Typical Cost |
|--------|-------------|---------|--------------|
| resolve | Must exist | Exceptional | Low–Medium |
| lookup  | May exist  | Normal | Low |
| find    | Usually exists | Possible | Low–Medium |
| search  | Unknown set | Normal | Medium–High |

---

## Relationship to Other Conventions

- `resolve / lookup / find / search`
  → Concern **reference and query semantics**, not creation
- Combine with `load / fetch` to express data source
- Combine with `getXXX / takeXXX` to express safety expectations
- Domain-level failures must use `Consequence`
- Defect-level failures may use DbC

---

## Design Intent

- Method names communicate **certainty and cost**
- Absence semantics are explicit
- Query intent is visible at the call site

# Method Naming Conventions for Resource Management

This section defines naming conventions for **opening, closing, acquiring,
and releasing resources**.
These conventions clarify **resource ownership, lifetime,
and failure responsibility** from the method name alone.

These are **conventional rules** and may be extended as needed.

---

## open(...)

### Intended Use

- Opens a resource and prepares it for use
- Typical resources:
  - Files
  - Network connections
  - Streams
  - Sessions

### Characteristics

- Acquires an external or system resource
- May involve I/O
- Establishes a lifecycle that must be closed explicitly

### Error Model

- Failures are expected and must be represented explicitly
- Return `Consequence[T]`, `Either`, or an effect type
- Must NOT hide failures using partial or dummy resources

### Example

def open(path: Path): Consequence[FileHandle]

def openConnection(cfg: Config): IO[Connection]

### Design Note

- `open` implies **exclusive or managed ownership**
- The caller becomes responsible for closing the resource

---

## close(...)

### Intended Use

- Closes or finalizes a previously opened resource
- Releases underlying system or external resources

### Characteristics

- Usually idempotent
- Should be safe to call multiple times
- Often used in `finally` blocks or resource scopes

### Error Model

- Failures may be logged but should rarely be propagated
- Return `Unit`, `Consequence[Unit]`, or an effect type when needed
- DbC may be used when closing an invalid resource indicates a defect

### Example

def close(handle: FileHandle): Unit

def closeConnection(conn: Connection): Consequence[Unit]

### Design Note

- `close` signals **end of ownership**
- Business logic must not depend on close-time failures

---

## acquire(...)

### Intended Use

- Acquires a resource from a **pool, registry, or shared manager**
- Typical resources:
  - Thread pools
  - Connection pools
  - Locks
  - Leases

### Characteristics

- Resource ownership is temporary
- May block or wait depending on availability
- Often paired with `release`

### Error Model

- Failures are expected (exhaustion, timeout)
- Must return `Consequence[T]` or an effect type
- Must NOT throw exceptions for normal contention

### Example

def acquire(): Consequence[Connection]

def acquireLock(key: Key): IO[Lock]

### Design Note

- `acquire` emphasizes **controlled access**, not creation
- Ownership is conditional and time-bound

---

## release(...)

### Intended Use

- Releases a previously acquired resource back to its manager
- Complements `acquire`

### Characteristics

- Must be safe to call even if acquisition was partial
- Should be idempotent where possible
- No heavy computation or blocking

### Error Model

- Failures usually indicate defects
- DbC may be used to detect double-release or invalid release
- Return `Unit` or `Consequence[Unit]` when failure handling is required

### Example

def release(conn: Connection): Unit

def releaseLock(lock: Lock): Consequence[Unit]

### Design Note

- `release` indicates **end of temporary ownership**
- Must not perform implicit acquisition or reopening

---

## Comparative Summary

| Method   | Ownership Model | Lifetime Control | Failure Expected |
|---------|-----------------|------------------|------------------|
| open    | Exclusive       | Caller-managed   | Yes |
| close   | Ends exclusive  | Explicit         | Rare |
| acquire | Shared / Pooled | Temporary        | Yes |
| release | Ends temporary  | Explicit         | Rare |

---

## Relationship to Other Conventions

- `open / close / acquire / release`
  → Concern **resource lifecycle management**
- Combine with `blocking / async` to express execution model
- Combine with `unsafe / unchecked` for performance-sensitive paths
- Resource-related failures must use `Consequence`
- Defect-level misuse may be detected using DbC

---

## Design Intent

- Resource ownership is explicit at the call site
- Lifecycle responsibilities are visible and reviewable
- Resource leaks and misuse are easier to detect and prevent

# Method Naming Conventions for Validation and Verification

This section defines naming conventions for **validation, verification,
and checking operations**.
These conventions clarify **purpose, strictness, and failure handling**
from the method name alone.

These are **conventional rules** and may be extended as needed.

---

## validate(...)

### Intended Use

- Validates input, state, or data against **domain or business rules**
- Validation failures are **expected and recoverable**

### Characteristics

- Often used for user input, commands, DTOs, or external data
- Multiple validation errors may be collected
- Validation does not imply correctness of execution context

### Error Model

- Must return `Consequence[T]`, `Either`, or a validation result type
- Must NOT throw exceptions for validation failures

### Example

def validate(cmd: CreateOrderCommand): Consequence[ValidatedOrder]

def validateEmail(input: String): Either[ValidationError, Email]

### Design Note

- `validate` is about **business and domain correctness**
- Validation failures are not defects

---

## verify(...)

### Intended Use

- Verifies that a condition, assumption, or state **actually holds**
- Often used when correctness depends on external or runtime state

### Characteristics

- Stronger than `validate`
- Often used for:
  - Authorization
  - Permissions
  - Consistency with external systems
  - Security or integrity checks

### Error Model

- Return `Consequence[T]` or a boolean-like result
- May throw exceptions only when failure indicates a defect or breach

### Example

def verifyPermission(user: User, action: Action): Consequence[Unit]

def verifySignature(data: Data, sig: Signature): Consequence[Verified]

### Design Note

- `verify` is about **truth and trust**
- Failure often has security or consistency implications

---

## check(...)

### Intended Use

- Performs a **lightweight or internal consistency check**
- Often used for defensive or diagnostic purposes

### Characteristics

- Usually cheap and local
- No domain semantics implied
- Often returns a boolean or simple result

### Error Model

- Return `Boolean`, `Option[T]`, or a simple result
- May throw exceptions when used as a DbC-style assertion

### Example

def checkState(state: State): Boolean

def checkInvariant(obj: Entity): Unit

### Design Note

- `check` is intentionally weak in semantics
- Prefer `validate` or `verify` when meaning matters

---

## Comparative Summary

| Method  | Purpose | Failure Meaning | Typical Use |
|--------|---------|-----------------|-------------|
| validate | Domain correctness | Expected | Input / business rules |
| verify   | Truth / trust | Serious | Security / consistency |
| check    | Sanity / consistency | Diagnostic | Internal logic |

---

## Relationship to Other Conventions

- `validate`
  → Produces domain-level failures using `Consequence`
- `verify`
  → May produce domain failures or detect serious violations
- `check`
  → Often internal; may overlap with DbC usage
- DbC (`require`, `assert`) remains the tool for **defect detection**

---

## Design Intent

- Method names communicate **strictness and intent**
- Domain failures and defects are clearly separated
- Validation logic remains explicit and composable

# Method Naming Conventions for Lifecycle Control

This section defines naming conventions for **starting, stopping,
pausing, and resuming lifecycle-managed components or processes**.
These conventions clarify **lifecycle state transitions,
side effects, and failure expectations** from the method name alone.

These are **conventional rules** and may be extended as needed.

---

## start(...)

### Intended Use

- Transitions a component or process from an **inactive** state to an **active** state
- Typical targets:
  - Services
  - Engines
  - Schedulers
  - Background processes

### Characteristics

- May allocate resources or spawn execution contexts
- May involve I/O or asynchronous processing
- Usually paired with `stop`

### Error Model

- Failures are expected and must be represented explicitly
- Return `Consequence[Unit]` or an effect type
- Must NOT silently ignore startup failures

### Example

def start(): Consequence[Unit]

def startAsync(): IO[Unit]

### Design Note

- `start` establishes **operational responsibility**
- After successful start, the component is considered active

---

## stop(...)

### Intended Use

- Transitions a component or process from **active** to **inactive**
- Releases resources acquired during `start`

### Characteristics

- Should be safe to call multiple times
- Often performs graceful shutdown
- May wait for in-flight operations to complete

### Error Model

- Failures should be rare
- Return `Unit`, `Consequence[Unit]`, or an effect type
- DbC may be used if stopping an inactive component indicates a defect

### Example

def stop(): Unit

def stopGracefully(): Consequence[Unit]

### Design Note

- `stop` signals **end of lifecycle responsibility**
- Business logic must not depend on stop-time failures

---

## pause(...)

### Intended Use

- Temporarily suspends processing while preserving internal state
- Does NOT release core resources

### Characteristics

- Reversible operation
- Component remains initialized but inactive
- Often paired with `resume`

### Error Model

- Failures are possible (invalid state transitions)
- Return `Consequence[Unit]` or an effect type

### Example

def pause(): Consequence[Unit]

def pauseProcessing(): IO[Unit]

### Design Note

- `pause` implies **temporary inactivity**
- The component is expected to resume later

---

## resume(...)

### Intended Use

- Resumes a previously paused component or process
- Restores active processing without full reinitialization

### Characteristics

- Requires prior successful `pause`
- Must preserve consistency and internal state

### Error Model

- Failures indicate invalid lifecycle sequencing
- Return `Consequence[Unit]` or an effect type
- DbC may be used if resume is called in an invalid state

### Example

def resume(): Consequence[Unit]

def resumeProcessing(): IO[Unit]

### Design Note

- `resume` continues an existing lifecycle
- Must not implicitly call `start`

---

## Comparative Summary

| Method | State Transition | Resource Handling | Failure Expected |
|------|------------------|-------------------|------------------|
| start | Inactive → Active | Acquire | Yes |
| stop | Active → Inactive | Release | Rare |
| pause | Active → Paused | Preserve | Yes |
| resume | Paused → Active | Preserve | Yes |

---

## Relationship to Other Conventions

- `start / stop / pause / resume`
  → Concern **lifecycle state management**
- Combine with `async / blocking` to express execution behavior
- Combine with `idempotent` where repeated calls are safe
- Lifecycle failures must use `Consequence`
- Invalid state transitions may be detected using DbC

---

## Design Intent

- Lifecycle transitions are explicit and reviewable
- Resource ownership and responsibility are clear
- Components behave predictably across state changes




# Indentation-Based Syntax Policy

This project intentionally restricts the use of Scala 3 indentation-based syntax
(offside rule) to reduce accidental semantic changes, improve patch stability,
and lower AI-assisted analysis cost.

## Principle

- Structural constructs MUST use explicit braces `{}`.
- Indentation-based syntax MUST NOT be used to define structural AST boundaries.
- Indentation-based syntax MAY be used only at AST leaf levels.

## Prohibited Uses

Indentation-based syntax MUST NOT be used for:

- class / trait / enum / object definitions
- top-level or nested structural declarations
- method definitions with non-trivial or evolving bodies
- multi-level or deeply nested control structures
- code that is expected to be frequently patched or incrementally edited

## Allowed Uses (Exceptional)

Indentation-based syntax MAY be used only for:

- small and closed `match` expressions
- simple expression bodies with no nested structure
- short `if`, `for`, or `try` expressions at leaf positions

## Rationale

- Prevent accidental AST changes caused by whitespace-only edits
- Stabilize diff- and patch-based workflows
- Reduce structural inference burden for AI-assisted tools
- Preserve long-term readability and maintainability

## Design Intent

Scala 3 indentation-based syntax is treated as an optional convenience,
not as a default coding style.

Explicit braces are preferred whenever code longevity, patchability,
or semantic clarity is more important than brevity.


# Documentation Format and Patchability Rules

This section defines conventions for choosing documentation formats,
with particular emphasis on **patchability**, **AI-assisted editing**,
and long-term maintainability.

## Principle

- Documents that are expected to be **frequently edited, patched, or partially updated**
  MUST use **Markdown**.
- Documents written in **RFC-style formats** (numbered sections with separator lines)
  SHOULD be treated as **frozen or near-final specifications**.

This distinction exists because patch-based workflows (diff / apply),
including AI-assisted edits, rely on stable and unambiguous structural anchors.

## Rationale

- Markdown provides strong structural anchors:
  - Headings (`#`, `##`)
  - Lists
  - Code blocks
- These anchors significantly improve:
  - Patch accuracy
  - Context matching
  - Partial updates by tools and AI agents

RFC-style documents rely on visual separators and sequential reading,
which makes automated patch application fragile and error-prone.

## Rules

- **Markdown is the default format** for:
  - RULE.md
  - README.md
  - Design documents
  - Idiom catalogs
  - Any document expected to evolve incrementally

- **RFC-style formats MAY be used only when**:
  - The document is considered finalized or frozen
  - Incremental patching is not expected
  - The document is primarily intended for linear human reading

## AI Collaboration Note

When requesting patches or incremental edits from AI tools:

- Markdown MUST be used
- RFC-style documents SHOULD be avoided
- If RFC-style output is required for presentation,
  it should be generated *from* a Markdown source, not edited directly

## Design Intent

These rules ensure that documentation remains:

- Patch-friendly
- Reviewable via diffs
- Suitable for long-term AI-assisted maintenance


# Specification vs Design Documentation Rule

This project distinguishes between **specification (spec)** and **design** documentation.
This distinction is critical to prevent premature stabilization of evolving designs
and to keep long-term contracts explicit and trustworthy.

## Specification (spec)

Specification documents define **external contracts** that users and downstream code
are allowed to depend on.

A statement belongs to **spec** if and only if:

- Breaking or changing it would constitute a **breaking change**
- Downstream code is expected to rely on the behavior
- The behavior is considered stable and intentional

Typical contents of spec documents include:

- Public type semantics
- Method contracts and failure models
- Builder and construction semantics
- Error-handling guarantees
- Explicitly forbidden behaviors

Specification documents SHOULD live under:

```
docs/spec/
```

## Design

Design documents describe **rationale, alternatives, and evolving decisions**.

A statement belongs to **design** if:

- It explains *why* a design was chosen
- Alternative approaches are discussed
- The behavior may change based on usage or feedback
- Changing it would NOT necessarily break downstream code

Typical contents of design documents include:

- Design motivations and background
- Rejected or deferred alternatives
- Ergonomic considerations
- Open questions and future directions

Design documents SHOULD live under:

```
docs/design/
```

## Mixed Documents (Recommended During Exploration)

During active exploration, a single document MAY contain both spec and design content.

In such cases:

- Spec content MUST be clearly marked (e.g. “Stable Semantics”)
- Design content MUST be clearly marked (e.g. “Design Notes”)
- The document MUST state which sections are normative and which are not

## Rule of Thumb

When deciding where a statement belongs, ask:

> **Would changing this require a major or breaking version bump?**

- YES → Specification
- NO / MAYBE → Design

# Idiom Reference Rules

This project defines reusable design idioms to capture
commonly recurring structural and semantic patterns.

Idioms are used to express *recommended design solutions* and
shared architectural vocabulary, while keeping this document
focused on normative rules.

## Role of Idioms

- Idioms represent **recommended design patterns**
- They document proven structures and conventions
- Idioms are descriptive, not normative

## Reference Rules

- When a known idiom applies, it SHOULD be referenced **by name**
  (e.g. `ValueBackedAbstractObject`)
- Idioms MAY be referenced in:
  - Design discussions
  - Code reviews
  - AI-assisted code generation prompts

## Priority

- Idioms MUST NOT override rules defined in this document
- If a rule and an idiom conflict, the rule takes precedence

## Documentation

- Idioms are documented under `docs/idioms/`
- Each idiom is defined in a standalone Markdown document

# Working Specification Rule

This project adopts a **dual specification approach** for important core semantics.

## Principle

- Specifications are written in **two complementary forms**:
  1. **Markdown specification** (design intent, contracts, semantics)
  2. **ScalaTest working specification** (executable, verifiable behavior)

These two forms are treated as a **paired specification set**.

## Rules

- Core semantics (e.g. `Consequence`, `Conclusion`, validation, aggregation)
  SHOULD be specified using both:
  - A Markdown document under `docs/spec/`
  - A ScalaTest specification (e.g. `AnyWordSpec`)
- The ScalaTest specification acts as an **executable specification**
  and MUST remain consistent with the Markdown specification.
- When behavior changes:
  - Both the Markdown spec and the ScalaTest working spec MUST be updated together.

## Design Intent

- Markdown specs capture **human-readable intent**
- ScalaTest specs provide **mechanically enforced guarantees**
- Together, they prevent:
  - Spec drift
  - Undocumented behavior changes
  - Accidental semantic regression

## Guidance

- Tests SHOULD be written as Executable Specifications by default.
- Prefer narrative-style ScalaTest specs (`AnyWordSpec`, `AnyFreeSpec`)
  for working specifications.
- Test names SHOULD read as executable sentences describing behavior.
- Modified behavior specs SHOULD use `should` / `which` / `in` grouping when
  they cover multiple feature areas, command groups, or lifecycle phases.
- `Given` / `When` / `Then` SHOULD be placed at the actual setup / action /
  expectation boundaries, not emitted as a consecutive prose block detached
  from the code it describes.
- Executable Specifications SHOULD use `should` matchers or reusable
  specification vocabulary instead of raw `assert`.
- Generic reusable specification vocabulary SHOULD live in shared libraries
  rather than project-local helper traits.
- Working specifications MAY include documentary tests
  that exist only to express design constraints.

This rule applies incrementally and MAY be adopted gradually
for existing code.

# Test Policy

This project follows a documented test policy.

The authoritative specification is defined in:

    docs/spec/test-policy.md

----------------------------------------------------------------------
ExecutionContext Rules
----------------------------------------------------------------------

ExecutionContext is the central execution model of goldenport core.

All execution assumptions required by core logic MUST be provided
explicitly via ExecutionContext.

Core code MUST NOT rely on implicit JVM, OS, or library defaults.

----------------------------------------------------------------------
Context Usage Rules
----------------------------------------------------------------------

- All core logic MUST receive execution-related assumptions
  via org.goldenport.context.ExecutionContext.

- Core code MUST NOT directly access:
  - system time (e.g. Instant.now, LocalDate.now)
  - default locale or timezone
  - ad hoc date, time, number, or currency formatters
  - default encoding
  - random number generators
  - math precision defaults

- All such values MUST be modeled explicitly in ExecutionContext, including:
  - locale
  - timezone
  - encoding
  - date, time, datetime, number, and currency formatting policy
  - clock / time source
  - math context
  - random sequence

- ExecutionContext MUST be immutable and explicitly injected.

- ExecutionContext MUST be test-constructible without CNCF.

----------------------------------------------------------------------
CNCF Formatting Rules
----------------------------------------------------------------------

CNCF components MUST use the runtime formatting context for
locale-sensitive behavior.

- Component logic MUST read locale, timezone, and formatting policy from:
    ExecutionContext.runtime.context.formatting

- Component logic MUST NOT directly use:
  - Locale.getDefault
  - ZoneId.systemDefault
  - JVM-default date/time formatters
  - JVM-default number or currency formatters

- Operation inputs for locale, timezone, and formatting SHOULD be optional
  unless the domain contract explicitly requires the caller to choose them.

- When a domain entity needs a durable timezone or regional interpretation,
  the component SHOULD resolve the omitted value from the runtime formatting
  context at creation time and persist the resolved value.

- Date/time and numeric parsing or rendering SHOULD use CNCF formatting
  helpers or helpers derived from the runtime formatting context, not
  project-local hard-coded formatter policy.

- Tests for date/time or numeric behavior SHOULD build an ExecutionContext
  with explicit locale, timezone, and formatting policy when the result would
  otherwise depend on the developer machine or CI host.

----------------------------------------------------------------------
Logging Rules
----------------------------------------------------------------------

Logging in goldenport core is treated as a capability,
not as infrastructure.

- All logging in core MUST be performed via:
    ExecutionContext.logger

- Core code MUST NOT:
  - access logging frameworks directly
  - use static or global loggers
  - manage logging configuration or output destinations

- Logger is an interface defined by goldenport.

Implementation policy:
- Core provides SLF4J-based Logger adapters.
- CNCF provides OpenTelemetry-based Logger adapters.
- Tests provide recording or in-memory Logger implementations.

----------------------------------------------------------------------
RuntimeContext Boundary Rules
----------------------------------------------------------------------

RuntimeContext is a CNCF concern and MUST NOT leak into goldenport core.

- Core code MUST NOT:
  - depend on runtime state (retry count, thread, transaction)
  - depend on execution lifecycle
  - access CNCF RuntimeContext directly

- CNCF MAY project information from RuntimeContext
  into ExecutionContext, but this projection MUST be explicit.

----------------------------------------------------------------------
Defaults Prohibition Rules
----------------------------------------------------------------------

The following are prohibited in goldenport core code:

- Locale.getDefault
- ZoneId.systemDefault
- Charset.defaultCharset
- Instant.now / LocalDate.now / ZonedDateTime.now
- scala.util.Random
- default MathContext
- static logger acquisition

Any use of such functionality MUST be mediated by ExecutionContext.

----------------------------------------------------------------------
Context Rules
----------------------------------------------------------------------

- Contexts MUST be value-backed and immutable.
- Contexts MUST NOT perform I/O, detection, or inference.
- Contexts MUST be constructed explicitly during bootstrap.
- ExecutionContext MUST only compose sub-contexts and MUST NOT add or reinterpret semantics.

----------------------------------------------------------------------
Naming and Import Rules
----------------------------------------------------------------------

- org.goldenport.context.ExecutionContext is the canonical ExecutionContext
  of goldenport.

- scala.concurrent.ExecutionContext MUST be imported with an alias, such as:
    import scala.concurrent.{ExecutionContext => ScalaExecutionContext}

- Direct usage of scala.concurrent.ExecutionContext without alias
  is prohibited in goldenport code.

----------------------------------------------------------------------
Rationale
----------------------------------------------------------------------

These rules ensure that:

- execution assumptions are explicit and modeled
- testability and reproducibility are guaranteed
- core remains independent of CNCF runtime concerns
- configuration-driven behavior remains extensible
- multi-language and time-sensitive behavior is verifiable

Violation of these rules leads to:
- hidden dependencies
- non-reproducible tests
- brittle runtime behavior
- loss of architectural clarity

----------------------------------------------------------------------
CNCF CAR Web UI Recommendation
----------------------------------------------------------------------

When a CAR includes a built-in Web UI and the project has no stronger
product-specific frontend requirement, use Bootstrap plus Material Design.

This is a strong recommendation, not a mandatory platform rule. The
combination is already established across `textus-*` components and integrates
well with CNCF Web packaging, generated admin surfaces, and automatic REST.

Recommended built-in CAR UI approach:
- Declare the CNCF Web UX profile as `bootstrap-material` when the CAR uses
  CNCF-hosted built-in Web UI:

      web:
        profile: bootstrap-material

- Use Bootstrap layout, forms, buttons, tables, cards, and utility classes.
- Use Material Icons or an equivalent Material icon set.
- Use Material Design visual language for spacing, color, controls, and
  status presentation.
- Package Web assets inside the CAR and serve them through CNCF Web packaging.
- Do not make external CDN access a requirement for the built-in UI.
- Keep Web UI behavior on top of component operations, automatic REST, and
  generated admin behavior; do not create a separate UI-only domain path.

If a project needs a highly custom UI stack, SPA framework, native frontend,
or product platform outside this recommendation, prefer placing that Web tier
outside CNCF. The external Web tier should use CNCF automatic REST, client, or
command surfaces while the CAR remains responsible for domain behavior and
persistence.

----------------------------------------------------------------------
CNCF HTTP Driver and Internal DSL Rules
----------------------------------------------------------------------

CNCF component code MUST use the CNCF internal DSL for outbound HTTP access.

- Component code MUST NOT directly use:
  - java.net.http.HttpClient
  - curl-style process execution
  - project-local ad hoc HTTP clients

- Component code SHOULD use the internal DSL, such as:
  - http_get
  - http_post
  - UnitOfWorkOp.HttpGet
  - UnitOfWorkOp.HttpPost

- HTTP driver selection, configuration, execution policy, timeout behavior,
  observability, and test substitution are CNCF runtime responsibilities.

The internal DSL is required so that outbound HTTP access can participate in:
- CNCF observability and calltree tracking
- runtime security and capability checks
- outbound destination allow/deny policy
- audit, metrics, retry, and timeout policy
- deterministic fake or fixture drivers in tests

Component-level providers and parsers SHOULD focus on interpreting HTTP
responses and mapping failures to domain results. They SHOULD NOT decide how
HTTP is executed.

Recommended error mapping:
- transport, timeout, or driver failure: network_error
- non-2xx or unusable source response: source_error
- fetched content that the parser cannot interpret: parse_error
- no registered parser for the target source: unsupported_fetch

----------------------------------------------------------------------
Scala Header Version Update Rules
----------------------------------------------------------------------

These rules define how to maintain `@version` history in Scala file header comments.

Scope:
- Applies to Scala files (`*.scala`) edited in the current task.
- Apply this update as part of the file edit, not only at commit time.
- Before committing, re-check all Scala files included in the commit and exclude deleted files.
- Repository-managed product Scala sources and executable specifications,
  including files under `src/main/scala` and `src/test/scala`, MUST have a
  version-history header. A missing header in an existing product source or
  specification is historical maintenance debt and MUST be repaired when the
  file becomes a task or review target.
- This missing-header repair requirement does not apply to sample, example, or
  demo source trees, generated output, vendored or third-party source, or build
  output unless a repository-local rule explicitly opts those files in.

Date format:
- Use current system date with:
    `%b. %e, %Y`
- Example:
    `Mar. 24, 2026`

Target comment lines:
- Current version line:
    ` * @version <date>`
- History line:
    ` *  version <date>`

Formatting rule:
- `@version` line MUST use one space after `*`.
- History `version` line MUST preserve the existing two-space style.

Update behavior:
1. Normalize to the canonical final shape.
   - The final version block is authoritative even when the file was already broken
     before the current edit.
   - A valid final version block has:
     1. `@since`, if present
     2. preserved `*  version ...` history lines in original relative order,
        after cleanup rules are applied
     3. exactly one latest `* @version ...`
     4. non-version metadata such as `@author`
   - There must be no `*  version ...` line after the final `* @version ...`.
   - There must be no multiple `* @version ...` lines.
   - There must be no `*  version ...` line whose date is the same as `@since`.
   - A `*  version ...` line in the same month/year as `@since` is valid when
     the day differs from `@since`.
   - There must be no `*  version ...` line in the same month/year as the final
     latest `@version`.
2. Detect `@version` by searching the complete changed file, not only the file beginning.
   - Scala/Java Scaladoc/Javadoc version comments commonly appear immediately before
     the target `class`, `object`, `trait`, `interface`, or `enum`, after `package`
     and `import` declarations.
   - Use a full-file marker search such as:
       `rg -n '@since|@version|@author|^[[:space:]]*\*[[:space:]]+version' <file>`
   - Parse the complete comment block that contains the relevant version markers.
   - If no version marker exists anywhere in a repository-managed product source
     or executable specification, add the repository's standard version-history
     header. Do not preserve the missing marker as a convention.
   - Recover `@since` from the earliest reliable repository evidence, such as the
     file-introduction commit or an authoritative source record. For a new file,
     use its actual creation date. If no earlier date can be established, use the
     actual header-repair date and do not invent an earlier date.
   - Preserve the repository's established author attribution when it is known;
     do not fabricate attribution.
   - For excluded sample/generated/vendor/build-output files, preserve the local
     convention unless a repository-local rule explicitly requires a header.
3. Replace latest `@version` with today's date.
4. Preserve history:
   - Replaced `@version` entries MUST be converted to history entries:
       ` *  version <old-date>`
5. Deduplicate:
   - Exactly one `@version` line MUST remain.
   - Multiple history lines are allowed.
   - If multiple `@version` lines exist, keep only the latest as `@version`,
     convert others to history lines.
   - Month compression:
     - If history entries contain the same month/year as the final latest `@version`,
       those same-month history entries MUST be removed.
     - This applies to both already-existing `*  version ...` history lines and
       lines converted from older `* @version ...` entries.
     - `@version` represents the latest edit in the month; same-month history
       lines are compressed into that single `@version`.
     - This compression applies to the latest `@version`, not to `@since`.
       A same-month history line under `@since` is preserved when the day differs.
     - If the `@since` same-month preservation rule and the final latest `@version`
       same-month compression rule both match, the final latest `@version`
       compression rule wins.
     - Example:
       - Before:
           `*  version Mar. 20, 2026`
           `* @version Mar. 24, 2026`
       - After:
           `* @version Mar. 24, 2026`
6. Insert:
   - If no `@version` exists and `@since` exists, insert `@version` immediately after `@since`.
   - If neither exists in a required product source or executable specification,
     create or extend the standard header comment before the primary top-level
     definition, after package/import declarations, and insert `@since` followed
     by `@version`.
   - If neither exists in an excluded file, preserve the local convention unless
     a repository-local rule opts the file in.
7. Constraints:
   - Do not modify code outside comments.
   - Preserve comment indentation and style.
   - Do not reorder existing history lines.
   - Do not remove existing history entries, except by the month-compression rule above.
8. Git integration:
   - Re-stage files after comment updates.

----------------------------------------------------------------------
Defensive Complexity and Failure Model Rules
----------------------------------------------------------------------

These rules prevent speculative robustness mechanisms from increasing implementation complexity without an explicit requirement.

Principle:
- Robustness is a modeled requirement, not an implementation embellishment.
- Defensive mechanisms MUST be traceable as:
    Failure Model -> Required Robustness -> Mechanism
- The implementation MUST prefer the simplest mechanism that satisfies the explicitly stated execution and failure model.

Failure model:
- Before introducing a defensive mechanism, identify the concrete failure it is intended to handle.
- The failure MUST be part of an explicit requirement, specification, architectural decision, established runtime contract, demonstrated failure scenario, or supplied resolved Failure Model.
- A failure MUST NOT be treated as in scope merely because it is technically possible.
- Execution Model defines the operating assumptions and may select a default Failure Model.
- Failure Model may be declared and refined at architectural scopes such as Component, Service, and Operation.
- When a Resolved Failure Model is supplied, it is the authoritative implementation boundary. AI MUST consume it as given and MUST NOT reinterpret inheritance/defaults or silently extend it.
- An IN_SCOPE failure permits only the robustness required by the specification; it does not by itself justify any particular mechanism.
- An OUT_OF_SCOPE failure is a negative implementation constraint. Code MUST NOT add machinery whose purpose is solely to defend against that failure.
- When the execution model already excludes a failure (for example, a local single-user or single-writer operation), code MUST NOT add machinery to defend against that excluded failure.
- If implementation work reveals a materially relevant failure absent from the supplied model, AI MUST surface it as a model/specification gap and defer expansion of robustness until the authoritative model is updated.

Prohibited speculative defenses:
- Do NOT introduce checksums, content hashes, repeated file identity checks, locks, retries, backup copies, rollback mechanisms, duplicate validation, redundant existence checks, or equivalent defensive machinery solely:
  - "just in case"
  - for hypothetical future requirements
  - because another process could theoretically interfere
  - because an additional check appears safer in isolation
- Do NOT stack multiple defensive mechanisms for the same failure unless the specification requires distinct guarantees that justify each mechanism.

Mechanism selection:
- Use the least complex mechanism that provides the required guarantee.
- Prefer assumptions already guaranteed by the execution model over re-verifying those assumptions in code.
- Prefer a direct read/transform/write flow when concurrent modification is outside the failure model.
- If crash consistency is required, use the platform's appropriate atomic-write mechanism rather than adding unrelated integrity checks.
- If concurrent modification is explicitly in scope, use the architecture's established concurrency/versioning mechanism rather than inventing local hash-based protocols.

Justification and review:
- A non-trivial defensive mechanism MUST have a reviewable justification identifying:
  1. the failure model,
  2. the required guarantee,
  3. why the selected mechanism is the simplest adequate mechanism.
- Comments MUST NOT be used to manufacture a requirement that does not exist in the specification or architecture.
- During review, defensive code without such traceability SHOULD be removed rather than preserved as harmless extra safety.

Complexity discipline:
- Defensive code has a complexity cost and MUST be treated as such.
- Defensive mechanisms are themselves potential failure sources: additional state, branches, checks, and recovery paths increase the implementation surface in which defects can occur.
- Robustness MUST NOT be increased by default when doing so reduces simplicity, testability, or reliability for the declared Execution Model.
- A local safety improvement MUST NOT be accepted when it materially complicates the normal path without a corresponding system requirement.
- For local single-user/single-writer tools, concurrency and interference protection SHOULD remain minimal unless the Failure Model explicitly brings those failures into scope.
- When defensive handling becomes comparable to or larger than the normal operation, re-evaluate the failure model and architecture before adding more checks.

Repository Script Placement Rules
----------------------------------------------------------------------

These rules define the source-tree placement of repository-managed script
entry points.

Scope:
- Applies to executable entry scripts maintained by a repository under
  `scripts/`.
- Does not classify generated scripts or runtime/test work artifacts under
  `target/`.

Operational entry points:
- Operator-facing runtime, build, setup, maintenance, publication, migration,
  and generation entry scripts MUST be placed directly under `scripts/`.
- The `scripts/` root is the discoverable operational command surface. An
  operational entry point MUST NOT be hidden under `scripts/test/`.

Test entry points:
- Scripts whose sole purpose is test, verification, fixture execution, test
  data preparation, or test-environment setup MUST be placed under
  `scripts/test/`.
- A script does not become operational merely because CI invokes it. Classify
  it by its purpose and side effects.
- A test-only entry point MUST NOT be placed directly under `scripts/`.

Shared helpers:
- Non-entrypoint helpers shared by operational scripts MAY be placed under
  `scripts/lib/`.
- Non-entrypoint helpers and fixtures used only by test scripts MAY be placed
  under `scripts/test/lib/` or another clearly test-owned subtree of
  `scripts/test/`.
- Helper files MUST NOT masquerade as operator-facing entry points.

Migration:
- New and moved scripts MUST follow this layout immediately.
- Existing nonconforming scripts SHOULD migrate when touched unless a
  repository-wide migration handles them together.
- A repository-specific exception MUST be explicit in
  `docs/rules/shared-directive-exceptions.md`; directory history or existing
  placement alone is not an exception.

----------------------------------------------------------------------
Work Artifact Placement Rules
----------------------------------------------------------------------

These rules define where runtime/test work artifacts MUST be created.

Scope:
- Applies to temporary runtime files and local execution artifacts
  (for example: sqlite/db files, generated local config files, scripted work outputs).

Placement:
- Work artifacts MUST be created under `target/` only.
- Preferred layout:
  - `target/<tool>/work/<context>/...`
  - Example: `target/scripted/work/user-account/scripted-user-account.sqlite`
- Runtime/config files used only for local verification SHOULD be created under:
  - `target/<tool>/config/...`

Prohibitions:
- Do NOT create work artifacts at repository root.
- Do NOT place local runtime artifacts under `src/`, `docs/`, or tracked production paths.

Cleanup:
- Scripts/tests SHOULD remove work artifacts after execution unless retention is explicitly requested.
- Work artifact directories MUST remain safe to remove as a whole.

Git:
- Work artifacts are non-source outputs and MUST NOT be committed.
