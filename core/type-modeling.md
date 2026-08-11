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
