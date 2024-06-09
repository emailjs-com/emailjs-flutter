import 'package:http/http.dart' as http;
import '../store/store.dart';
import '../models/emailjs_response_status.dart';

/// sends JSON object via HTTP POST
Future<EmailJSResponseStatus> sendPost(
  Uri url,
  String data
) async {
  try {
    final client = http.Client();

    final response = await client.post(
      store.origin + url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: data,
    );
    
    final responseStatus = new EmailJSResponseStatus(response.statusCode, response.body);

    if (response.statusCode == 200) {
      return responseStatus;
    } else {
      throw responseStatus;
    }
  } finally {
    client.close();
  }
}
