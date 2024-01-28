import 'dart:convert';

import 'package:http/http.dart' as http;

class SigninApi {
  static const String baseUrl = 'http://10.240.69.41:5000/Login';

  Future<http.Response> loginUser(String email, String password) async {
    final String apiUrl = '$baseUrl/authenticate';

    try {
      // Prepare data to send in the request body
      Map<String, dynamic> requestData = {
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
