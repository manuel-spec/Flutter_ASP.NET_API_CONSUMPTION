import 'package:flutter/material.dart';
import 'package:flutter_responsive_login_ui/Home/api/ReservationApiPost.dart';
import 'package:flutter_responsive_login_ui/widgets/gradient_button.dart';
import 'package:flutter_responsive_login_ui/widgets/login_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BookReservation extends StatefulWidget {
  const BookReservation({super.key});

  @override
  State<BookReservation> createState() => _BookReservationState();
}

class _BookReservationState extends State<BookReservation> {
  TextEditingController guestNameController = TextEditingController();
  TextEditingController checkOutController = TextEditingController();
  bool isLoading = false;

  void ReserveBook() async {
    setState(() {
      isLoading = true; // Set loading state to true when login starts
    });

    ReservationApiPost signinApi = ReservationApiPost();
    String guestName = guestNameController.text;
    String checkoutDate = checkOutController.text;

    if (guestName == '' || checkoutDate == '') {
      Fluttertoast.showToast(
          msg: "Provide The Form",
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 18);

      setState(() {
        isLoading = false; // Set loading state to false when login is complete
      });
    } else {
      var response = await signinApi.BookReservation(guestName, checkoutDate);

      setState(() {
        isLoading = false; // Set loading state to false when login is complete
      });

      // Check the response
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Reservation Added Successfully !!",
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 18);
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              const Text(
                'Reserve',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const SizedBox(height: 15),
              const SizedBox(height: 15),
              LoginField(
                hintText: 'guest name',
                controller: guestNameController,
              ),
              const SizedBox(height: 15),
              LoginField(
                hintText: 'checkout date',
                controller: checkOutController,
              ),
              const SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator() // Show loading indicator
                  : GradientButton(
                      onPressed: ReserveBook,
                      text: 'Book',
                    ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
