import 'package:flutter_test/flutter_test.dart';

import 'package:emailjs/emailjs.dart';
import 'package:emailjs/src/errors/blocked_email_error.dart';

void main() {
  test('should return EmailJSResponseStatus', () {
    final error = blockedEmailError();
    expect(error.runtimeType, EmailJSResponseStatus);
  });

  test('should return status 403', () {
    final error = blockedEmailError();
    expect('$error', '[403] Forbidden');
  });
}