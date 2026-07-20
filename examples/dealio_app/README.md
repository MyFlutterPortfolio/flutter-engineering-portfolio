# Dealio

AI-powered shopping assistant built with Flutter. This project demonstrates a production-oriented feature-first architecture, secure authentication, remote search, progressive results, alerts, barcode/image analysis, localization, and testable state management.

## Architecture

The app uses Flutter, Riverpod, GoRouter, Dio, secure storage, Freezed models, and explicit data/domain/presentation boundaries.

See [docs/architecture.md](docs/architecture.md) for the dependency diagram and architectural rules.

## Configuration

The backend URL is environment-based:

```bash
flutter run --dart-define=API_BASE_URL=https://api.example.com
```

For the Android emulator:

```bash
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000
```

Release builds reject non-HTTPS configured URLs.

## Verification

```bash
dart analyze
flutter test
```

Demo fixtures are isolated from production repositories. Authentication and search use the configured backend only.
