import 'package:http/http.dart' as http;

Future<String> sendJSON(http.Client client, Uri uri, String data) async {
  try {
    var response = await client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: data,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw response.body;
    }
  } finally {
    client.close();
  }
}
