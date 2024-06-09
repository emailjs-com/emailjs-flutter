import '../models/emailjs_response_status.dart';

void blockedEmailError() {
  return new EmailJSResponseStatus(
    status: 403,
    text: 'Forbidden',
  );
}
