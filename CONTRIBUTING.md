# Contributing to TaskFlow Hub

Thank you for your interest in contributing. This project follows a standard open-source workflow designed to keep `main` stable and make reviews predictable.

## How to contribute

1. **Fork** the repository on GitHub.
2. **Clone** your fork locally.
3. Create a **feature branch** from `develop`.
4. Make focused commits with clear messages.
5. Run local checks before opening a PR.
6. Open a **pull request** into `develop` (not `main` directly).
7. Link the related issue using `Closes #123` in the PR description.

## Development setup

```bash
git clone https://github.com/YOUR_USERNAME/taskflow-hub.git
cd taskflow-hub
git checkout develop
flutter pub get
```

## Branch naming

| Prefix | Example | Use for |
|--------|---------|---------|
| `feature/` | `feature/dark-mode` | New functionality |
| `fix/` | `fix/task-delete-crash` | Bug fixes |
| `chore/` | `chore/update-ci` | Maintenance |
| `docs/` | `docs/readme-setup` | Documentation only |

## Commit message guidelines

Use imperative mood and keep the subject under 72 characters:

```
feat: add task priority filter chips
fix: prevent empty title submission
test: cover task repository persistence
docs: document branching workflow
chore: bump shared_preferences
```

Optional body: explain **why**, not only what changed.

## Pull request checklist

- [ ] Branch is up to date with `develop`
- [ ] `dart format .` applied
- [ ] `flutter analyze --fatal-infos` passes
- [ ] `flutter test` passes
- [ ] PR template completed
- [ ] Screenshots attached for UI changes
- [ ] Issue linked with `Closes #...`

## Code style

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Keep domain layer free of Flutter/framework dependencies
- Add tests for business logic and serialization
- Prefer small, reviewable PRs over large dumps

## Reporting bugs

Use the [Bug Report issue template](.github/ISSUE_TEMPLATE/bug_report.yml). Include reproduction steps and environment details.

## Feature requests

Use the [Feature Request template](.github/ISSUE_TEMPLATE/feature_request.yml). Explain the user problem before proposing a solution.

## Co-authored commits

When pair programming or reviewing substantial work, credit collaborators:

```bash
git commit -m "feat: add export to JSON

Co-authored-by: Jane Doe <jane@example.com>"
```

Both authors must use the email associated with their GitHub account (or a verified noreply address).

## Code of conduct

All participants are expected to follow [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).

## Questions

Open a [Discussion](https://github.com/YOUR_USERNAME/taskflow-hub/discussions) or issue labeled `question` if you are unsure where to start.
