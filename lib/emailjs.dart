library emailjs;

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'src/utils/validate_params.dart';
import 'src/api/send_json.dart';

class EmailJS {
  static String _publicKey = '';
  static String _origin = 'api.emailjs.com';
  static http.Client _httpClient = http.Client();

  static void init(String publicKey, [String? origin, http.Client? httpClient]) {
    EmailJS._publicKey = publicKey;
    EmailJS._origin = origin ?? 'api.emailjs.com';
    EmailJS._httpClient = httpClient ?? http.Client();
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
      EmailJS._httpClient,
      Uri.https(EmailJS._origin, 'api/v1.0/email/send'),
      json.encode(params),
    );
  }
}
