import 'package:http/http.dart' as http;

//Get all contacts
Future<http.Response> getAllContacts() async {
  final response = await http.get(
    Uri.parse('https://api.restpoint.io/api/contacts'),
    headers: {'x-endpoint-key': '38444aae02c84851969f93e5d0e6eb37'},
  );

  return response;
}