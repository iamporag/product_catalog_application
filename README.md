# Product Catalog Application

A modern Flutter-based Product Catalog application built with GetX state management.  
The app provides product listing, search, favorites, product details, and smooth UI experience with proper loading, error, empty states, and pull-to-refresh support.

---

## Features

- Product Listing (Grid View)
- Product Search
- Add / Remove Favorites
- Product Details Screen
- Loading State Handling
- Error State with Retry Button
- Empty State Handling
- Pull-to-Refresh Support
- Clean & Responsive UI

---

## Project Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/iamporag/product_catalog_application.git
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Run the App
```bash
flutter run
```

### 4. Clean Build (Optional)
```bash
flutter clean
flutter pub get
```

---

## Requirements

- Flutter SDK >= 3.44.0
- Dart SDK >= 3.12.0
- Android Studio / VS Code

---

## Architecture Overview

This project follows a GetX-based MVC-like architecture.

### Folder Structure

lib/
├── controller/
├── view/
├── model/
├── helper/
├── theme/
└── util/

---

## Architecture Flow

UI → GetX Controller → Repository/Service → Model

---

## State Management (GetX)

- GetxController for logic
- update() for UI refresh
- GetBuilder for reactive UI
- Get.toNamed for navigation

---

## Packages Used

- get: State management & navigation
- flutter: UI framework
- http/dio: API calls (if used)

---

## Features Breakdown

### Loading State
Shows progress indicator while fetching data.

### Error State
Shows error message with retry button.

### Empty State
Shows friendly message when no products found.

### Pull-to-Refresh
RefreshIndicator used for reloading data.

---

## Developer

Built with Flutter & GetX
