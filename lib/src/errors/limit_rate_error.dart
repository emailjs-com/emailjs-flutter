import '../models/emailjs_response_status.dart';

void limitRateError() {
  return new EmailJSResponseStatus(
    status: 429,
    text: 'Too Many Requests',
  );
}
