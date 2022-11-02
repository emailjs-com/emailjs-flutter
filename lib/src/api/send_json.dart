import 'package:http/http.dart' as http;
import '../models/emailjs_response_status.dart';

Future<EmailJSResponseStatus> sendJSON(http.Client client, Uri uri, String data) async {
  try {
    var response = await client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: data,
    );

    if (response.statusCode == 200) {
      return EmailJSResponseStatus(response.statusCode, response.body);
    } else {
      throw EmailJSResponseStatus(response.statusCode, response.body);
    }
  } finally {
    client.close();
  }
}
