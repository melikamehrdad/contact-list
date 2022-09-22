import 'package:http/http.dart' as http;

//Delete one contact with contact ID
Future<http.Response> deleteContact(String id) async {
  final response = await http.delete(
    Uri.parse('https://api.restpoint.io/api/contacts/$id'),
    headers: {'x-endpoint-key': '38444aae02c84851969f93e5d0e6eb37'},
  );

  return response;
}
