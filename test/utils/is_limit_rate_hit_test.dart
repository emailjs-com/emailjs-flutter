import 'package:emailjs/src/models/default_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:emailjs/emailjs.dart';
import 'package:emailjs/src/utils/is_limit_rate_hit.dart';

void main() {
  setUp(() async {
    final Map<String, Object> values = <String, Object>{};
    SharedPreferences.setMockInitialValues(values);
  });

  group('limit rate is disabled', () {
    test('empty limit rate options', () async {
      DefaultStorage storage = DefaultStorage();
      const limitRate = LimitRate();

      expect(await isLimitRateHit(limitRate, storage), false);
    });

    test('throttle is 0', () async {
      DefaultStorage storage = DefaultStorage();
      const limitRate = LimitRate(throttle: 0);

      expect(await isLimitRateHit(limitRate, storage), false);
    });

    test('no record', () async {
      DefaultStorage storage = DefaultStorage();
      const limitRate = LimitRate(throttle: 1000, id: 'app');

      expect(await isLimitRateHit(limitRate, storage), false);
    });

    test('no hit limit', () async {
      DefaultStorage storage = DefaultStorage();
      const limitRate = LimitRate(throttle: 100, id: 'app');

      expect(await isLimitRateHit(limitRate, storage), false);

      await Future.delayed(const Duration(milliseconds: 150));

      expect(await isLimitRateHit(limitRate, storage), false);
    });

    test('not same page or ID', () async {
      DefaultStorage storage = DefaultStorage();
      LimitRate limitRate = const LimitRate(throttle: 100, id: 'app');

      expect(await isLimitRateHit(limitRate, storage), false);

      limitRate = const LimitRate(throttle: 100, id: 'new-app');
      
      expect(await isLimitRateHit(limitRate, storage), false);
    });
  });

  group('limit rate is enabled', () {
    test('hit limit', () async {
      DefaultStorage storage = DefaultStorage();
      const limitRate = LimitRate(throttle: 100, id: 'app');

      expect(await isLimitRateHit(limitRate, storage), false);
      expect(await isLimitRateHit(limitRate, storage), true);
    });
  });
}
