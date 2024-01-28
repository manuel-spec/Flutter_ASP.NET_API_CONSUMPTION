import 'package:flutter_responsive_login_ui/Home/api/ReservationModel.dart';
import 'package:http/http.dart' as http;

class ReservationsApi {
  static const String baseUrl = 'http://192.168.137.113:5000';

  Future<http.Response> getReservations() async {
    final String apiUrl = '$baseUrl/hotel';

    try {
      // Send POST request
      var response = await http.get(
        Uri.parse(apiUrl),
      );

      List<Reservation> reservations = parseReservations(response.body);

      return response;
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
      return http.Response('Error occurred', 500);
    }
  }
}
