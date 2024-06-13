import 'package:emailjs/src/utils/validate_limit_rate_params.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('should fail', () {
    test('throttle is a negative number', () {
      expect(
        () => validateLimitRateParams(-1000),
        throwsA(startsWith('The LimitRate throttle has to be a positive number')),
      );
    });

    test('ID is empty', () {
      expect(
        () => validateLimitRateParams(1000, ''),
        throwsA(startsWith('The LimitRate ID has to be a non-empty string')),
      );
    });
  });

  group('should successfully pass the validation', () {
    test('throttle is a positive number', () {
      expect(
        () => validateLimitRateParams(1000),
        returnsNormally,
      );
    });

    test('ID is valid string', () {
      expect(
        () => validateLimitRateParams(1000, 'app'),
        returnsNormally,
      );
    });
  });
}