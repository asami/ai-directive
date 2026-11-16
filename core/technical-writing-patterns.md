# Section Explanation Patterns

Status: Normative through [Technical Writing Rules](technical-writing.md)

Rule map: [Core Rule Map](AGENT.md#core-rule-map)

<a id="適用範囲と役割"></a>
## Scope and purpose

Use this catalog to choose how a section or subsection develops its explanation in the logic tree and in the text. The [document structure templates](technical-writing-templates.md) organize the document as a whole. Explain the evidence, causes, and structural relationships that support each claim using the subject matter, following the [shared rules](technical-writing.md).

Establish the question through the context, problem, or purpose the reader needs. Give the central answer, then develop the explanation that supports it. The answer may be a definition, judgment, policy, or account of how something works. Reuse context established at a higher level.

<a id="パターンの選択"></a>
## Choosing a pattern

Choose one principal pattern for each section or subsection according to the question it answers. Authors can specify its Japanese name, English name, or ID.

| Japanese name | English name | ID | Reader’s question | Development | What the reader can do afterward |
| --- | --- | --- | --- | --- | --- |
| 定義型 | Definition | `definition` | What is it? | Establish the context, define the subject, then describe its properties, scope, and boundaries. | Use the defining properties to explain why a case falls inside or outside the stated scope. |
| 必要性型 | Rationale | `rationale` | Why is it needed? | Give the purpose and current situation, identify the need, then explain the reasons and conditions. | Identify the goal at stake and explain why the current situation creates a need under the stated conditions. |
| 課題対応型 | Problem–Solution | `problem-solution` | How can we address the problem? | Identify the problem and response, connect the remedy to the cause, then give the effects and conditions. | Connect the response to the cause and identify a result that would show whether it addressed the problem. |
| 構成分解型 | Decomposition | `decomposition` | What are its parts? | Give the purpose and overall structure, then explain each part’s role and relationships. | Identify each part’s responsibility and explain how the parts connect to serve the whole. |
| 仕組み型 | Mechanism | `mechanism` | How does it work? | Identify the goal and key mechanism, trace the causal steps, then give the results and conditions. | Trace how an action produces the result and identify the conditions on which that causal link depends. |
| 比較選択型 | Comparison | `comparison` | How do the options compare? If a choice is needed, which option fits which conditions? | State the main finding, then compare the options on common criteria and give the supporting evidence. When the section calls for a decision, explain the conditions for choosing. | Explain the relevant similarities and differences and why they matter. For a decision, identify which option fits the stated conditions and why. |
| 実施方法型 | Procedure | `procedure` | How do we do it? | State the goal, outline the method, give prerequisites and steps, and verify the result. | Recognize when the prerequisites hold, carry out the steps, and check the outcome. |
| 具体例型 | Worked Example | `worked-example` | What happens in practice? | Identify the point and summarize the case, trace conditions, behavior, and results, then relate them to the general explanation. | Trace the case from its starting conditions to its result and identify the general point it illustrates. |

Choose Rationale to explain a need and Problem–Solution to develop a specific response. Decomposition explains parts and relationships. Mechanism explains how an action produces a result. For a comparison without a selection, give the similarities and differences as the central answer, followed by the evidence and the conditions relevant to judgment.

Apply patterns recursively. A Decomposition section may have Definition or Mechanism subsections for individual parts. Split independent questions and claims into subsections where appropriate. A short paragraph can cover several explanatory roles in one sentence. Open the parent section with its answer and explain how its supporting points fit together. Give each child a distinct question that develops one of those points, using the context already established by the parent.

For example, a section on order consistency might open with “An order update must satisfy the rules for the order as a whole and the conditions for committing the update.” One subsection answers “What rules must the proposed order satisfy?” A second answers “When can that validated update be committed?” Together they explain how a valid proposal becomes a committed change.

<a id="coreとロジックツリーでの表現"></a>
## Representation in the Core and logic tree

Before drafting, relate the following for each section and subsection:

- **Pattern.** The catalog name or ID.
- **Question.** What the reader wants to understand, decide, or do.
- **Context.** The background, problem, or purpose needed to understand the question and claim.
- **Claim.** The central answer.
- **Supporting explanation.** The parts called for by the chosen pattern and how each supports the claim.

In an HTML logic-tree review or equivalent view, show the pattern, question, and claim for each unit. Beneath the claim, show the roles and actual content of its supporting parts, such as definitions, evidence, components, actions, conditions, steps, and results. Make reading order and logical support independently inspectable.

Distinguish a section’s role (such as “structure”), its explanatory pattern (such as Decomposition), and its logical relationships. A pattern name alone gives no account of how a child supports its parent. Preserve the structure DSL’s own logical patterns, including `mapping` and `causal-chain`.

Use the supported Core, Document, and review-view mechanisms without adding undefined fields or enumeration values. Where the format cannot store a selection, record it in separate authoring material keyed to existing section IDs and provide a corresponding review view. Distinguish what the generator currently displays from what the rules require.

A review view might contain the following entries:

- **Heading.** Using CNCF automatic traces for analysis.
- **Pattern.** Mechanism.
- **Question.** How can applications support analysis without implementing individual observation logic?
- **Context.** Application-specific recording distributes the work of standardizing fields and formats.
- **Claim.** Converting CNCF automatic traces into a common observed model provides records for several kinds of analysis.
- **Mechanism.** Shared infrastructure captures records and relates executions, calls, and measurements in the model.
- **Result and conditions.** Analysts can reuse methods against the model when the records and measurement scope required by each analysis are available.

These labels belong to the authoring review. Use the actual technical content in the publication. The same Core entries could yield this passage:

> CNCF captures traces in shared infrastructure, so each application can supply data for analysis without implementing its own recording logic. The observed model links an execution to its calls and each call to its measurements. Analysts can apply the same method across applications when their traces contain the records the method needs and cover the operations it measures.

<a id="本文への展開と確認"></a>
## Drafting and verification

Follow the pattern from the necessary context to the claim and its supporting explanation. Choose reader-facing headings and prose that describe the subject. Use a role name in the text when it carries technical meaning.

Check each section and subsection after drafting:

- The opening passage identifies the issue and answers the reader’s question.
- The reader can meet the selected pattern’s criterion in the table, and its explanation and subsections support the claim.
- The subject matter explains the evidence, causal relationships, and conditions.
- The passage builds on earlier context and contains only material relevant to the claim.
- The published text matches the reviewed tree and keeps authoring instructions in the authoring material.

If the question, claim, or pattern changes, update the correspondence between the Core, authoring material, review tree, and text. For each new catalog pattern, define its question, where the claim appears, how the explanation develops, when to use it, and what the reader should be able to do afterward.
