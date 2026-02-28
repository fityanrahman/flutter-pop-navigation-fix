# Router Experiment

A Flutter application demonstrating a routing issue with a 3-screen flow. This project explores and solves navigation problems when using `context.pop()` after data operations, specifically when returning from the third screen back to the first screen without proper data refresh.

## Overview

This project showcases a simple multi-screen Flutter app with the following features:
- **Navigation Management**: Implementation of declarative routing using `go_router`
- **State Persistence**: Data persistence using `shared_preferences`
- **Screen Transitions**: Smooth navigation between multiple screens
- **Data Management**: CRUD operations with local storage

## Key Features

- **Three-Screen Flow**:
  - `ListScreen` - Display list of items (first screen)
  - `AddItemScreen` - Add data/QR code scanner (second screen)
  - `AddNotesScreen` - Confirm item addition (third screen)

- **Routing Issue Focus**:
  - `context.pop()` not returning to first screen properly
  - Data not refreshing when navigating back
  - Navigation going to wrong screen after pop operation

## Technical Stack

- **Flutter**: ^3.10.7
- **go_router**: ^17.0.1 - Declarative routing
- **shared_preferences**: ^2.5.4 - Local data persistence

## Project Structure

```
lib/
├── const/
│   ├── app_routes_const.dart    # Route path constants
│   ├── hero_tag_const.dart      # Hero animation tags
│   └── key_pair_const.dart      # Key pair constants
├── router/
│   └── app_router.dart          # Router configuration
├── screens/
│   ├── add_item_screen.dart     # Add item functionality
│   ├── add_notes_screen.dart    # Add notes functionality
│   └── list_screen.dart         # Main list display
├── service/
│   └── shared_preference_service.dart  # Data persistence layer
└── main.dart                    # App entry point
```

## Getting Started

### Prerequisites

- Flutter SDK (version compatible with ^3.10.7)
- Dart SDK
- An IDE (Android Studio, VS Code, or IntelliJ)

### Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd router_experiment
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run
   ```

## Routing Implementation

This project demonstrates several key routing concepts:

### Route Definitions
Routes are centrally defined in `AppRoutesConst`:
```dart
static const String listScreen = '/list';
static const String addItemScreen = '/add_item';
static const String addNotesScreen = '/add_notes';
```

### Router Configuration
The `AppRouter` class provides a clean initialization pattern:
```dart
static Future<void> init() async {
  router = GoRouter(
    initialLocation: AppRoutesConst.listScreen,
    routes: [
      // Route definitions here
    ],
  );
}
```

### Navigation Usage
Navigation is handled through the `GoRouter` instance:
```dart
context.push(AppRoutesConst.addItemScreen);
```

## Problem Statement

The main issue this project addresses:
- When successfully adding data in the third screen (`AddNotesScreen`)
- Using `context.pop()` doesn't return to the first screen (`ListScreen`) properly
- Either returns to wrong screen or doesn't refresh the data on the first screen

## Alternative Implementation

This project also has a **Cubit approach version** available in a separate branch. The Cubit implementation demonstrates state management solutions for the same routing issue using BLoC pattern for better state handling across the navigation flow.

## Contributing

This is a learning project focused on solving routing issues. Feel free to fork and modify for your own navigation experiments.

## Credits

This README was written with assistance from [Windsurf](https://windsurf.ai/).

## Resources

- [go_router Documentation](https://pub.dev/packages/go_router)
- [Flutter Navigation](https://docs.flutter.dev/cookbook/navigation)
- [Flutter Architecture](https://docs.flutter.dev/development/data-and-backend/state-mgmt)
