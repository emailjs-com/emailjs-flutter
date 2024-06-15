import '../models/emailjs_response_status.dart';

EmailJSResponseStatus limitRateError() {
  return const EmailJSResponseStatus(
    status: 429,
    text: 'Too Many Requests',
  );
}
