import 'package:emailjs/src/utils/validate_params.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('should fail on the public key', () {
    test('no key', () {
      expect(
        () => validateParams('', 'default_service', 'my_test_template'),
        throwsA(startsWith('The public key is required')),
      );
    });

    test('no string', () {
      expect(
        () => validateParams(null, 'default_service', 'my_test_template'),
        throwsA(startsWith('The public key is required')),
      );
    });
  });

  group('should fail on the service ID', () {
    test('no key', () {
      expect(
        () => validateParams('d2JWGTestKeySomething', '', 'my_test_template'),
        throwsA(startsWith('The service ID is required')),
      );
    });

    test('no string', () {
      expect(
        () => validateParams('d2JWGTestKeySomething', null, 'my_test_template'),
        throwsA(startsWith('The service ID is required')),
      );
    });
  });

  group('should fail on the service ID', () {
    test('no key', () {
      expect(
        () => validateParams('d2JWGTestKeySomething', 'default_service', ''),
        throwsA(startsWith('The template ID is required')),
      );
    });

    test('no string', () {
      expect(
        () => validateParams('d2JWGTestKeySomething', 'default_service', null),
        throwsA(startsWith('The template ID is required')),
      );
    });
  });

  test('should successfully pass the validation', () {
    expect(
      () => validateParams('d2JWGTestKeySomething', 'default_service', 'my_test_template'),
      returnsNormally,
    );
  });
}
