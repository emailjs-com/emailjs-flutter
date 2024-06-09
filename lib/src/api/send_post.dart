import 'package:http/http.dart' as http;
import '../store/store.dart';
import '../models/emailjs_response_status.dart';

/// sends JSON object via HTTPS POST
Future<EmailJSResponseStatus> sendPost(
  String url,
  String data
) async {
   
  final client = http.Client();

  try {
    final response = await client.post(
      Uri.https(store.origin, url),
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
