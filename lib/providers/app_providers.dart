import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product.dart';
import '../repositories/product_repository.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});

final productsProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.fetchProducts();
});

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier(this._prefs) : super(_readFavorites(_prefs));

  final SharedPreferences _prefs;

  static Set<String> _readFavorites(SharedPreferences prefs) {
    final ids = prefs.getStringList('favoriteProductIds');
    return ids?.toSet() ?? <String>{};
  }

  Future<void> toggle(String productId) async {
    final updated = {...state};
    if (updated.contains(productId)) {
      updated.remove(productId);
    } else {
      updated.add(productId);
    }

    state = updated;
    await _prefs.setStringList('favoriteProductIds', updated.toList());
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, Set<String>>(
  (ref) {
    final prefs = ref.watch(sharedPreferencesProvider);
    return FavoritesNotifier(prefs);
  },
);

class CartNotifier extends StateNotifier<Map<String, CartItem>> {
  CartNotifier() : super({});

  void add(Product product) {
    final updated = {...state};
    final existing = updated[product.id];
    if (existing == null) {
      updated[product.id] = CartItem(product: product, quantity: 1);
    } else {
      updated[product.id] = existing.copyWith(quantity: existing.quantity + 1);
    }
    state = updated;
  }

  void remove(Product product) {
    final updated = {...state};
    final existing = updated[product.id];
    if (existing == null) {
      return;
    }

    if (existing.quantity <= 1) {
      updated.remove(product.id);
    } else {
      updated[product.id] = existing.copyWith(quantity: existing.quantity - 1);
    }
    state = updated;
  }

  void removeItem(String productId) {
    final updated = {...state};
    updated.remove(productId);
    state = updated;
  }

  void clear() => state = {};
}

final cartProvider = StateNotifierProvider<CartNotifier, Map<String, CartItem>>(
  (ref) {
    return CartNotifier();
  },
);

class ProductFilterNotifier extends StateNotifier<ProductFilter> {
  ProductFilterNotifier() : super(const ProductFilter());

  void updateCategory(String category) {
    state = state.copyWith(category: category);
  }

  void toggleFeaturedOnly() {
    state = state.copyWith(featuredOnly: !state.featuredOnly);
  }
}

final filterProvider =
    StateNotifierProvider<ProductFilterNotifier, ProductFilter>((ref) {
      return ProductFilterNotifier();
    });

class SearchQueryNotifier extends StateNotifier<String> {
  SearchQueryNotifier() : super('');

  void update(String value) => state = value;
  void clear() => state = '';
}

final searchQueryProvider = StateNotifierProvider<SearchQueryNotifier, String>(
  (ref) => SearchQueryNotifier(),
);

class ProductSortNotifier extends StateNotifier<ProductSort> {
  ProductSortNotifier() : super(ProductSort.featured);

  void update(ProductSort sort) => state = sort;
}

final sortProvider = StateNotifierProvider<ProductSortNotifier, ProductSort>((
  ref,
) {
  return ProductSortNotifier();
});

final filteredProductsProvider = Provider<List<Product>>((ref) {
  final productsAsync = ref.watch(productsProvider);
  final products = productsAsync.asData?.value ?? const <Product>[];
  final filter = ref.watch(filterProvider);
  final sort = ref.watch(sortProvider);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();

  final filtered = products.where((product) {
    final matchesCategory =
        filter.category == 'All' || product.category == filter.category;
    final matchesFeatured = !filter.featuredOnly || product.isFeatured;
    final matchesQuery =
        query.isEmpty ||
        product.name.toLowerCase().contains(query) ||
        product.category.toLowerCase().contains(query);
    return matchesCategory && matchesFeatured && matchesQuery;
  }).toList();

  switch (sort) {
    case ProductSort.priceAsc:
      filtered.sort((a, b) => a.price.compareTo(b.price));
      break;
    case ProductSort.priceDesc:
      filtered.sort((a, b) => b.price.compareTo(a.price));
      break;
    case ProductSort.rating:
      filtered.sort((a, b) => b.rating.compareTo(a.rating));
      break;
    case ProductSort.featured:
      filtered.sort((a, b) {
        final aFeatured = a.isFeatured ? 1 : 0;
        final bFeatured = b.isFeatured ? 1 : 0;
        final featureCompare = bFeatured.compareTo(aFeatured);
        if (featureCompare != 0) {
          return featureCompare;
        }
        return b.rating.compareTo(a.rating);
      });
  }

  return filtered;
});

final cartTotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.values.fold<double>(0, (total, item) => total + item.totalPrice);
});

final cartItemCountProvider = Provider<int>((ref) {
  return ref
      .watch(cartProvider)
      .values
      .fold<int>(0, (total, item) => total + item.quantity);
});

final favoriteCountProvider = Provider<int>((ref) {
  return ref.watch(favoritesProvider).length;
});

final profileProvider = Provider<UserProfile>((ref) {
  return const UserProfile(
    name: 'Maya Laurent',
    email: 'maya@breezecart.dev',
    location: 'Paris, France',
    memberSince: 'September 2024',
  );
});
