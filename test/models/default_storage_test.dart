import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:emailjs/src/models/default_storage.dart';

void main() {
  setUpAll(() async {
    final Map<String, Object> values = <String, Object>{'test': 100};
    SharedPreferences.setMockInitialValues(values);
  });

  test('get value', () async {
    DefaultStorage storage = DefaultStorage();
    final value = await storage.get('test');
    expect(value, 100);
  });

  test('remove value', () async {
    DefaultStorage storage = DefaultStorage();
    await storage.remove('test');
    expect(await storage.get('test'), null);
  });

  test('set value', () async {
    DefaultStorage storage = DefaultStorage();
    await storage.set('test', 500);
    expect(await storage.get('test'), 500);
  });
}
