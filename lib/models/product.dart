class Product {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.isFeatured,
  });

  final String id;
  final String name;
  final String category;
  final double price;
  final String description;
  final String imageUrl;
  final double rating;
  final bool isFeatured;
}

class CartItem {
  const CartItem({required this.product, required this.quantity});

  final Product product;
  final int quantity;

  double get totalPrice => product.price * quantity;

  CartItem copyWith({Product? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}

class UserProfile {
  const UserProfile({
    required this.name,
    required this.email,
    required this.location,
    required this.memberSince,
  });

  final String name;
  final String email;
  final String location;
  final String memberSince;
}

enum ProductSort { featured, priceAsc, priceDesc, rating }

class ProductFilter {
  const ProductFilter({this.category = 'All', this.featuredOnly = false});

  final String category;
  final bool featuredOnly;

  ProductFilter copyWith({String? category, bool? featuredOnly}) {
    return ProductFilter(
      category: category ?? this.category,
      featuredOnly: featuredOnly ?? this.featuredOnly,
    );
  }
}
