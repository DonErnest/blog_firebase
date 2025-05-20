import 'dart:convert';

import 'package:http/http.dart' as http;

Future<dynamic> request(
    String url, {
      String method = 'GET',
      dynamic body,
    }) async {
  http.Response response;
  final uri = Uri.parse(url);

  if (method == 'GET') {
    response = await http.get(uri);
  } else if (method == 'POST') {
    response = await http.post(uri, body: jsonEncode(body));
  } else if (method == 'PUT') {
    response = await http.put(uri, body: jsonEncode(body));
  } else if (method == 'DELETE') {
    response = await http.delete(uri);
  } else {
    throw Exception('Method $method not supported');
  }

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Request Error. Url: $url, code: ${response.statusCode}');
  }
}
