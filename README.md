# 👨‍💻 Ulas Kelas
[![Generic badge](https://img.shields.io/badge/Flutter-v3.0.5-blue)](https://flutter.dev/docs)
[![Generic badge](https://img.shields.io/badge/Dart-v2.13.4-blue)](https://dart.dev/guides)
[![test](https://github.com/RistekCSUI/ulaskelas-frontend/actions/workflows/config.yml/badge.svg)](https://github.com/RistekCSUI/ulaskelas-frontend/actions/workflows/config.yml)
[![Deploy Web](https://github.com/RistekCSUI/ulaskelas-frontend/actions/workflows/firebase-hosting-merge.yml/badge.svg)](https://github.com/RistekCSUI/ulaskelas-frontend/actions/workflows/firebase-hosting-merge.yml)
[![codecov](https://codecov.io/gh/RistekCSUI/ulaskelas-frontend/branch/main/graph/badge.svg?token=SHFALBJG9U)](https://codecov.io/gh/RistekCSUI/ulaskelas-frontend)
[![Generic badge](https://img.shields.io/badge/development-v0.0.1-brightgreen)](https://play.google.com/store/)
[![Generic badge](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)
[![Generic badge](https://img.shields.io/badge/component-ristek_material_component-9932CC.svg)](https://pub.dev/packages/ristek_material_component)

Ulas Kelas app

## ⚡️ Getting Started

### 🚚 How to run, drive, and build Apk

Example how to run release development app
```
flutter clean
flutter pub get
flutter run -t lib/main_development.dart --release --flavor development
```

Example how to build release development app
```
flutter clean
flutter pub get
flutter build apk -t lib/main_development.dart --release --no-shrink --flavor development --split-per-abi
```

Example how to build bundle release production app
```
flutter clean
flutter pub get
flutter build appbundle -t lib/main_production.dart --release --no-shrink --flavor production
```

Example how to run flutter web app
```
flutter run -t lib/main_development.dart -d chrome
```

Example how to drive automation test on development environment
note that automation test doesn't support release mode
```
flutter drive -t test_driver/app.dart --flavor development
```

### ⚙️ Supported Flavor

1. development
2. production

### 🎯 Architecture & Pattern

Reso coder's fllutter clean architecture
How to communicate with [Data & Back end](lib/documentation/data_and_backend.md)

![alt text](https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/Clean-Architecture-Flutter-Diagram.png?ssl=1)

### 🧬️ State Management

Using state rebuilder for zero boilerplate state management

visit https://pub.dev/packages/states_rebuilder

### API Documentation

[Postman](https://www.getpostman.com/collections/682bf27acd4b0fc9010c)

How to import collection [here](https://developer.ft.com/portal/docs-start-install-postman-and-import-request-collection)

More Postman tutorial [here](https://www.postman.com/postman/workspace/postman-answers/request/9215231-f3a24076-e530-4858-b872-b028446f6fc6)

### Versioning

Major-Minor-Patch

Given a version number MAJOR.MINOR.PATCH, increment the:

1. MAJOR version when you make incompatible API changes,
2. MINOR version when you add functionality in a backwards compatible manner, and
3. PATCH version when you make backwards compatible bug fixes.
   Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

and also supported by [cider](https://pub.dev/packages/cider).

to patch: `cider bump patch --bump-build` or `make patch`
to minor: `cider bump minor --bump-build` or `make minor`
to major: `cider bump major --bump-build` or `make major`

### :capital_abcd: Naming Convention

snake_case for file and folder.

### :capital_abcd: Git flow

Commit rules:
(feat|fix|docs|style|refactor|perf|test|build|ci):\/*

feat: A new feature
fix: A bug fix
docs: Documentation only changes
style: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
refactor: A code change that neither fixes a bug nor adds a feature
perf: A code change that improves performance
test: Adding missing tests
build: Changes to the build/compilation/packaging process or auxiliary tools such as documentation generation
ci: Changes in the continuous integration/delivery setup

examples:
feat: Form Login
ci: refactor analysis job

before push
1. flutter analyze
2. flutter test

branch rules:
(feature|hotfix|coldfix|service|integration|ui)\/\/*

### How to contribute

To help work on this project, please refer to [CONTRIBUTING.md](CONTRIBUTING.md)