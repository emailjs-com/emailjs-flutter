library emailjs;

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'src/utils/validate_params.dart';
import 'src/api/send_json.dart';

class EmailJS {
  /// Public Key specified in the [init] method
  static String _publicKey = '';

  /// API host specified in the [init] method
  static String _origin = 'api.emailjs.com';

  /// HTTP Client specified in the [init] method
  static http.Client _httpClient = http.Client();

  /// Global configuration for EmailJS
  ///
  /// Sets globally the [publicKey] for the application
  static void init(
    String publicKey, [
    String? origin,
    http.Client? httpClient,
  ]) {
    EmailJS._publicKey = publicKey;
    EmailJS._origin = origin ?? 'api.emailjs.com';
    EmailJS._httpClient = httpClient ?? http.Client();
  }

  /// Sends the email through the [serviceID] using the ready-made [templateID].
  ///
  /// It's possible to pass [templatePrams] dynamic variables,
  /// and set the [publicKey] for this call.
  static Future<String> send(
    String serviceID,
    String templateID, [
    Map<String, dynamic>? templatePrams,
    String? publicKey,
  ]) async {
    final pubKey = publicKey ?? EmailJS._publicKey;

    validateParams(pubKey, serviceID, templateID);

    final Map<String, dynamic> params = {
      'lib_version': '0.0.3',
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
