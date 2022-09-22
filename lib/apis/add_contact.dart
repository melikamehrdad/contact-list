import 'dart:convert';
import 'package:http/http.dart' as http;

//Add new contacts
Future<http.Response> addContact(
    String firstName, String lastName, String phone, String email, String note) async {
  final response = await http.post(
    Uri.parse('https://api.restpoint.io/api/contacts'),
    headers: {'x-endpoint-key': '38444aae02c84851969f93e5d0e6eb37'},
    body: jsonEncode(<String, dynamic>{
      "firstName": firstName,
      "notes": note,
      "phone": phone,
      "email": email,
      "picture": [" "],
      "lastName": lastName,
    }),
  );

  return response;
}