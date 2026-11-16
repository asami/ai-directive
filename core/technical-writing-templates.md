# Technical Document Structure Templates

Status: Normative through [Technical Writing Rules](technical-writing.md)

Rule map: [Core Rule Map](AGENT.md#core-rule-map)

<a id="適用範囲と役割"></a>
## Scope and purpose

Use these templates to organize explanations of technical concepts, mechanisms, and applications in articles, technical guides, design explanations, and their Content Core and Document outlines. Where a specification or reference has a required structure, apply the template to explanatory passages within that structure.

The [Technical Writing Rules](technical-writing.md) govern reasoning, style, evidence, figures, tables, and lists. This catalog governs the order in which the explanation unfolds.

<a id="テンプレートの選択"></a>
## Choosing a template

| Japanese name | English name | ID | How the explanation develops | When to choose it |
| --- | --- | --- | --- | --- |
| 背景導入型 | Background First | `background-first` | Establish the situation and need, then explain the subject, its parts, and its use. | Readers need to understand why the subject matters before examining it in detail. |
| 定義・課題対応型 | Definition First | `definition-first` | Define the subject and its purpose, identify the problems, then explain how the parts work together to address each one. | Readers need to understand what a technology does and how it addresses particular problems. |
| 概念・実現解説型 | Concept to Realization | `concept-to-realization` | Connect a concept to a system’s design decisions and trace those decisions through a concrete example at runtime. | Readers can use a familiar concept to understand how a particular system is designed and implemented. |
| 比較・選択型 | Comparison and Selection | `comparison-and-selection` | Compare alternatives against a shared purpose, conditions, and evidence, then explain which fits which circumstances. | Readers need to choose among ways of meeting the same need and understand the tradeoffs behind the choice. |

Accept the Japanese name, English name, or ID. Match English names case-insensitively. Use the template the user specifies. When continuing an existing document, preserve its chosen structure and explanatory approach. For a new explanatory document with no specified template, default to Background First, which follows the why–what–how sequence. If another template better suits the subject and audience, record the choice in the authoring notes.

Keep the choice and its rationale in the request, brief, journal, or another authoring record. When recording a choice in a Core or Document, use a mechanism supported by its format. Keep the DSL within its defined fields.

<a id="背景導入型"></a>
## Background First

ID: `background-first`

Establish the situation and the need before explaining the subject in depth and showing how to use it. The introduction gives readers enough vocabulary to understand the need. The later definition establishes boundaries and conditions.

| Order | Section role | What to include |
| --- | --- | --- |
| 1 | Lead | State in one sentence what situation readers face and what changes when they adopt the technology. Indicate the scope of the document. |
| 2 | Introduction (why) | Establish the context, give a short working definition, and explain the need, in that order. |
| 3 | Definition (what) | Define the subject, its scope and boundaries, and the conditions under which the definition applies. |
| 4 | Structure | Show the whole and the role of each part. Follow one representative use case to explain what the parts pass to one another and how those exchanges meet the need identified in the introduction. |
| 5 | How to use it | Identify the circumstances and prerequisites for choosing this approach. Explain how to use its parts under those conditions. |
| 6 | Worked example | Choose an example that meets those conditions. Follow a concrete input through processing to a result the user can verify. |
| 7 | Summary | Return to the conclusion and bring together the definition, need, mechanism, and use. |

The introduction answers three questions. What situation does the document address? What working definition does the reader need to understand that situation? What problem calls for the technology, and to what end? Use one section or several subsections according to the amount of material and the reasoning involved. Give the lead, working definition, and detailed definition distinct jobs so each passage advances the explanation.

<a id="定義課題対応型"></a>
<a id="定義・課題対応型"></a>
## Definition First

ID: `definition-first`

Define the subject and its purpose early, then connect each problem to the mechanism that addresses it. This structure grew out of an article about the observed model and can be applied to other subjects.

| Order | Section role | What to include |
| --- | --- | --- |
| 1 | Lead | State in one sentence what the technology does and how it helps with a problem the reader faces. Indicate the scope of the document. |
| 2 | What the subject is | Define what the subject covers and how it represents that subject matter. Use the defined subject as the starting point for explaining its basic structure and behavior. |
| 3 | Purpose | Explain why the subject is needed and how it complements existing approaches. If it serves several purposes, explain how they relate. |
| 4 | Main applications and their foundations (optional) | Give this material its own section when readers need to understand how activities relate to their supporting infrastructure before they can follow several of the problems below. |
| 5 | Problems and questions | Introduce the selected problems. For each, describe the conditions under which it arises and ask what the reader needs to establish to reach a judgment. |
| 6 | Structure | Show the whole and how the parts relate. Explain each part’s role, the information it handles, its connections, and the conditions it requires. |
| 7 | Response to each problem | Answer the questions in the order in which they were posed. Explain which parts act under which conditions, how they produce the result, and how the reader can check it. |
| 8 | How to use it | Describe the setting, scope, and prerequisites. Explain how to combine the parts in that setting. |
| 9 | Worked example | Use the same terminology and questions to trace concrete conditions, inputs, configuration, processing or records, and results. |
| 10 | Summary | Give the conclusion in one sentence, then bring together the definition, purpose, principal mechanisms, and uses. |

Choose the applications to suit the subject. For the observed model, these include A/B and multi-arm experiments, AI tuning, and the Corpus that supports them. If one use case suffices, include it under purpose or usage.

When covering several problems, introduce the purpose of the list, name the problems, and give each its own subsection. Present the list as the document’s selected scope. Give each response a corresponding subsection. For example, to answer “Did we reduce repeated I/O?”, compare call counts and processing results for the same input before and after the change. This shows whether fewer calls produced the same result.

If a comparison table helps, place it after the individual explanations. Introduce its purpose and use common dimensions such as problem, intended outcome, and mechanism. In both the Core and the published text, let the purpose determine which problems to cover, explain which parts address them under which conditions, and demonstrate the reasoning through use and example.

<a id="概念実現解説型"></a>
<a id="概念・実現解説型"></a>
## Concept to Realization

ID: `concept-to-realization`

Choose this template when a familiar concept helps explain a system’s design decisions and runtime behavior. By the end, readers should be able to take one example and explain which component acts, when it acts, and what rule or property it preserves.

| Order | Section role | What to include |
| --- | --- | --- |
| 1 | Lead | Identify the audience, the guiding concept, the system, and the central design conclusion. Introduce one operation or situation that readers will be able to explain by the end. |
| 2 | Background and purpose | Describe the requirements and constraints that call for a design decision. Identify the meanings or rules that must carry through from design to execution, and set the scope of the guide. |
| 3 | Concepts and overview | Define terms at first use. Relate the concepts, models, and runtime components, and locate the example’s input and result in this picture. Attribute the concepts and identify the choices specific to the system. |
| 4 | Principal design concerns | For each concern, connect the requirement and meaning of the concept to the design choice, its rationale, the responsible component, and the observable effect. State the conditions and boundaries of responsibility. |
| 5 | From design to execution | Follow one operation across the concerns. Where applicable, explain who reads a description or configuration, what is generated, what implementation must be supplied, and which runtime components take over in what order. Identify where each earlier design choice takes effect. |
| 6 | Worked example | Return to the opening situation. Use consistent terms to trace the initial state, input, applicable rules, processing path, and observable result. When a decision boundary matters, vary one condition and show how the outcome changes. |
| 7 | Summary | Answer the opening question by linking the key concepts and design choices to the behavior demonstrated in the example. State the assumptions and scope of that explanation. |

Within a concept section, consider why the concept matters, what it means, which design the system adopts, and how that design works. Use as many subheadings as the material warrants. For order consistency, for example, explain why an order without line items cannot be confirmed and which component checks the rule for the entire order. The execution chapter can then show when a valid proposed update is persisted and committed, and how it reaches the read side.

Give readers the definitions and sources they need at the point of use. Put cross-source terminology tables and comprehensive indexes in an appendix for later reference.

<a id="比較選択型"></a>
<a id="比較・選択型"></a>
## Comparison and Selection

ID: `comparison-and-selection`

Choose this template when the document’s central question is which approach fits a shared need under stated conditions. By the end, readers should be able to compare the alternatives on common criteria, trace the findings to their grounds, and explain the conditions for choosing each approach. The structure was developed from a comparison of four development methods applied to the same order-management system over several years.

| Order | Section role | What to include |
| --- | --- | --- |
| 1 | Lead | State the decision readers face and the main finding, including the conditions that qualify it. Identify the alternatives and scope. |
| 2 | Decision context and purpose | Describe the situation, desired outcome, constraints, and who must make the decision. Explain why the differences among the alternatives matter to that decision. |
| 3 | Common comparison basis | Define the alternatives, their scope, and the criteria derived from the purpose. Establish shared requirements, starting conditions, available resources, and observable acceptance conditions. Identify sources, applicable versions, and the evidence available for each criterion. |
| 4 | How each alternative works | Explain each approach using the same questions and criteria: what it represents, who does the work, how it produces the required outcome, and what it requires. Give the reasons for its strengths, limitations, and costs. Use comparable, feasible forms of each approach. |
| 5 | Worked comparison | Follow the same case through each approach. Keep the required outcome and relevant starting conditions common, trace the work and results, and identify what readers can inspect. When lifecycle or handoff matters, carry the same case through a shared sequence of changes. |
| 6 | Findings and tradeoffs | Bring the findings together by criterion. Explain which mechanisms account for the differences and what benefits, burdens, or limitations follow. Use a comparison table to summarize findings already supported by the explanations and case. |
| 7 | Selection conditions | Explain which approach fits which requirements, constraints, skills, and available components or infrastructure. Identify the tradeoffs that can change the choice and the remaining checks needed to decide. Where the evidence is insufficient, state what remains undecided. |
| 8 | Summary | Answer the opening decision with its conditions, principal grounds, and limits. State what readers need to verify in their own setting. |

Derive the evaluation criteria from the reader’s purpose before assessing the alternatives. Explain why each criterion matters and how it will be judged. Distinguish requirements every acceptable option must meet from preferences that involve tradeoffs. If priorities or weights affect the recommendation, explain their basis and how a change in them could change the choice. An unavailable or unexamined capability remains a limitation or unknown in the comparison.

Use the same terms and comparison questions for each alternative. Explain its mechanism before drawing conclusions from a summary table. When versions, deployment conditions, resources, or scope differ, state how that difference affects the judgment. Distinguish documented capabilities, design reasoning, illustrative cases, and measured results. A worked design example can explain an expected difference; it does not establish measured effort, performance, or superiority.

In the order-management example, all four methods face the same two-warehouse change. An order needs ten units; the first warehouse holds six, and the second cannot supply four. Once release is agreed, the common acceptance conditions are release of the six units, zero allocated units, and zero shipment instructions. Useful comparison questions are where the current rule is read, what must change, how far the impact extends, what can be reused, how the result is checked, and how the decision and its reasons reach the next maintainer or AI. Follow those questions through each method and through later changes. Select criteria for other subjects from their own decision context.

Use this template when comparison and conditional selection organize the whole document. Use Definition First when the main task is to explain one subject and its responses to problems, or Concept to Realization when the main task is to trace one system’s design into execution. A local comparison within either document can use the [Comparison section pattern](technical-writing-patterns.md#パターンの選択). The document template and section pattern have distinct IDs; apply Definition, Mechanism, Worked Example, or other section patterns where they support the comparison.

<a id="共通ルールとの組合せ"></a>
## Applying the shared rules

For every template, give the main point and conclusion or overview in the lead. Develop its supporting points in subsequent chapters and sections. In Background First, this lead precedes the account of context and need. Move from the main point to detail within each section and paragraph, and return to the opening point in the summary.

Apply the [Technical Writing Rules](technical-writing.md) throughout. The template orders the material. Build the claims, evidence, conditions, and logical connections from the subject itself.

Labels such as “introduction,” “working definition,” and “structure” describe authoring roles. Choose headings that identify the actual content. Use titles such as “What X is,” “Purpose of X,” or “Summary” where they fit. Readers should be able to skim the lead, headings, figures, tables, lists, and summary, then read the body to understand the reasons and mechanisms.

Examples of template requests include:

- “Use Comparison and Selection to compare development methods on the same requirements and explain when to choose each.”
- “Use `comparison-and-selection` to compare deployment options under the same availability and cost constraints.”
- “Use Concept to Realization to explain how the system maintains order consistency at runtime.”
- “Use Background First to explain the context and need.”
- “Write this using Background First.”
- “Use Definition First, with corresponding subsections for each problem and response.”
- “Use Definition First and start with the definition and purpose.”
- “Use `definition-first` and give the main applications and their foundations a separate section.”

When adding a template, specify its Japanese and English names, unique ID, intended explanation, outline, role of each part, and selection criteria. Before changing the meaning of an existing ID, check the impact on documents that use it.
