import '../models/emailjs_response_status.dart';

EmailJSResponseStatus blockedEmailError() {
  return new EmailJSResponseStatus(
    status: 403,
    text: 'Forbidden',
  );
}
