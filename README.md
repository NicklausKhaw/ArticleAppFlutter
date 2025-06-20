# Article App Flutter

This is a Flutter app to view articles from the New York Times Most Popular API, built using the MVVM (Model-View-ViewModel) architecture.

## Features

- View Most Popular, Most Emailed, and Most Shared articles from NYT
- Filter articles by time period (1, 7, or 30 days)
- Pull-to-refresh functionality
- Error handling and loading states
- Clean MVVM architecture with built-in Flutter state management

## Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/NicklausKhaw/ArticleAppFlutter.git
   cd ArticleAppFlutter
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

## Architecture

This project follows the MVVM (Model-View-ViewModel) pattern:

- **Views**: UI components that display data and handle user interactions
- **ViewModels**: Business logic layer that manages state and provides data to views
- **Models**: Data models for articles and API responses
- **Services**: API service for fetching data from NYT API

## Dependencies

- `http: ^1.1.0` - HTTP requests for API calls