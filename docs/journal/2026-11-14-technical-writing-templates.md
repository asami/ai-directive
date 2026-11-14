# 名前で選べる技術文書の構成テンプレート

日付: 2026-11-14

ユーザーから、共通として使ってきた説明構成と、観測モデルから抽出した構成へそれぞれ名前を付け、技術文書ごとに選べるようにする指示を受けた。

既存のtechnical-writing.mdは、Why・What・How、論理的な木構造、斜め読み等の共通原則を定めている。固定された二種類のテンプレート定義はなかったため、会話で使ってきた背景・短い定義・必要性から進む構成を「背景導入型」、観測モデルから抽出した定義・目的・課題・構成・課題ごとの対応を展開する構成を「定義・課題対応型」として整理した。

共通正本のcore/technical-writing-templates.mdに、名前・ID・選択条件・章立て・各部分の役割を定義した。IDはbackground-firstとdefinition-first。ユーザーの指定を優先し、継続文書の採用済み構成は保持する。指定のない新規の説明文書では背景導入型を初期選択とする。

technical-writing.mdからカタログを参照し、core/AGENT.mdのCore Rule MapとREADMEにも読込入口を追加した。共通の説明原則、図表・箇条書きのルール、執筆用情報と読者向け情報の区別は、どちらの型にも適用する。テンプレート名や役割名を本文の見出しへ機械的に出さず、Core等へ未定義の選択フィールドを足さないことも明記した。

独立したai-directiveの作業ツリーへ反映した。既存のtechnical-writing.mdの未コミット修正は保持し、追加箇所だけを編集した。既存記事の改稿、生成、コミット、push、利用側のsubmoduleポインター更新は、この作業では行っていない。

変更前後と軽量な確認記録は、作業を開始したsimplemodeling-orgのignoredなtarget/evidence/technical-writing-templates-20261114へ分離。/Users/asami/backup/journal/2026/11/simplemodeling-org/technical-writing/technical-writing-templates-20261114/へ複写して保持する。

## 指定用の英語名の追加

ユーザーの指示により、背景導入型の英語名をBackground First、定義・課題対応型の英語名をDefinition Firstとした。日本語名・英語名・既存IDのどれでも同じテンプレートを指定でき、英語名の大文字・小文字は区別しない。カタログ、technical-writing.md、READMEと指定例を更新した。既存IDとテンプレートの内容・初期選択は保持した。コミット・利用側submoduleの更新は行っていない。
