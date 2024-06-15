import '../models/emailjs_response_status.dart';

EmailJSResponseStatus blockedEmailError() {
  return const EmailJSResponseStatus(
    status: 403,
    text: 'Forbidden',
  );
}
