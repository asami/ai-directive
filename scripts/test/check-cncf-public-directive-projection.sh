#!/usr/bin/env bash

set -euo pipefail

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

repo_root=$(pwd -P)
test -f "$repo_root/README.md" || fail "run from the directive repository root"
test -d "$repo_root/.git" || test -f "$repo_root/.git" || fail "run from the directive repository root"

guide="public/ai-development-guide.md"
required_files=(
  "$guide"
  "README.md"
  "core/AGENT.md"
  "core/RULE.md"
  "chatgpt-desktop/AGENT.md"
  "codex/AGENT.md"
  "samples/README.md"
)

for path in "${required_files[@]}"; do
  test -f "$path" || fail "missing regular input: $path"
  test ! -L "$path" || fail "input is not a regular file: $path"
done

tracked_files=(
  "README.md"
  "core/AGENT.md"
  "core/RULE.md"
  "chatgpt-desktop/AGENT.md"
  "codex/AGENT.md"
  "samples/README.md"
)
for path in "${tracked_files[@]}"; do
  git ls-files --error-unmatch -- "$path" >/dev/null 2>&1 || fail "input is not Git-tracked: $path"
done

directories=(core chatgpt-desktop codex samples)
directory_reals=()
for directory in "${directories[@]}"; do
  test -d "$directory" || fail "missing directory: $directory"
  test ! -L "$directory" || fail "directory is a symlink: $directory"
  directory_reals+=("$(cd "$directory" && pwd -P)")
done

for ((left_index = 0; left_index < ${#directory_reals[@]}; left_index++)); do
  for ((right_index = left_index + 1; right_index < ${#directory_reals[@]}; right_index++)); do
    test "${directory_reals[$left_index]}" != "${directory_reals[$right_index]}" || fail "directories are not structurally distinct"
  done
done

grep -Fq 'Projection identity: `DOC03-AI-DIRECTIVE-PROJECTION`' "$guide" || fail "stable projection identity missing"
grep -Fq '[public development guide](public/ai-development-guide.md)' README.md || fail "README public-guide link missing"
grep -Fq '`README.md` is the public guide surface' "$guide" || fail "README public guide surface missing"
grep -Fq 'Authoritative behavior comes from `core/` together with the selected runtime' "$guide" || fail "core/profile authority boundary missing"
grep -Fq 'This projection is descriptive only. It never grants authority, overrides' "$guide" || fail "projection non-authority boundary missing"
grep -Fq 'Material under `samples/` is illustrative and is not a rule or authority' "$guide" || fail "samples non-authority boundary missing"
grep -Fq 'Repository-local extensions remain outside shared `core/` and selected-profile' "$guide" || fail "repository-local extension boundary missing"

git_head=$(git rev-parse HEAD) || fail "unable to resolve current Git HEAD"
shasum_command=$(command -v shasum) || fail "unable to locate shasum"
test -n "$shasum_command" || fail "unable to locate shasum"
test -x "$shasum_command" || fail "shasum is not executable: $shasum_command"

aggregate_input=
for path in core/AGENT.md core/RULE.md chatgpt-desktop/AGENT.md codex/AGENT.md; do
  input_digest=$("$shasum_command" -a 256 "$path") || fail "unable to hash input: $path"
  aggregate_input+="${input_digest}"$'\n'
done

aggregate_digest=$(printf '%s' "$aggregate_input" | "$shasum_command" -a 256) || fail "unable to derive core/profile digest"
core_profile_digest=${aggregate_digest%%[[:space:]]*}
test -n "$core_profile_digest" || fail "unable to derive core/profile digest"

printf 'PASS: public directive projection\n'
printf 'Git HEAD: %s\n' "$git_head"
printf 'Core/profile input SHA-256: %s\n' "$core_profile_digest"
