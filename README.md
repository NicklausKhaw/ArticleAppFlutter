# Article App Flutter

A Flutter application built using the MVVM (Model-View-ViewModel) architecture pattern.

## Project Structure

```
lib/
├── main.dart              # Application entry point
├── views/                 # UI components (Views)
│   └── home_page.dart     # Home page widget
└── viewmodels/            # Business logic (ViewModels)
    └── home_view_model.dart # Home page view model
```

## Architecture

This project follows the MVVM (Model-View-ViewModel) pattern:

- **Views**: UI components that display data and handle user interactions
- **ViewModels**: Business logic layer that manages state and provides data to views
- **Models**: Data models (to be added as needed)

## Dependencies

- `provider: ^6.1.1` - State management for MVVM pattern

## Getting Started

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Run the app:
   ```bash
   flutter run
   ```

## Features

- Counter functionality with MVVM architecture
- Clean separation of concerns between UI and business logic
- State management using Provider package
