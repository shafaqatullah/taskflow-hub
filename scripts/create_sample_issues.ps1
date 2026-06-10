# Creates sample GitHub issues for TaskFlow Hub.
# Prerequisites: gh CLI authenticated, repo pushed to GitHub.

$ErrorActionPreference = "Stop"
$Repo = "shafaqatullah/taskflow-hub"
$Root = Split-Path -Parent $PSScriptRoot

Write-Host "Creating labels..."
$labels = @(
    @{ name = "bug"; color = "d73a4a"; description = "Something isn't working" },
    @{ name = "enhancement"; color = "a2eeef"; description = "New feature or request" },
    @{ name = "good first issue"; color = "7057ff"; description = "Good for newcomers" },
    @{ name = "help wanted"; color = "008672"; description = "Extra attention needed" },
    @{ name = "task"; color = "1d76db"; description = "Discrete unit of work" },
    @{ name = "triage"; color = "fbca04"; description = "Needs triage" },
    @{ name = "chore"; color = "cfd3d7"; description = "Maintenance" },
    @{ name = "dependencies"; color = "0366d6"; description = "Dependency updates" }
)

foreach ($label in $labels) {
    gh label create $label.name --repo $Repo --color $label.color --description $label.description 2>$null
}

Write-Host "Creating issues..."
gh issue create --repo $Repo --title "Add dark mode theme" `
    --body-file "$Root\docs\issue-templates\01-dark-mode.md" `
    --label "enhancement" --label "good first issue"

gh issue create --repo $Repo --title "Add due dates to tasks" `
    --body-file "$Root\docs\issue-templates\02-due-dates.md" `
    --label "enhancement"

gh issue create --repo $Repo --title "Export tasks to JSON file" `
    --body-file "$Root\docs\issue-templates\03-export-json.md" `
    --label "enhancement" --label "help wanted"

gh issue create --repo $Repo --title "Fix validation feedback on task form" `
    --body-file "$Root\docs\issue-templates\04-validation-feedback.md" `
    --label "bug"

gh issue create --repo $Repo --title "Improve CI with Dependabot and dependency review" `
    --body-file "$Root\docs\issue-templates\05-dependabot.md" `
    --label "chore" --label "task"

Write-Host "Done. List issues: gh issue list --repo $Repo"
