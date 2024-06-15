import 'package:emailjs/emailjs.dart';
import 'package:emailjs/src/store/store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStorage extends Mock implements StorageProvider {}

void main() {
  test('origin setter', () {

    final store = Store();
    expect(store.host, 'api.emailjs.com');

    store.origin = 'test.com';
    expect(store.host, 'test.com');

    store.origin = null;
    expect(store.host, 'test.com');
  });

  test('storageProvider setter', () {

    final store = Store();

    store.storageProvider = MockStorage();
    expect(store.storageProvider is MockStorage, true);

    store.storageProvider = null;
    expect(store.storageProvider is MockStorage, true);
  });
}