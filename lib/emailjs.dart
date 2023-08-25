library emailjs;

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'src/models/emailjs_response_status.dart';
import 'src/utils/validate_params.dart';
import 'src/api/send_json.dart';
import 'src/models/options.dart';

export 'src/models/emailjs_response_status.dart';
export 'src/models/options.dart';

class EmailJS {
  /// Public Key specified in the [init] method
  static String _publicKey = '';

  /// Private Key specified in the [init] method
  static String? _privateKey;

  /// API host specified in the [init] method
  static String _host = 'api.emailjs.com';

  /// HTTP Client specified in the [init] method
  static http.Client? _httpClient;

  /// Global configuration for EmailJS
  ///
  /// Sets globally the EmailJS [options]
  static void init(
    Options options, [
    String? host,
    http.Client? customHttpClient,
  ]) {
    EmailJS._publicKey = options.publicKey;
    EmailJS._privateKey = options.privateKey;
    EmailJS._host = host ?? 'api.emailjs.com';
    EmailJS._httpClient = customHttpClient;
  }

  /// Sends the email through the [serviceID] using the ready-made [templateID].
  ///
  /// It's possible to pass [templatePrams] dynamic variables,
  /// and set the [options] for this call.
  static Future<EmailJSResponseStatus> send(
    String serviceID,
    String templateID, [
    Map<String, dynamic>? templatePrams,
    Options? options,
  ]) {
    final pubKey = options?.publicKey ?? EmailJS._publicKey;
    final prKey = options?.privateKey ?? EmailJS._privateKey;

    validateParams(pubKey, serviceID, templateID);

    final Map<String, dynamic> params = {
      'lib_version': '1.3.0',
      'user_id': pubKey,
      'accessToken': prKey,
      'service_id': serviceID,
      'template_id': templateID,
      'template_params': templatePrams,
    };

    return sendJSON(
      Uri.https(EmailJS._host, 'api/v1.0/email/send'),
      json.encode(params),
      EmailJS._httpClient,
    );
  }
}
