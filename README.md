# Breeze Cart

A Flutter e-commerce app built with Riverpod, featuring a product catalog, shopping cart, favorites persistence, filtering and sorting, and a mock profile screen.

## Architecture

- `lib/models/product.dart`: product and cart models plus shared state definitions
- `lib/data`: mocked product catalog
- `lib/repositories/product_repository.dart`: mock data and product filtering logic
- `lib/providers/app_providers.dart`: all Riverpod providers and notifiers
- `lib/screens`: UI screens for home, product detail, favorites, cart and profile
- `lib/app.dart`: app shell and navigation

## Riverpod providers used

- `productsProvider` (FutureProvider) for product loading
- `favoritesProvider` (StateNotifierProvider) for saved favorite IDs
- `cartProvider` (StateNotifierProvider) for cart items
- `filterProvider` (StateNotifierProvider) for category and featured filtering
- `sortProvider` (StateNotifierProvider) for catalog sorting
- `cartTotalProvider` (Provider) for the live total
- `profileProvider` (Provider) for mock user profile data

The app follows a layered pattern: model → repository → provider → screen.

## Run

```bash
flutter pub get
flutter run
```

## Test

```bash
flutter test
```
