import 'package:http/http.dart' as http;

Future<String> sendJSON(Uri uri, String data) async {
  var response = await http.post(
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
}
