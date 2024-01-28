import 'package:flutter/material.dart';
import 'package:flutter_responsive_login_ui/Home/BookReservation.dart';
import 'package:flutter_responsive_login_ui/Home/CancelReservation.dart';
import 'package:flutter_responsive_login_ui/Home/Reservations.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class HomeScreen extends StatefulWidget {
  final token;
  const HomeScreen({@required this.token, Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeScreen> {
  late String email;
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();

    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
  }

  @override
  Widget build(BuildContext context) {
    Reservations reservations = Reservations();
    BookReservation bookReservation = BookReservation();
    CancelReservation cancelReservation = CancelReservation();

    return Scaffold(
      appBar: AppBar(title: Text(email)),
      body: [reservations, bookReservation, cancelReservation][selectedIndex],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.hotel), label: "Reservations"),
          NavigationDestination(icon: Icon(Icons.add), label: "Book"),
          NavigationDestination(
              icon: Icon(Icons.remove), label: "Canel Reservation")
        ],
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
