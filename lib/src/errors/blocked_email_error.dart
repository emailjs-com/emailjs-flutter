import '../models/emailjs_response_status.dart';

void blockedEmailError() {
  return new EmailJSResponseStatus(403, 'Forbidden');
}
