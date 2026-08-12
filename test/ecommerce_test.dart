import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:task/models/product.dart';
import 'package:task/providers/app_providers.dart';
import 'package:task/repositories/product_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  test('CartNotifier adds one unit and increments quantity', () {
    final cart = CartNotifier();
    const product = Product(
      id: 'p1',
      name: 'Headphones',
      category: 'Audio',
      price: 50,
      description: 'desc',
      imageUrl: 'https://example.com',
      rating: 4.5,
      isFeatured: true,
    );

    cart.add(product);
    cart.add(product);

    expect(cart.state['p1']?.quantity, 2);
    expect(cart.state['p1']?.totalPrice, 100);
  });

  test('CartNotifier removes quantity and deletes item at zero', () {
    final cart = CartNotifier();
    const product = Product(
      id: 'p2',
      name: 'Lamp',
      category: 'Home',
      price: 30,
      description: 'desc',
      imageUrl: 'https://example.com',
      rating: 4,
      isFeatured: false,
    );

    cart.add(product);
    cart.remove(product);

    expect(cart.state.containsKey('p2'), isFalse);
  });

  test('FavoritesNotifier persists toggled ids', () async {
    final prefs = await SharedPreferences.getInstance();
    final notifier = FavoritesNotifier(prefs);

    await notifier.toggle('a1');
    await notifier.toggle('a2');
    await notifier.toggle('a1');

    expect(notifier.state, {'a2'});
    expect(prefs.getStringList('favoriteProductIds'), ['a2']);
  });

  test('ProductRepository filters and sorts products', () {
    final repository = ProductRepository();
    final products = [
      const Product(
        id: '1',
        name: 'A',
        category: 'Audio',
        price: 30,
        description: 'A',
        imageUrl: 'a',
        rating: 4.0,
        isFeatured: false,
      ),
      const Product(
        id: '2',
        name: 'B',
        category: 'Audio',
        price: 15,
        description: 'B',
        imageUrl: 'b',
        rating: 4.8,
        isFeatured: true,
      ),
      const Product(
        id: '3',
        name: 'C',
        category: 'Furniture',
        price: 80,
        description: 'C',
        imageUrl: 'c',
        rating: 3.8,
        isFeatured: true,
      ),
    ];

    final filtered = repository.filterAndSort(
      products,
      'Audio',
      true,
      ProductSort.priceAsc,
    );

    expect(filtered.map((product) => product.id), ['2']);
  });

  test('ProductFilterNotifier updates state correctly', () {
    final notifier = ProductFilterNotifier();
    notifier.updateCategory('Furniture');
    notifier.toggleFeaturedOnly();

    expect(notifier.state.category, 'Furniture');
    expect(notifier.state.featuredOnly, isTrue);
  });

  test('Sort notifier handles price descending sort', () {
    final notifier = ProductSortNotifier();
    notifier.update(ProductSort.priceDesc);

    expect(notifier.state, ProductSort.priceDesc);
  });
}
