# Clean Architecture Layer Brick

A Mason brick for generating a complete Flutter project with Clean Architecture (layer-based).

## Features

- 🏛️ Layer-based Clean Architecture structure
- 🔥 Firebase Crashlytics and Analytics
- 🌍 Multiple environment support (dev, prod, stage)
- 🎯 BLoC for state management
- 💉 GetIt + Injectable for dependency injection
- 🌐 Dio + Retrofit for networking
- 🧊 Freezed for immutable models
- 🗺️ AutoRoute for navigation
- ✅ Very Good Analysis for linting
- 📊 BLoC Observer for debugging

## Installation

### Global Installation

```bash
mason add -g clean_architecture_layer --git-url https://github.com/codesnapped/clean_architecture_brick.git
```

### Project Installation

```bash
mason add clean_architecture_layer --git-url https://github.com/codesnapped/clean_architecture_brick.git
```

## Usage

```bash
mason make clean_architecture_layer
```

You'll be prompted for:
- Project name
- Development API URL
- Production API URL
- Whether to include staging environment
- Staging API URL (if included)

## After Generation

### 1. Get Dependencies

```bash
flutter pub get
```

### 2. Configure Firebase

Install FlutterFire CLI:
```bash
dart pub global activate flutterfire_cli
```

Configure for each environment - see full documentation in the guide.

### 3. Generate Code

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Run the App

**Development:**
```bash
flutter run -t lib/main_dev.dart
```

**Production:**
```bash
flutter run -t lib/main_prod.dart
```

## License

MIT License - see LICENSE file for details
