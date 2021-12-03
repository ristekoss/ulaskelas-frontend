# 👨‍💻 Ulas Kelas Back End & Data Communication

Ulas Kelas Communication with application programming interface

## ⚡️ Getting Started

### 🚚 Create Data Source & Repository

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

Example how to drive automation test on development environment
note that automation test doesn't support release mode
```
flutter drive -t test_driver/app.dart --flavor development
```