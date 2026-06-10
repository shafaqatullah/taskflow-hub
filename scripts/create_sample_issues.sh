#!/usr/bin/env bash
# Creates sample GitHub issues for TaskFlow Hub.
# Prerequisites: gh CLI authenticated, repo pushed to GitHub.

set -euo pipefail

REPO="shafaqatullah/taskflow-hub"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo "Creating labels..."
declare -a LABELS=(
  "bug:d73a4a:Something isn't working"
  "enhancement:a2eeef:New feature or request"
  "good first issue:7057ff:Good for newcomers"
  "help wanted:008672:Extra attention needed"
  "task:1d76db:Discrete unit of work"
  "triage:fbca04:Needs triage"
  "chore:cfd3d7:Maintenance"
  "dependencies:0366d6:Dependency updates"
)

for entry in "${LABELS[@]}"; do
  IFS=':' read -r name color desc <<< "$entry"
  gh label create "$name" --repo "$REPO" --color "$color" --description "$desc" 2>/dev/null || true
done

echo "Creating issues..."
gh issue create --repo "$REPO" --title "Add dark mode theme" \
  --body-file "$ROOT/docs/issue-templates/01-dark-mode.md" \
  --label "enhancement" --label "good first issue"

gh issue create --repo "$REPO" --title "Add due dates to tasks" \
  --body-file "$ROOT/docs/issue-templates/02-due-dates.md" \
  --label "enhancement"

gh issue create --repo "$REPO" --title "Export tasks to JSON file" \
  --body-file "$ROOT/docs/issue-templates/03-export-json.md" \
  --label "enhancement" --label "help wanted"

gh issue create --repo "$REPO" --title "Fix validation feedback on task form" \
  --body-file "$ROOT/docs/issue-templates/04-validation-feedback.md" \
  --label "bug"

gh issue create --repo "$REPO" --title "Improve CI with Dependabot and dependency review" \
  --body-file "$ROOT/docs/issue-templates/05-dependabot.md" \
  --label "chore" --label "task"

echo "Done. List issues: gh issue list --repo $REPO"
