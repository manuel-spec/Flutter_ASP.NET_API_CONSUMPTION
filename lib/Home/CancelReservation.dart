import 'package:flutter/material.dart';
import 'package:flutter_responsive_login_ui/Home/api/ChangePasswordPostApi.dart';
import 'package:flutter_responsive_login_ui/widgets/gradient_button.dart';
import 'package:flutter_responsive_login_ui/widgets/login_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CancelReservation extends StatefulWidget {
  const CancelReservation({super.key});

  @override
  State<CancelReservation> createState() => _CancelReservationState();
}

class _CancelReservationState extends State<CancelReservation> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordReController = TextEditingController();
  bool isLoading = false;

  void ChangePassword() async {
    setState(() {
      isLoading = true; // Set loading state to true when login starts
    });

    ChangePasswordPostApi changePasswordApi = ChangePasswordPostApi();
    String email = emailController.text;
    String password = passwordController.text;
    String newPassword = passwordReController.text;

    if (email == '' || password == '' || newPassword == '') {
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
      var response =
          await changePasswordApi.ChangePassword(email, password, newPassword);

      setState(() {
        isLoading = false; // Set loading state to false when login is complete
      });
      print(response.statusCode);

      // Check the response
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Password changed Successfully !!",
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 18);
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong!!",
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 18);
      }
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
                'Change Password',
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
                hintText: 'email',
                controller: emailController,
              ),
              const SizedBox(height: 15),
              LoginField(
                hintText: 'old password',
                controller: passwordController,
              ),
              const SizedBox(height: 15),
              LoginField(
                hintText: 'new password',
                controller: passwordReController,
              ),
              const SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator() // Show loading indicator
                  : GradientButton(
                      onPressed: ChangePassword,
                      text: 'Change Password',
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
