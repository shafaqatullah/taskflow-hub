# TaskFlow Hub

A production-style Flutter task manager that demonstrates **clean architecture**, automated CI, and professional open-source GitHub workflows.

[![CI](https://github.com/YOUR_USERNAME/taskflow-hub/actions/workflows/ci.yml/badge.svg)](https://github.com/YOUR_USERNAME/taskflow-hub/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Features

- Create, edit, delete, and complete tasks
- Priority levels (low, medium, high)
- Filter by all / active / completed
- Local persistence with `shared_preferences`
- Clean architecture with testable domain layer
- GitHub Actions for analyze, test, and build verification

## Architecture

```
lib/
├── core/           # Theme, constants, validators, failures
├── domain/         # Entities, repository contracts, use cases
├── data/           # Models, data sources, repository implementations
├── presentation/   # UI, widgets, state (Provider)
├── injection.dart  # Dependency wiring
├── app.dart
└── main.dart
```

Dependency rule: **presentation → domain ← data**. The domain layer has no Flutter imports.

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for layer responsibilities and data flow.

## Getting started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel)
- Android Studio / VS Code with Flutter extensions (recommended)

### Install and run

```bash
git clone https://github.com/YOUR_USERNAME/taskflow-hub.git
cd taskflow-hub
flutter pub get
flutter run
```

### Quality checks (same as CI)

```bash
dart format .
flutter analyze --fatal-infos
flutter test
flutter build apk --release
```

## Branching model

| Branch | Purpose |
|--------|---------|
| `main` | Production-ready releases |
| `develop` | Integration branch for upcoming release |
| `feature/*` | Short-lived feature work |
| `fix/*` | Bug fixes |
| `chore/*` | Tooling, CI, docs |

Workflow: **feature → develop → main** via pull requests with CI passing.

## Contributing

We welcome issues and pull requests. Please read:

- [CONTRIBUTING.md](CONTRIBUTING.md)
- [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)
- [docs/WORKFLOW_GUIDE.md](docs/WORKFLOW_GUIDE.md) — full Git/GitHub command reference

## Sample roadmap

Tracked as GitHub issues (see [docs/SAMPLE_ISSUES.md](docs/SAMPLE_ISSUES.md)):

1. Dark mode theme support
2. Task due dates and reminders
3. Export tasks to JSON
4. Search and sort improvements

## License

This project is licensed under the [MIT License](LICENSE).

## Ethics note

This repository is designed to teach **legitimate** open-source practices. Meaningful contributions, code review, and CI discipline matter more than gaming profile badges. Build software people can use.
