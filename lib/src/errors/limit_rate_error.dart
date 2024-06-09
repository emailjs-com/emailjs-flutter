import '../models/emailjs_response_status.dart';

EmailJSResponseStatus limitRateError() {
  return new EmailJSResponseStatus(
    status: 429,
    text: 'Too Many Requests',
  );
}
