# Architecture

TaskFlow Hub uses a simplified **clean architecture** suitable for small-to-medium Flutter apps.

## Layers

### Domain (`lib/domain/`)

Pure Dart business logic:

- **Entities** — `Task`, `TaskPriority`
- **Repository interfaces** — `TaskRepository`
- **Use cases** — one class per action (`GetTasks`, `AddTask`, …)

No `flutter`, `shared_preferences`, or JSON imports here.

### Data (`lib/data/`)

Framework and storage details:

- **Models** — `TaskModel` with JSON mapping
- **Data sources** — `TaskLocalDataSource` backed by `SharedPreferences`
- **Repository implementations** — `TaskRepositoryImpl`

### Presentation (`lib/presentation/`)

UI and state:

- **Provider** — `TaskProvider` orchestrates use cases
- **Pages / widgets** — Material 3 UI

### Core (`lib/core/`)

Cross-cutting utilities shared by multiple layers (theme, validators, failures).

## Data flow

```
UI event
  → TaskProvider
    → Use case
      → TaskRepository (interface)
        → TaskRepositoryImpl
          → TaskLocalDataSource
            → SharedPreferences
```

Reads flow back through the same chain, mapping `TaskModel` → `Task`.

## Dependency injection

`lib/injection.dart` wires concrete implementations at startup. This keeps `main.dart` thin and makes widget tests easy to bootstrap.

## Testing strategy

| Layer | Test type | Location |
|-------|-----------|----------|
| Validators, models | Unit | `test/unit/` |
| Repository | Unit with mocked prefs | `test/unit/` |
| Home screen | Widget | `test/widget/` |

## Extension points

Future features (due dates, export, dark mode) should add:

1. Entity fields + use case(s) in **domain**
2. Model + persistence in **data**
3. UI in **presentation**

Avoid skipping layers — it keeps the codebase maintainable as contributors join.
