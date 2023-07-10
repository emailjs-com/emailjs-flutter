import 'package:http/http.dart' as http;
import '../models/emailjs_response_status.dart';

/// sends JSON object via HTTP POST
Future<EmailJSResponseStatus> sendJSON(
    Uri uri, String data, http.Client? customClient) async {
  
  final client = customClient ?? http.Client();

  try {
    final response = await client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: data,
    );

    if (response.statusCode == 200) {
      return EmailJSResponseStatus(
        status: response.statusCode,
        text: response.body,
      );
    } else {
      throw EmailJSResponseStatus(
        status: response.statusCode,
        text: response.body,
      );
    }
  } finally {
    client.close();
  }
}
