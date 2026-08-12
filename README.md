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

- `productsProvider` (FutureProvider)
- `favoritesProvider` (StateNotifierProvider)
- `cartProvider` (StateNotifierProvider)
- `filterProvider` (StateNotifierProvider)
- `sortProvider` (StateNotifierProvider)
- `cartTotalProvider` (Provider)
- `profileProvider` (Provider)

## Run

```bash
flutter pub get
flutter run
```

## Test

```bash
flutter test
```
