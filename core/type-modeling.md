# Type Modeling Rules for Scala 2 and Scala 3

## Summary

Choose a type construct by the meaning it expresses in the model, rather than
by a default preference for one language feature. This rule applies to Scala 2
and Scala 3, while recognizing Scala 3 constructs that express closed or
zero-cost domain distinctions directly.

## Scope and Authority

This is a shared core rule for Scala 2 and Scala 3 type modeling. Its place in
the shared rule set is defined by the [Core Rule Map](AGENT.md#core-rule-map);
the normative rule body remains only in this document.

## Core Rule

- Use an `abstract class` for a conceptual core, inheritance invariants, or
  state / constructor semantics.
- Use a `trait` for an auxiliary capability, mix-in, or type class.
- In Scala 3, use an `enum` for closed alternatives or an algebraic data type.
- In Scala 3, use an `opaque type` for a zero-cost domain value type or a
  type-safe semantic distinction.

## Structural Decomposition and Type Identity

**Structural decomposition must not accidentally introduce type identity.**

Splitting source files, extracting implementation traits, or reorganizing
helpers MUST NOT introduce or change domain, DTO, or protocol type identity as
an incidental effect. A value's type MUST reflect its modeled meaning, not
which implementation instance happened to construct it. This is especially
important for values exchanged across Component, Workflow, and StateMachine
boundaries.

Path-dependent types are a legitimate language mechanism when instance-specific
identity is an explicit modeling requirement. Source-size reduction or code
organization is not such a requirement. This distinction does not create an
exception to the data-declaration prohibitions below.

Before accepting structural extraction, reviewers MUST verify that declaration
ownership, assignability across intended producers and consumers, and public
type contracts remain unchanged. Compilation success or the absence of warnings
alone does not establish that these boundaries were preserved. Any intentional
type-identity change requires an explicit model or contract change, not a
structural-refactoring justification.

## Instance-independent Data Types

Data types MUST NOT acquire an enclosing instance merely because an
implementation is split into classes or mix-in traits. This applies to
production code and executable specifications, including private configuration,
result, error, exception, and fixture types.

- Do NOT declare a `case class`, or a data ADT and its concrete alternatives,
  inside an instance-bearing `class` or `trait`.
- Define these types at package level or in a package-level `object` or
  companion object. Their declaration owner chain MUST NOT include an enclosing
  class or trait instance; placing an `object` inside such an owner is not a
  workaround.
- Implementation traits may consume these types through imports or qualified
  names, but MUST NOT own their concrete declarations. A trait may declare an
  abstract type member for a genuine capability contract; do not use it to
  disguise an instance-owned data declaration.
- A singleton implementation, a singleton self-type, `private` visibility, or
  `final` does not exempt a declaration inside a trait from this rule.
- Do NOT introduce this structure to reduce file size, share fixtures, or
  mechanically extract part of a large object into a trait. Move independent
  data declarations to a stable owner before extracting behavior.
- Do NOT accept or suppress `The outer reference in this type test cannot be
  checked at run time` as a solution. New or changed code producing this
  diagnostic MUST have its declaration ownership corrected before acceptance.
  Existing occurrences require an explicit repair scope, not silent acceptance
  or an unrelated mass refactor.

The enclosing instance becomes part of the type's ownership even when the data
does not semantically depend on that instance. This introduces accidental
path-dependent coupling and can leave runtime type tests unable to check the
outer-instance distinction. A successful compilation does not make that design
acceptable. Pass actual context as an explicit value or parameter instead of
capturing an implementation owner in a data type.

Forbidden (Scala 2 and Scala 3):

```scala
trait BuildSupport {
  final case class BuildConfig(project: java.nio.file.Path)
}

object Builder extends BuildSupport
```

Required ownership (Scala 2 and Scala 3):

```scala
object BuildModel {
  final case class BuildConfig(project: java.nio.file.Path)
}

trait BuildSupport {
  import BuildModel.BuildConfig
  def build(config: BuildConfig): Unit
}
```

Reviewers MUST inspect declaration ownership, not only the apparent public
qualifier such as `Builder.BuildConfig`. Confirm that data declarations remain
instance-independent after any implementation or fixture extraction.

## Rationale

- “Everything is a trait” optimizes for technical flexibility, not modeling
  intent.
- Modeling clarity is prioritized so that the chosen type construct
  communicates domain meaning directly.
- Constructor and state semantics belong to the conceptual core, while
  composable capabilities remain auxiliary.
- Closed alternatives and domain-value distinctions should be represented by
  constructs that make those meanings explicit where Scala 3 provides them.

## Examples

- A projection with shared construction semantics is an abstract class.
- An optional rendering capability is a trait.
- A finite lifecycle state in Scala 3 is an enum.
- A validated account identifier in Scala 3 can be an opaque type.

```scala
abstract class Projection[Out] { /* ... */ }

trait OptionalRendering { /* ... */ }

enum LifecycleState { case Draft, Published }

opaque type AccountId = String
```

## Non-goals

- This does not uniformly prescribe whether a model uses a case class.
- This does not prescribe inheritance depth.
- This does not prescribe naming conventions.
- This does not determine whether utility traits are allowed.
