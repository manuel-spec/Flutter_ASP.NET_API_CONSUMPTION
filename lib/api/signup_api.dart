import 'dart:convert';

import 'package:http/http.dart' as http;

class SignupApi {
  static const String baseUrl = 'http://10.240.69.41:5000/user';

  Future<http.Response> registerUser(
      String fullname, String email, String password) async {
    final String apiUrl = '$baseUrl/register';

    try {
      // Prepare data to send in the request body
      Map<String, dynamic> requestData = {
        'name': fullname,
        'email': email,
        'password': password,
        // Add any other required fields
      };

      // Send POST request
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );

      return response;
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
      return http.Response('Error occurred', 500);
    }
  }
}
