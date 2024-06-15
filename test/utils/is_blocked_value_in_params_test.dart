import 'package:flutter_test/flutter_test.dart';

import 'package:emailjs/emailjs.dart';
import 'package:emailjs/src/utils/is_blocked_value_in_params.dart';

void main() {
  group('should be disabled', () {
    test('get value', () {
      const blockList = BlockList();
      expect(isBlockedValueInParams(blockList, {}), false);
    });

    test('without list', () {
      const blockList = BlockList(watchVariable: 'email');
      expect(isBlockedValueInParams(blockList, {}), false);
    });

    test('without watchVariable', () {
      const blockList = BlockList(list: ['test@emailjs.com']);
      expect(isBlockedValueInParams(blockList, {}), false);
    });

    test('without data', () {
      const blockList = BlockList(
        watchVariable: 'email',
        list: ['test@emailjs.com'],
      );

      expect(isBlockedValueInParams(blockList, {}), false);
    });

    test('wrong type', () {
      const blockList = BlockList(
        watchVariable: 'email',
        list: ['test@emailjs.com'],
      );

      expect(isBlockedValueInParams(blockList, {
        'email': ['item', 'item'],
      }), false);
    });

    test('not found in the list', () {
      const blockList = BlockList(
        watchVariable: 'email',
        list: ['test@emailjs.com', 'bar@emailjs.com'],
      );

      expect(isBlockedValueInParams(blockList, {
        'email': 'foo@emailjs.com',
      }), false);
    });
  });

  group('should be enabled', () {
    test('template params', () {
      const blockList = BlockList(
        watchVariable: 'email',
        list: ['test@emailjs.com', 'foo@emailjs.com', 'bar@emailjs.com'],
      );

      expect(isBlockedValueInParams(blockList, {
        'email': 'test@emailjs.com',
        'other': 'other data',
      }), true);
    });
  });
}
