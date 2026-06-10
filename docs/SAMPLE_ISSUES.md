# Sample Issues and Tasks

Copy these into GitHub Issues when setting up the repository. Each item represents **real, shippable work** — not busywork for profile metrics.

---

## Issue 1: Add dark mode theme

**Labels:** `enhancement`, `good first issue`

**Description:**

### Problem
The app only supports a light Material 3 theme. Users working in low-light environments need a dark theme.

### Acceptance criteria
- [ ] Add `AppTheme.dark()` in `lib/core/theme/app_theme.dart`
- [ ] Respect system theme via `ThemeMode.system`
- [ ] Add a settings toggle (or follow system only — document choice in PR)
- [ ] Widget tests updated if theme-dependent

### Technical notes
- Keep theme definitions in `core/theme/`
- No business logic in widgets

**Suggested branch:** `feature/dark-mode`

---

## Issue 2: Add due dates to tasks

**Labels:** `enhancement`

**Description:**

### Problem
Tasks have no deadline, making prioritization harder.

### Acceptance criteria
- [ ] Optional `dueDate` on `Task` entity
- [ ] Date picker on task form
- [ ] Sort/filter by due date on home screen
- [ ] Migration-safe JSON serialization (nullable field)
- [ ] Unit tests for model round-trip

**Suggested branch:** `feature/task-due-dates`

---

## Issue 3: Export tasks to JSON file

**Labels:** `enhancement`, `help wanted`

**Description:**

### Problem
Users cannot back up or share their task list.

### Acceptance criteria
- [ ] `ExportTasks` use case returns JSON string
- [ ] Share sheet or save-to-file on supported platforms
- [ ] Error handling for empty task list
- [ ] Document export format in README

**Suggested branch:** `feature/export-json`

---

## Issue 4: Fix — snackbar not shown on validation error

**Labels:** `bug`

**Description:**

### Steps to reproduce
1. Open **New Task**
2. Leave title empty
3. Tap **Create Task**

### Expected
Inline field validation appears.

### Actual
Verify behavior matches design; if snackbar duplicates validation, remove redundant feedback.

**Suggested branch:** `fix/validation-feedback`

---

## Issue 5: Improve CI — add dependency review

**Labels:** `chore`, `ci`

**Description:**

Enable GitHub Dependabot and add a `dependency-review` job on pull requests targeting `main`.

**Suggested branch:** `chore/dependabot`

---

## GitHub CLI — create issues in bulk

After pushing the repo, replace `YOUR_USERNAME/taskflow-hub` and run:

```bash
gh issue create --title "Add dark mode theme" \
  --body-file docs/issue-templates/dark-mode.md \
  --label "enhancement" --label "good first issue"

gh issue create --title "Add due dates to tasks" \
  --body "See docs/SAMPLE_ISSUES.md#issue-2-add-due-dates-to-tasks" \
  --label "enhancement"

gh issue create --title "Export tasks to JSON file" \
  --body "See docs/SAMPLE_ISSUES.md#issue-3-export-tasks-to-json-file" \
  --label "enhancement" --label "help wanted"
```

Or create them manually via **Issues → New issue** and select the templates.
