# router_experiment

A Flutter project demonstrating routing solutions using different state management approaches. This project explores and solves navigation problems in a 3-screen flow, comparing traditional StatefulWidget with BLoC pattern implementation.

## Overview

This project showcases a multi-screen Flutter app with two different implementations:
- **StatefulWidget Approach**: Basic implementation with routing issues
- **Cubit/BLoC Approach**: Advanced state management solution

> **Disclaimer**: This project is **not** intended to compare or declare which state management approach is "better." It's a personal exploration of different state management patterns and their implementations. The author may experiment with other state management solutions in the future as part of the learning process.

### Screen Flow
1. `ListScreen` - Display list of items
2. `AddItemScreen` - Add data/QR code scanner functionality  
3. `AddNotesScreen` - Confirm item addition

### Routing Problem Solved
- **Issue**: `context.pop()` not returning to first screen properly after data operations
- **Symptoms**: Wrong screen navigation, data not refreshing on return
- **Solution**: Proper handling of `context.push()` result and navigation flow

## Implementations

### 1. StatefulWidget Approach (Main Branch)
- Basic Flutter StatefulWidget pattern
- Manual state management with `setState()`
- Direct service calls in UI layer
- Prone to navigation and state sync issues

### 2. Cubit/BLoC Approach (Cubit Branch)
- **State Management**: BLoC pattern with Cubits
- **Separation of Concerns**: Business logic separated from UI
- **Reactive UI**: Automatic UI updates on state changes
- **Better Error Handling**: Centralized error states
- **Testability**: Easier unit testing of business logic

## Cubit Implementation Details

### Architecture
```
lib/screens/bloc/
├── list_screen/
│   ├── list_screen_cubit.dart    # List state management
│   └── list_screen_state.dart     # List state definitions
└── add_item/
    ├── add_item_cubit.dart        # Add item logic
    └── add_item_state.dart        # Add item states
```

### Key Improvements
- **ListScreenCubit**: Manages list loading, clearing, and error states
- **AddItemCubit**: Handles form validation and data persistence
- **State Status**: Loading, Success, Failure states with proper UI feedback
- **Automatic Refresh**: UI updates automatically when data changes

### State Management Pattern
```dart
// Cubit manages state and business logic
class ListScreenCubit extends Cubit<ListScreenState> {
  Future<void> loadData() async {
    emit(state.copyWith(status: ListScreenStatus.loading));
    // Load data logic...
    emit(state.copyWith(status: ListScreenStatus.success, list: data));
  }
}

// UI reacts to state changes
BlocBuilder<ListScreenCubit, ListScreenState>(
  builder: (context, state) {
    if (state.status == ListScreenStatus.loading) {
      return CircularProgressIndicator();
    }
    return ListView.builder(/* build from state.list */);
  },
)
```

## Technical Stack

- **Flutter**: ^3.10.7
- **go_router**: ^17.0.1 - Declarative routing
- **shared_preferences**: ^2.5.4 - Local data persistence
- **flutter_bloc**: ^9.1.1 - BLoC state management
- **equatable**: ^2.0.8 - Value equality

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

### Switching Between Implementations
- **Main Branch**: StatefulWidget approach
- **Cubit Branch**: BLoC pattern implementation
```bash
# Switch to Cubit implementation
git checkout bloc_version
```

## Implementation Differences

| Aspect | StatefulWidget | Cubit/BLoC |
|--------|----------------|------------|
| State Management | Manual `setState()` | Reactive state emission |
| Code Organization | Logic in UI layer | Separated into Cubits |
| Error Handling | Try-catch in UI | Centralized error states |
| Testing | Widget tests only | Unit tests for Cubits |
| Navigation Issues | Prone to issues | Proper state sync |

*Note: This table is for documentation purposes only and does not imply one approach is superior to the other.*

## Credits

This README was written with assistance from [Windsurf](https://windsurf.ai/).

## Resources

- [go_router Documentation](https://pub.dev/packages/go_router)
- [Flutter BLoC Documentation](https://pub.dev/packages/flutter_bloc)
- [Flutter Navigation](https://docs.flutter.dev/cookbook/navigation)
- [Flutter Architecture](https://docs.flutter.dev/development/data-and-backend/state-mgmt)
