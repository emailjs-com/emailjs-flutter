library emailjs;

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'src/models/emailjs_response_status.dart';
import 'src/utils/validate_params.dart';
import 'src/api/send_json.dart';
import 'src/models/options.dart';
import 'src/store/store.dart';
import 'src/methods/init';

export 'src/models/emailjs_response_status.dart';
export 'src/models/options.dart';
export 'src/models/block_list.dart';
export 'src/models/limit_rate.dart';
export 'src/methods/init';

class EmailJS {
  /// Public Key specified in the [init] method
  static String _publicKey = '';

  /// Private Key specified in the [init] method
  static String? _privateKey;

  /// Global configuration for EmailJS
  ///
  /// Sets globally the EmailJS [options]
  static void init = init;

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
      'lib_version': '4.0.0',
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
