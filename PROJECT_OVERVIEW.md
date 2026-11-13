# Expense-management Flutter prototype

A Flutter prototype with login and employee/manager expense screens. It uses bundled JSON and fake services for demonstration rather than a production backend.

## Repository guide

- `lib/main.dart` — application entry point.
- `lib/login/` — login screen using bundled user data.
- `lib/employee_home/` and `lib/manager_home/` — role-specific screens.
- `lib/models/` and `lib/services/` — data models and prototype services.
- `assets/data/` and `assets/images/` — bundled data and visual assets.
- `pubspec.yaml` — Flutter dependencies and asset declarations.
- Platform directories (`android/`, `ios/`, `linux/`, `macos/`, `web/`, `windows/`) contain Flutter platform projects; `test/` contains tests.
- `README.md` retains the original Flutter starter documentation.

## Prototype limitations

Login checks credentials against bundled user data and is not production authentication. Manager expense-status updates in the reviewed screen are in-memory; persistence and production security are not established by this prototype. Existing application files and paths are unchanged.
