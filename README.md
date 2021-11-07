# 👨‍💻 Ulas Kelas
[![Generic badge](https://img.shields.io/badge/Flutter-v2.2.3-blue)](https://flutter.dev/docs)
[![Generic badge](https://img.shields.io/badge/Dart-v2.13.4-blue)](https://dart.dev/guides)
[![Generic badge](https://img.shields.io/badge/development-v0.0.1-brightgreen)](https://play.google.com/store/)
[![Generic badge](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

Ulas Kelas app

## ⚡️ Getting Started

### 🚚 How to run, drive, and build Apk

Example how to run release development app
```
flutter clean
flutter pub get
flutter run -t lib/main_development.dart --release --no-shrink --flavor development
```

Example how to build release development app
```
flutter clean
flutter pub get
flutter build apk -t lib/main_development.dart --release --no-shrink --flavor development --split-per-abi
```

Example how to drive automation test on development environment
note that automation test doesn't support release mode
```
flutter drive -t test_driver/app.dart --flavor development
```