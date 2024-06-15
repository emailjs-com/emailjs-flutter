import 'package:flutter_test/flutter_test.dart';

import 'package:emailjs/emailjs.dart';
import 'package:emailjs/src/models/emailjs_response_status.dart';

void main() {
  test('should handle the success response', () {
    const error = EmailJSResponseStatus(status: 200, text: 'OK');
    expect(error.status, 200);
    expect(error.text, 'OK');
  });

  test('should handle the fail response', () {
    const error = EmailJSResponseStatus(status: 404, text: 'No Found');
    expect(error.status, 404);
    expect(error.text, 'No Found');
  });

  test('should handle the null response', () {
    const error = EmailJSResponseStatus();
    expect(error.status, 0);
    expect(error.text, 'Network Error');
  });
}