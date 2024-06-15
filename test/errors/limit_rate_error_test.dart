import 'package:flutter_test/flutter_test.dart';

import 'package:emailjs/emailjs.dart';
import 'package:emailjs/src/errors/limit_rate_error.dart';

void main() {
  test('should return EmailJSResponseStatus', () {
    final error = limitRateError();
    expect(error.runtimeType, EmailJSResponseStatus);
  });

  test('should return status 429', () {
    final error = limitRateError();
    expect('$error', '[429] Too Many Requests');
  });
}