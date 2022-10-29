library emailjs;

import 'dart:convert';

import 'package:emailjs/utils/validate_params.dart';
import 'package:emailjs/api/send_json.dart';

class EmailJS {
  static String _publicKey = '';
  static String _origin = 'api.emailjs.com';

  static void init(String publicKey, [String? origin]) {
    EmailJS._publicKey = publicKey;
    EmailJS._origin = origin ?? 'api.emailjs.com';
  }

  static Future<String> send(
    String serviceID,
    String templateID, [
    Map<String, dynamic>? templatePrams,
    String? publicKey,
  ]) async {
    final pubKey = publicKey ?? EmailJS._publicKey;

    validateParams(pubKey, serviceID, templateID);

    final Map<String, dynamic> params = {
      'lib_version': '0.0.1',
      'user_id': pubKey,
      'service_id': serviceID,
      'template_id': templateID,
      'template_params': templatePrams,
    };

    return await sendJSON(
      Uri.https(EmailJS._origin, 'api/v1.0/email/send'),
      json.encode(params),
    );
  }
}
