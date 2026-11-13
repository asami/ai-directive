# Collection and Semi-Structured Data Modeling

When working in a project whose architecture provides Goldenport Record/CNCF data
modeling, preserve the project's semantic data representation instead of replacing
it with generic Scala containers.

- MUST preserve meaningful input/property ordering.
- MUST NOT convert an ordered property list or semi-structured named data to
  `Map[String, X]` merely for convenience and later reconstruct it from Map iteration.
- MUST use the project's `Record` abstraction for semi-structured/property data
  when that abstraction is the project convention; nested semi-structured data
  uses nested Records.
- SHOULD use `Vector` as the ordinary ordered sequence and `NonEmptyVector`
  when one-or-more is a semantic contract.
- SHOULD avoid `List` as a default collection; use it only for genuine
  list-specific semantics/algorithms.
- MUST reserve `Map` primarily for actual keyed lookup/index/registry/cache
  requirements or another explicitly justified performance/semantic need.
- MUST NOT replace a Record with Map when doing so discards Record-provided
  property/navigation/conversion/merge behavior or risks order loss.
- SHOULD keep an internal Map index subordinate to the authoritative ordered
  representation when both ordering and fast lookup are needed.
- MUST follow the project's result/error abstraction (for CNCF/Goldenport,
  `Consequence`) rather than introducing Cats `ValidatedNel` as a parallel
  default validation model.

Before introducing Map/List or a new collection helper, check whether the existing
Record/Vector/NonEmptyVector and project utilities already express the intended
model. Do not add a generic abstraction merely because it is idiomatic in unrelated
Scala code.
