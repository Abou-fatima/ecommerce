# Breeze Cart

A Flutter e-commerce application built with Riverpod for state management. The app includes a product catalog, shopping cart, favorites persistence, filtering, sorting, and a mock user profile.

## Overview

Breeze Cart is a mobile storefront demo designed to demonstrate a clean Riverpod architecture in Flutter. It follows a layered approach where the app separates data, state management, and presentation logic.

## Features

- Product catalog with list and detail views
- Add to cart, remove item, and adjust quantity
- Favorites system persisted locally using SharedPreferences
- Product filtering by category and featured items
- Search by product name or category
- Sorting by featured, price, or rating
- User profile screen with mock account data
- Loading and error states for async product fetching

## Architecture

The app follows the pattern:

model → repository → provider → screen

### Project structure

- `lib/main.dart` — app bootstrap and provider scope setup
- `lib/app.dart` — app shell and bottom navigation
- `lib/models/product.dart` — domain models and product-related state
- `lib/repositories/product_repository.dart` — mock product data and filtering logic
- `lib/providers/app_providers.dart` — all Riverpod providers and state notifiers
- `lib/screens/` — home, detail, favorites, cart, and profile screens

## Riverpod implementation

The project uses Riverpod exclusively for state management.

### Providers used

- `productsProvider` — `FutureProvider` for async product loading
- `favoritesProvider` — `StateNotifierProvider` for persisted favorite IDs
- `cartProvider` — `StateNotifierProvider` for cart item state
- `filterProvider` — `StateNotifierProvider` for category and featured filters
- `searchQueryProvider` — `StateNotifierProvider` for live search text
- `sortProvider` — `StateNotifierProvider` for sorting options
- `filteredProductsProvider` — `Provider` for derived filtered/sorted product data
- `cartTotalProvider` — `Provider` for live cart total
- `cartItemCountProvider` — `Provider` for cart badge count
- `favoriteCountProvider` — `Provider` for favorites summary
- `profileProvider` — `Provider` for mock profile information

This keeps business logic outside the widgets and ensures state changes are predictable, testable, and maintainable.

## State behavior

- Product data is fetched asynchronously and exposed through `productsProvider`
- Favorite IDs are stored locally and restored on startup
- Cart operations are managed in a notifier to keep updates centralized
- Filtering, sorting, and search are combined into a derived provider to avoid widget-level business logic

## Screens

- Home screen: catalog, search, filters, sorting
- Product detail screen: product info and add-to-cart/favorite actions
- Favorites screen: saved products list
- Cart screen: quantity management and total
- Profile screen: mock account information

## Requirements

- Flutter SDK
- Dart SDK
- Dependencies from `pubspec.yaml`

## Getting started

```bash
flutter pub get
flutter run
```

## Running tests

```bash
flutter test
```

## Notes

This project is designed as a certification-ready Flutter e-commerce demo using Riverpod 2.x patterns and a layered architecture suitable for real-world app structure.
