import 'package:flutter/material.dart';
import 'package:flutter_responsive_login_ui/Home/api/ReservationModel.dart';
import 'package:flutter_responsive_login_ui/Home/api/ReservationsApi.dart';

class Reservations extends StatefulWidget {
  const Reservations({Key? key}) : super(key: key);

  @override
  _ReservationsState createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  late Future<List<Reservation>> futureReservations;

  @override
  void initState() {
    super.initState();
    futureReservations = getReserv();
  }

  Future<List<Reservation>> getReserv() async {
    ReservationsApi reservationsApi = ReservationsApi();
    var response = await reservationsApi.getReservations();

    // Parse JSON data after receiving the response
    List<Reservation> reservations = parseReservations(response.body);
    return reservations;
  }

  @override
  Widget build(BuildContext context) {
    // Use FutureBuilder to handle the asynchronous loading of data
    return Scaffold(
      body: FutureBuilder<List<Reservation>>(
        future: futureReservations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while waiting for the data
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle any errors that occurred during the data fetching
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Display the data when it is available
            List<Reservation> reservations = snapshot.data!;
            return ListView.builder(
              itemCount: reservations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('ID: ${reservations[index].id}'),
                  subtitle: Text('Guest: ${reservations[index].guestName}'),
                  // Add more details as needed
                );
              },
            );
          }
        },
      ),
    );
  }
}
