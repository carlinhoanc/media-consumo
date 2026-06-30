AGENTS.md — Local guidance for AI coding agents
==============================================

Checklist for incoming agents
 - Read this file fully before modifying files in the repo.
 - Run the build/start steps in "Quick start" to reproduce the environment locally.
 - When you change code, run the small test suite: `flutter test`.

Purpose
-------
This file documents concrete, discoverable patterns and workflows that make an AI coding agent productive in this Flutter + SQLite project. It is intentionally pragmatic — only project's actual conventions, files and commands are described.

High-level repo layout (important paths)
---------------------------------------
- `lib/main.dart` — app entrypoint. Use this to run and debug UI flows.
- `lib/data/` — database helpers and initialization (e.g., `db_ini.dart`, `media_helper.dart`, `veiculo_helper.dart`, `manutencao_helper.dart`). Changes to data model usually require migrations here.
- `lib/models/` — data model classes (e.g., `media.dart`, `manutencao.dart`, `posto.dart`, `veiculo.dart`). Keep serialization logic here.
 - `lib/models/` — data model classes (e.g., `media.dart`, `manutencao.dart`, `posto.dart`, `veiculo.dart`). Keep serialization logic here. (You may see local backups like `lib/models/product.dart.bkp` — treat these as author backups, not active source files.)
- `lib/screens/` — feature screens grouped by folders (e.g., `media/`, `manutencao/`, `veiculo/`, `posto/`). Use these when adding UI features.
- `lib/components/` — reusable widgets and input components (e.g., `imput/easy_mask.dart`, `imput/email.dart`, `campos/tipos_veiculos.dart`). Follow existing widget patterns.
- `android/` and `ios/` — platform-specific build files. Signing keys are present: `mediaconsumo.jks` in project root and `app/mediaconsumo.jks`.
- `test/widget_test.dart` — the small widget test harness.

- `lib/data/start.dart` — contains the SQL CREATE TABLE statements and a `Start` helper that initializes/creates the database. Review this file when changing schema or adding tables.

Quick start (local dev)
-----------------------
1. Install Flutter SDK matching project's Flutter version (use `flutter --version` to confirm).
2. Fetch packages: `flutter pub get`.
3. Run on an attached device/emulator: `flutter run` or `flutter run -d <device-id>`.
4. Run tests: `flutter test`.
5. Build release APK: `flutter build apk --release` (Android) or `flutter build ios` (iOS — macOS required).

Build / workflow notes
----------------------
- The project uses Gradle wrapper under `android/gradle/wrapper/` — prefer `./gradlew` when running Gradle tasks.
- Keystore files exist in the repo (`mediaconsumo.jks` and `app/mediaconsumo.jks`) and `key.properties` is present — avoid modifying or publishing secrets.
 - The project declares Firebase packages in `pubspec.yaml` (`firebase_core`, `firebase_auth`, `firebase_database`). Platform Firebase config files (e.g., `android/app/google-services.json` or `ios/Runner/GoogleService-Info.plist`) are not present in the repo — check for them or add platform configuration before enabling Firebase features.

Database and migrations
-----------------------
- SQLite helpers live in `lib/data/`. The DB initialization is coordinated by `db_ini.dart` — review this file when schema changes are required.
- Model classes in `lib/models/` are used directly with helpers; there is no ORM — follow existing patterns for CRUD operations (e.g., `media_helper.dart` and `veiculo_helper.dart`).

- SQLite helpers live in `lib/data/`. The DB initialization is coordinated by `db_ini.dart` — review this file when schema changes are required. Note: this project also includes `lib/data/start.dart` which contains the explicit CREATE TABLE SQL used at database creation; inspect and update both `db_ini.dart` and `start.dart` when adding or migrating tables.
- Model classes in `lib/models/` are used directly with helpers; there is no ORM — follow existing patterns for CRUD operations (e.g., `media_helper.dart` and `veiculo_helper.dart`).

Coding conventions and patterns (project-specific)
-----------------------------------------------
- Small helper classes for each entity: `*_helper.dart` in `lib/data/` and `*_model.dart` (or `.dart`) in `lib/models/`.
- UI screens are organized under `lib/screens/<feature>/` — follow existing directory naming and navigation patterns when adding screens.
- Reusable input widgets are in `lib/components/imput/` — prefer using/augmenting these instead of creating ad-hoc input widgets.

Testing and validation
----------------------
- Run `flutter test` to run the unit/widget tests. There is one example test in `test/widget_test.dart` — add focused tests near the code you change.

Common tasks and where to start
-------------------------------
- To add a new model: add model under `lib/models/`, add helper CRUD functions under `lib/data/`, and update `db_ini.dart` to include table creation/migrations.
- To add a new screen: create `lib/screens/<feature>/` and register navigation from existing menu or `lib/main.dart`.
- To update Android signing: check `android/app/build.gradle`, `key.properties`, and keystore files — do not commit new private keys to the repo.

Debugging tips
--------------
- Use `flutter run` with `--verbose` to see detailed logs.
- Inspect SQLite DB during runtime by pulling the app data from emulator or using packages like `sqflite_common_ffi` for local debugging.
- For platform-specific failures, check `android/build.gradle` and `ios/Runner/` files.

Important files to inspect when making changes
---------------------------------------------
- `lib/main.dart` — navigation/startup logic
- `lib/data/db_ini.dart` — DB initialization and migrations
- `lib/data/*_helper.dart` — CRUD helpers for each model
- `lib/models/*` — canonical shapes of persisted objects
- `android/app/build.gradle`, `key.properties`, `mediaconsumo.jks` — Android signing and build
- `pubspec.yaml` — dependencies (run `flutter pub get` after changes)
 - `lib/data/start.dart` — table creation SQL and DB create logic (review when changing schema)
 - Platform Firebase config (if using Firebase): `android/app/google-services.json` and `ios/Runner/GoogleService-Info.plist` — these are not checked in; add them when enabling Firebase.

Do not change (sensitive or brittle)
----------------------------------
- Keystore files and passwords stored in repo are sensitive — do not change unless explicitly instructed.
- Generated build outputs under `/build/` — do not commit these.

If you add content to this document
----------------------------------
- Place additions under the most relevant existing section.
- Keep entries short and reference concrete file paths and examples.

Contact / provenance
--------------------
This file was generated to bootstrap AI agents in this repository. If anything here is incorrect, update the relevant section and include a one-line rationale.


