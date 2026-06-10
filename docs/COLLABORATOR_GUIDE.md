# Collaborator & Co-Author Guide

How to add a **real** collaborator and credit them on commits in TaskFlow Hub.

## Add a collaborator on GitHub

### Option A — Web UI

1. Open https://github.com/shafaqatullah/taskflow-hub/settings/access
2. Click **Add people**
3. Enter their GitHub username (e.g. `janedoe`)
4. Choose permission level:
   - **Write** — can push branches and open PRs
   - **Maintain** — can manage issues and settings
   - **Admin** — full access
5. They accept the invitation from email or https://github.com/shafaqatullah/taskflow-hub/invitations

### Option B — GitHub CLI

```bash
gh api repos/shafaqatullah/taskflow-hub/collaborators/COLLABORATOR_USERNAME \
  -X PUT \
  -f permission=push
```

Replace `COLLABORATOR_USERNAME` with their GitHub handle.

## Collaborator local setup

```bash
git clone https://github.com/shafaqatullah/taskflow-hub.git
cd taskflow-hub
git checkout develop
git pull origin develop
git checkout -b feature/their-feature
```

They commit, push, and open a PR into `develop` like any contributor.

## Co-authored commits

Use when two or more people wrote the code (pair programming, substantial review edits).

### Find the co-author's GitHub email

They should check **GitHub → Settings → Emails** and use a verified address or noreply:

```
12345678+username@users.noreply.github.com
```

### Create a co-authored commit

```bash
git add lib/presentation/pages/home_page.dart
git commit -m "feat(ui): add theme cycle toggle in app bar

Co-authored-by: Collaborator Name <12345678+collaborator@users.noreply.github.com>"
```

### Rules

- Both authors should have contributed to the commit content
- Email must match a verified GitHub account
- GitHub displays all authors on the commit page after push

### Example from this repository

Commit on `feature/dark-mode` includes a `Co-authored-by` trailer demonstrating the format. Replace with your collaborator's real identity when pair programming.

## Removing a collaborator

```bash
gh api repos/shafaqatullah/taskflow-hub/collaborators/COLLABORATOR_USERNAME -X DELETE
```

Or via **Settings → Collaborators → Remove**.

## Ethics

Only add people you genuinely work with. Co-authored commits should reflect real shared authorship — not artificial inflation of contribution graphs.
