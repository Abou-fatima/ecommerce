import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:task/providers/app_providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('FavoritesNotifier persists favorite IDs', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final notifier = FavoritesNotifier(prefs);

    await notifier.toggle('p1');
    await notifier.toggle('p2');
    await notifier.toggle('p1');

    expect(notifier.state, {'p2'});
    expect(prefs.getStringList('favoriteProductIds'), ['p2']);
  });
}
