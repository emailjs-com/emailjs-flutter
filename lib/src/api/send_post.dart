import 'package:http/http.dart';
import '../store/store.dart';
import '../models/emailjs_response_status.dart';

/// sends JSON object via HTTPS POST
Future<EmailJSResponseStatus> sendPost(
  String url,
  String data,
  [
    Client? client,
  ]) async {

  client ??= Client();

  try {
    final response = await client.post(
      Uri.https(store.host, url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: data,
    );
    
    final responseStatus = EmailJSResponseStatus(
      status: response.statusCode,
      text: response.body,
    );

    if (response.statusCode == 200) {
      return responseStatus;
    } else {
      throw responseStatus;
    }
  } finally {
    client.close();
  }
}
