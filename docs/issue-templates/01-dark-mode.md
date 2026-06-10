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
