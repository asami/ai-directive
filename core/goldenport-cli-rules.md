Goldenport CLI Rules
====================

This document defines rules for command-line tools that use the Goldenport
toolchain.

These rules apply to both Scala 2 and Scala 3 projects. The invariant is
shared, but the concrete parser API and remediation path differ by project
generation.

# Grammar Authority

Goldenport command-line tools MUST use the Goldenport-provided parameter parser
as the source of truth for argument interpretation.

Command implementations MUST NOT introduce command-local grammar, command-local
normalization, command-local compatibility behavior, or command-local rejection
rules for parameter forms. The parser layer owns both accepted and rejected
syntax.

If a required parameter capability is missing, fix or extend the Goldenport
parameter parser. Do not work around it in the individual command implementation.

# Parameter Metadata

Command options MUST be declared as parameter metadata before relying on parser
behavior.

The canonical `--key value` form requires the parser to know whether `--key` is
a property that consumes the following token or a switch that consumes no value.
Do not recover from missing metadata by adding command-local token scanning.

Parameter metadata is also the primary mechanism for validation and typed value
conversion. Command implementations SHOULD consume typed parser results instead
of re-validating raw strings in command-local code.

For each command surface, define parameters for:

- positional arguments
- properties that require or allow values
- switches that do not consume values
- expected datatypes
- multiplicity
- defaults and optionality
- aliases, when the parser stack supports them
- constraints, when the parser stack supports them

Generated help, command examples, tests, and scripts MUST be derived from or
kept consistent with this metadata.

# Scala 2 Handling

Scala 2 command projects, including Cozy-style command surfaces, MUST use the
Goldenport Scala 2 CLI stack available to that project.

Typical Scala 2 entry points are:

- `org.goldenport.cli.Request.create`
- `org.goldenport.cli.spec.Operation`
- `org.goldenport.cli.spec.Parameter.argument`
- `org.goldenport.cli.spec.Parameter.property`
- `org.goldenport.cli.spec.Parameter.SwitchKind`
- `org.goldenport.cli.spec.Request`
- `org.goldenport.cli.spec.Response`

The Scala 2 stack has `SwitchKind`, but the current helper set may not include a
`Parameter.switch` factory. Use the existing Scala 2 API exactly as provided, or
add a helper to `goldenport-scala-library` first before using it from command
projects.

Use Scala 2 metadata for validation and conversion:

- `datatype`
- `multiplicity`
- `default`
- `Parameter.cFile`
- `Parameter.cConfig`
- `Parameter.cInputSourceList`
- `Parameter.cPowertype`
- `Request.cAny`, `Request.cFile`, `Request.cConfig`, and related typed accessors

Scala 2 command implementations MUST NOT parse option tokens by hand in command
code when the Goldenport Scala 2 CLI stack can define or resolve the command
surface.

When a Scala 2 command needs syntax that the Scala 2 parser does not support:

- Add or fix that capability in the Goldenport Scala 2 parser layer.
- Add parser-level tests in the Scala 2 library or project that owns that
  parser behavior.
- Then update the command surface to use the parser result.

Do not copy Scala 3 parser behavior into Scala 2 command code as local
normalization.

# Scala 3 Handling

Scala 3 command projects, including simplemodeling-lib style command surfaces,
MUST use the Goldenport Scala 3 parser/protocol stack available to that project.

Typical Scala 3 entry points are:

- `org.goldenport.cli.parser.ArgsParser`
- `org.goldenport.cli.logic.CliLogic`
- `org.goldenport.protocol.*`
- `org.goldenport.protocol.spec.ParameterDefinition`
- `org.goldenport.protocol.spec.RequestDefinition`

Use Scala 3 metadata for validation and conversion:

- `ParameterDefinition.kind`
- `ValueDomain`
- `datatype`
- `multiplicity`
- `constraints`
- `default`
- `aliases`
- confidentiality and web metadata when relevant

Scala 3 command implementations MUST NOT bypass `ArgsParser` with command-local
token parsing. If command syntax needs to change, update the Scala 3 parser and
its parser specs first.

Existing Scala 3 parser behavior is authoritative for Scala 3 projects. For
example, if the Scala 3 parser specs accept an equals-form option such as
`--query=...`, shared directives MUST NOT declare that form invalid unless the
Scala 3 parser specification is changed first.

# Option Syntax

The canonical Goldenport option-value syntax is the separate-token form:

```
--key value
```

New command help, documentation, examples, generated scripts, and tests SHOULD
use the canonical separate-token form unless they are specifically testing
parser compatibility behavior.

An equals-form option:

```
--key=value
```

MAY be accepted by a Goldenport parser as compatibility behavior, but Codex MUST
NOT introduce it into new command surfaces, help text, documentation examples,
generated scripts, or workflow plans as the primary form.

If a project intentionally supports `--key=value`, encode that support in the
relevant Goldenport parser specification and parser tests, and keep examples
that use the equals form clearly scoped to compatibility tests.

If a project intentionally rejects `--key=value`, encode that rejection in the
relevant Goldenport parser specification and parser tests. Do not enforce the
policy by adding ad hoc checks inside each command implementation.

Cross-version behavior changes must be made explicitly in the Goldenport parser
design for each versioned stack. A Scala 2 command may not infer support or
prohibition from a Scala 3 parser test, and a Scala 3 command may not infer
support or prohibition from a Scala 2 command convention.

# Documentation And Tests

Help text, generated scripts, examples, tests, and implementation plans MUST use
the same Goldenport grammar as the target project generation.

Rationale:

- Goldenport parser behavior is the shared command contract.
- Command-local parsing drift creates inconsistent command surfaces.
- A syntax form is valid only when the relevant Goldenport parser stack defines
  it as valid.
