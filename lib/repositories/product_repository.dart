import '../models/product.dart';

class ProductRepository {
  Future<List<Product>> fetchProducts() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return const [
      Product(
        id: 'p1',
        name: 'Aurora Headphones',
        category: 'Audio',
        price: 129.99,
        description:
            'Premium wireless headphones with deep bass and noise reduction.',
        imageUrl:
            'https://images.unsplash.com/photo-1546435770-a3e426bf472b?auto=format&fit=crop&w=900&q=80',
        rating: 4.8,
        isFeatured: true,
      ),
      Product(
        id: 'p2',
        name: 'Nimbus Chair',
        category: 'Furniture',
        price: 249.0,
        description:
            'Ergonomic chair built for comfort during long work sessions.',
        imageUrl:
            'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=900&q=80',
        rating: 4.6,
        isFeatured: true,
      ),
      Product(
        id: 'p3',
        name: 'Luma Lamp',
        category: 'Home',
        price: 79.5,
        description: 'Minimal desk lamp with warm lighting and touch dimming.',
        imageUrl:
            'https://images.unsplash.com/photo-1515377905703-c4788e51af15?auto=format&fit=crop&w=900&q=80',
        rating: 4.4,
        isFeatured: false,
      ),
      Product(
        id: 'p4',
        name: 'Summit Backpack',
        category: 'Accessories',
        price: 89.0,
        description: 'Water-resistant backpack with a padded laptop sleeve.',
        imageUrl:
            'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=900&q=80',
        rating: 4.7,
        isFeatured: true,
      ),
      Product(
        id: 'p5',
        name: 'Terra Bottle',
        category: 'Lifestyle',
        price: 34.99,
        description:
            'Insulated bottle that keeps drinks cold for up to 24 hours.',
        imageUrl:
            'https://images.unsplash.com/photo-1602143407151-7111542de6e8?auto=format&fit=crop&w=900&q=80',
        rating: 4.5,
        isFeatured: false,
      ),
    ];
  }

  List<Product> filterAndSort(
    List<Product> products,
    String? category,
    bool featuredOnly,
    ProductSort sort,
  ) {
    var filtered = products.where((product) {
      final matchesCategory =
          category == null || category == 'All' || product.category == category;
      final matchesFeatured = !featuredOnly || product.isFeatured;
      return matchesCategory && matchesFeatured;
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
      default:
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
  }
}
