import '../models/emailjs_response_status.dart';

void limitRateError() {
  return new EmailJSResponseStatus(429, 'Too Many Requests');
}
