# Technical Writing Rules

Status: Normative through [RULE.md](RULE.md)

Rule map: [Core Rule Map](AGENT.md#core-rule-map)

<a id="適用範囲と役割"></a>
## Scope and authority

Apply these shared rules to technical explanations in specifications, designs, technical guides, references, procedures, articles, and derived summaries, slides, and video scripts. Apply the rules for claims, structure, and evidence to the Content Core and each localized Document. In journals, retain the record format and apply these rules to technical explanations and claims.

Maintain shared rules for reasoning, style, evidence, figures, tables, and lists here. Projects reference them and supply their own glossaries, notation, article structures, and publication practices. Follow [SmartDox Authoring Rules](smartdox-authoring.md) for syntax and [Document Lifecycle](document-lifecycle.md) for the document’s role. Follow the target project’s authorities for emphasis, supported languages, spelling, and terminology. Site-specific conventions apply within their own scope.

<a id="説明の構成"></a>
## Structuring an explanation

**Establish the issue, state the claim, then develop its supporting points from the top down.** Open with enough context, problem, or purpose for the reader to understand the question and answer. Break the claim into its principal points or components, then develop the evidence, conditions, mechanisms, and examples. The upper levels should give an overview from which readers can choose the detail they need.

Apply this structure recursively to the document, chapters, sections, subsections, items, and paragraphs. Each child answers an identifiable question and makes a claim before developing the detail. Siblings address the same parent question. Attach conditions to the claims they qualify. Reuse context established earlier. When readers already share it, a definition can open directly with its main point. Keep both the issue and the claim within the opening passage.

1. **Explain why and what before how.** Identify the purpose or need, the subject, its parts, and its scope. Say what readers will understand, decide, or do, then introduce methods and procedures at a level suited to their knowledge.

2. **Define the concept and show the whole before introducing its parts.** When discussing several aspects, establish their relationship to the common concept. Define unfamiliar terms before relying on them.

3. **Match the hierarchy and order of headings, sections, and paragraphs to the reasoning.** Give each section a distinct role. Establish the premises needed by the next section and make the argument traceable through the headings.

   Put the subject at the root, its main points below it, and evidence, details, and examples under the points they support. Each sentence, figure, table, and list should answer an identifiable parent question or support a claim. When a list previews later explanations, use corresponding names and order.

   Develop the relevant why (purpose, reason, premise) and what (subject, definition, structure, role) in the body of each unit. An opening conclusion followed only by details or steps leaves these connections unexplained. Introduce the question and its supporting points, then place procedures under the point that calls for them. Execution order alone cannot supply the reasoning of the whole document.

4. **Place supporting detail where it serves the main point.** Give background, derived concepts, and implementation details the prominence and depth their purpose requires.

5. **Make the document usable by skimming.** The lead, headings, figures, tables, lists, and summary together should convey the purpose, scope, concepts, mechanisms, decision conditions, and conclusion. Use the body to explain the evidence and details. Check that skimming preserves the argument and its conditions.

<a id="文書構成テンプレートの選択"></a>
## Choosing a document structure template

For explanations of technical concepts, mechanisms, and uses, choose a [document structure template](technical-writing-templates.md) that suits the audience and purpose. Background First starts with the situation and need. Definition First connects the definition and purpose to problems and their responses. Concept to Realization connects a concept to a particular system’s design decisions and runtime behavior. Authors may specify the Japanese name, English name, or ID. The catalog defines the selection procedure, default, and outline of each template.

The shared writing principles above and the rules below apply to every template. Develop the reasoning in the Core from the subject and organize it according to the chosen outline. Keep the template name and rationale in the authoring record. Respect the required structure of the document type and the contract of its DSL.

<a id="節小節の説明パターン"></a>
## Section explanation patterns

For each section and subsection, choose a [section explanation pattern](technical-writing-patterns.md) suited to its question. The catalog includes Definition, Rationale, Problem–Solution, Decomposition, Mechanism, Comparison, Procedure, and Worked Example. Identify the document’s overall structure, each unit’s pattern, and the relationships supporting its claims.

At the Core stage, connect each unit’s question, necessary context, claim, and supporting explanation. Show the pattern and the content of its parts in the logic-tree review view, then write the text accordingly. Apply this recursively, allowing parent and child patterns to differ. The catalog governs pattern definitions, storage, display, drafting, and verification.

<a id="ロジックツリーの論理関係"></a>
## Logical relationships in the logic tree

Show how each child answers its parent’s question and how one claim relates to another. Choose relationships that express the reasoning in the subject matter.

**Table 1. Relationships to make explicit in a logic tree**

| Relationship | What to establish |
| --- | --- |
| Composition or decomposition | Which components or questions explain the parent subject. |
| Evidence or derivation | Which facts or premises support the claim and why. Show how multiple grounds work together when needed. |
| Cause and effect | What acts, under which conditions, and with what result. |
| Premise or condition | What must hold for the claim or effect to apply. |
| Elaboration or example | Which detail or concrete case explains the definition or general claim. |
| Comparison or alternatives | Which options answer the same question and which common criteria or conditions distinguish them. |

State the substance of each relationship in words. If the reason one point supports another is unclear, revisit the claim, the evidence, or the decomposition. Use `next` for reading or execution order. Express logical support separately. Linking a pre-existing outline with `next` alone does not establish a logic tree.

Build the claims and logical relationships before choosing their reading order. Check the whole document and each section for parent–child correspondence and traceable evidence, conditions, and composition. Use the DSL’s defined relationships when recording them.

For a document with a Content Core, perform this check before drafting. From the root through the subsections, identify each question, necessary context, claim, and supporting points. Develop why and what in the Core and explain the actual reasons, causes, and conditions. Turn these relationships into reader-facing prose.

At final review, follow just the headings and openings to check the progression of questions and claims. Then identify which claim each passage, child section, figure, table, or list supports through evidence, mechanism, condition, or example. Check the full explanation under each claim. Where writing exposes a missing relationship or evidence, correct the Core. Validate DSL syntax and references and assess the reasoning separately. Fluent transitions cannot supply a missing premise.

<a id="執筆情報と読者向け情報の境界"></a>
## Authoring information and reader-facing content

Select content that helps the intended reader understand, judge, or act. Use audience and editorial instructions to choose the material, structure, and level of detail. Keep requests, prompts, editorial policies, review history, production steps, handoffs, and internal decisions in authoring records or journals. Publishing those instructions as claims or evidence burdens the reader with production history.

Extract any technical rationale from an instruction and explain the subject’s purpose, mechanism, premises, and constraints. Retain definitions, evidence, scope, implementation status, and known limits needed to judge a claim.

Separate public claims, reasons, and conditions from writing instructions at the Content Core stage. Store private notes in supported private fields or separate material. Keep the published tree, shared claims, Documents, and derived manuscripts free of authoring notes. Use only defined DSL fields.

The following examples illustrate the distinction:

- An instruction to assume engineers know basic authentication sets the level of detail. Apply it directly.
- Keep a reviewer’s request for a duplicate-execution example in the journal. Explain in the article how repeated execution can increase I/O and latency even when the result is unchanged.
- Give compared versions, sources examined, and feature support when readers need them to interpret the result.
- Retain useful reading guidance, such as a note that a table compares cost and quality for identical inputs.

At drafting and final review, check whether each passage tells readers something about the subject or merely how the passage was produced. Move production history back to authoring records or extract its relevant technical content. A reader unfamiliar with the writing conversation must be able to understand the document. Judge meaning in context rather than screening for particular words. Apply this check to leads, headings, labels, captions, lists, summaries, notes, slides, and scripts, including footnotes and figures.

<a id="文体と表現"></a>
## Style and expression

6. **Explain facts, mechanisms, conditions, and causal relationships plainly.** Avoid attention-seeking contrasts, dramatization, unsupported declarations, and claims about the importance of the document itself. Describe relevant limits, unsupported cases, and differences with their subjects and conditions.

   Open a section with the concrete background, problem, or purpose leading to its claim, or with the definition or function when context is already established. In Japanese prose, openings such as 「Xではない」「Xだけでは足りない」「Yして初めて意味がある」 draw attention to negation or judgment. When discussing an error or limitation, identify the actual subject, condition, and problem.

   Read the lead and the first sentence of each section in isolation. Rewrite attention-seeking openings using a clear subject, action, and condition. Then check that the rest of each section develops its opening points and places procedures within that explanation. Reworking an opening sentence alone leaves structural problems in the body unresolved.

7. **Replace abstract praise with effects and evidence.** Explain what the mechanism describes, checks, or executes, where constraints apply, and what improves under which conditions. For measured effects, report both the conditions and results.

8. **Keep sentences and paragraphs focused.** Give each paragraph one claim and its support. Remove unnecessary previews, restatements, and lengthy explanations of concepts the intended readers already know.

<a id="技術の可能性と適用条件の伝え方"></a>
## Possibilities and conditions of use

Connect what the technology enables and what it aims to achieve with its mechanism and implementation conditions. Describe future possibilities through concrete uses, structure, behavior, and a path to realization.

Attribute methods, design choices, and views to their proponents. Identify what the project adopts, how it interprets the concept, and why. Distinguish general definitions from project-specific choices. Introduce the responsible party where relevant and reuse that context. Avoid claims of unique optimality and disclaimers denying such claims.

Generally omit disclaimers aimed solely at anticipating criticism or misunderstanding. Combine the facts and conditions readers need with the explanation they qualify. Identify proposals, hypothetical examples, and illustrative numbers at the point of use. Give comparison conditions, measurement scope, and responsibilities where they explain the mechanism or result.

Describe implemented capabilities, designs, and future plans according to their actual status. Ground possibilities and paths forward in the available evidence. Avoid introducing extraneous assumptions just to dismiss them or repeatedly qualifying a claim with general warnings. At final review of the Core and text, trace each conclusion through purpose, mechanism, and conditions. Revise endings where a precautionary disclaimer has displaced the conclusion.

<a id="主張と根拠"></a>
## Claims and evidence

9. **Distinguish capability, intermediate outcome, and final outcome.** Explain the conditions and causal steps connecting them. To move from recording data to solving a problem, account for the analysis, decision, and action in between.

10. **Identify the subjects, criteria, and conditions of comparison.** Explain the properties that affect the conclusion. For performance or cost comparisons, align inputs, load, environment, and accounting scope, or state the differences.

11. **Match the strength of each claim to the evidence.** Distinguish verified facts, inferences, proposals, implemented capabilities, and future plans. Mark hypothetical examples and values where introduced. Put qualifications with the claim they limit.

12. **State decision premises and criteria and trace how the method works.** Distinguish problem, cause, remedy, result, and evaluation criterion. Relate the method to the requirement or quality attribute it addresses. Explain the mechanism behind a term or analogy.

13. **Connect each example to its point.** Identify what the example demonstrates and give enough detail to relate it to the general explanation. Regroup concepts and examples if switching between them obscures the purpose.

<a id="用語と図表箇条書き"></a>
## Terminology, figures, tables, and lists

14. **Use the target project’s canonical glossary forms.** Use the canonical Japanese name in Japanese and the corresponding English name in English. Convey the same claim in both languages. Explain how unfamiliar concepts fit and link to fuller definitions. Follow project conventions for proper names, official abbreviations, and code identifiers.

15. **Explain the purpose of each figure, table, and list and how to read it.** Figures show relationships or flows, tables show comparisons or mappings, and lists group items with an identifiable purpose. Number and title figures and tables. Introduce each list with a sentence explaining its purpose. Use intelligible labels and explain what connections in a diagram mean.

   Decide what the table helps readers understand, compare, or judge. Link it to a specific point, then select subjects and criteria accordingly. Identify what a mapping or composition table relates.

   Choose specific row and column headings. Describe all subjects using common criteria, granularity, and conditions so the relevant similarities, differences, and correspondences are visible. Omit unrelated columns and cells that use inconsistent criteria.

   State the table’s purpose in the preceding sentence and its title. Check what the reader can learn or decide from it. Reconsider a table whose purpose cannot be explained.

16. **Do not use ASCII-art diagrams.** Create and include a PNG image for a relationship or flow that calls for a diagram. Use prose where text suffices. ASCII characters in code examples and identifiers are outside this restriction.
