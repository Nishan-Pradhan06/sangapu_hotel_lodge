# Sangapu Hotel & Lodge

Sangapu is a Flutter mobile application for managing day-to-day hotel and lodge finances. It provides a single place to record income and expenses, review statements, monitor earnings, and export financial reports.

## Features

- Secure login with locally stored access and refresh tokens
- Dashboard with daily and monthly earnings, daily expenses, net balance, banners, and room/beverage summaries
- Income entry creation and editing
- Expense creation and editing
- Filterable statements and transaction history
- Statement export to PDF and Excel
- Nepali date support
- Cached API responses and retry handling for network requests

## Technology

- [Flutter](https://flutter.dev/) and Dart
- `flutter_bloc` for presentation-state management
- `go_router` for navigation
- `Dio` for API communication, caching, and retries
- `get_it` for dependency injection
- `flutter_secure_storage` and `shared_preferences` for local storage
- Firebase Core and Analytics

## Requirements

- Flutter SDK compatible with Dart SDK `^3.10.4`
- A configured Android or iOS development environment
- Access to the Sangapu backend API

## Setup

1. Clone the repository and open its root directory.

2. Create a `.env` file in the project root:

   ```env
   API_BASE_URL=https://your-api-host.example/api/
   ```

   `API_BASE_URL` is required at startup. Keep real API URLs and credentials out of version control; `.env` is already ignored.

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app on a connected device or emulator:

   ```bash
   flutter run
   ```

## Common commands

```bash
# Check code quality
flutter analyze

# Run tests
flutter test

# Generate Freezed/build-runner files after changing annotated models or states
dart run build_runner build --delete-conflicting-outputs

# Build a release APK
flutter build apk --release
```

## Project structure

```text
lib/
??? common/       # Shared errors, extensions, logging, and typedefs
??? core/         # App initialization, configuration, networking, storage, DI, theme, and reusable widgets
??? features/     # Feature modules: auth, dashboard, income, expenses, statements, reports, exports, and banners
??? routers/      # GoRouter routes and route names
??? main.dart     # Application entry point

assets/
??? logo/         # Application branding assets
```

## Architecture

Features are organized around repositories and BLoC/Cubit state management. The application starts by loading `.env`, configuring the API client and cache, initializing local storage, and registering dependencies. API calls use the configured `API_BASE_URL`; login tokens are persisted securely for authenticated requests.

## Version

Current application version: `2.1.6+15`.
