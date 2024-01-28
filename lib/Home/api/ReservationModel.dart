import 'dart:convert';

class Reservation {
  final String id;
  final String guestName;
  final DateTime checkInDate;
  final DateTime checkOutDate;

  Reservation({
    required this.id,
    required this.guestName,
    required this.checkInDate,
    required this.checkOutDate,
  });
  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      guestName: json['guestName'],
      checkInDate: DateTime.parse(json['checkInDate']),
      checkOutDate: DateTime.parse(json['checkOutDate']),
    );
  }
}

List<Reservation> parseReservations(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Reservation>((json) => Reservation.fromJson(json)).toList();
}
