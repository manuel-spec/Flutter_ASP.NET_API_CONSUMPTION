import 'dart:convert';
import 'package:http/http.dart' as http;

class ChangePasswordPostApi {
  static const String baseUrl = 'http://192.168.137.113:5000/user';

  Future<http.Response> ChangePassword(
      String email, String password, String newPassword) async {
    final String apiUrl = '$baseUrl/change-password';

// {
//   "guestName": "test22@gmail.com",
//   "checkInDate": "2024-01-28T19:35:43.735Z",
//   "checkOutDate": "2024-01-28T19:35:43.735Z"
// }

    try {
      // Prepare data to send in the request body
      Map<String, dynamic> requestData = {
        'userEmail': email,
        'currentPassword': password,
        'newPassword': newPassword,
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
