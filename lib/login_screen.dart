import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_responsive_login_ui/Home/HomeScreen.dart';
import 'package:flutter_responsive_login_ui/api/signin_api.dart';
import 'package:flutter_responsive_login_ui/pallete.dart';
import 'package:flutter_responsive_login_ui/signup_screen.dart';
import 'package:flutter_responsive_login_ui/verifyEmail/verify_email.dart';
import 'package:flutter_responsive_login_ui/widgets/gradient_button.dart';
import 'package:flutter_responsive_login_ui/widgets/login_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late SharedPreferences prefs;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginUserNow() async {
    setState(() {
      isLoading = true; // Set loading state to true when login starts
    });

    SigninApi signinApi = SigninApi();
    String email = emailController.text;
    String password = passwordController.text;

    var response = await signinApi.loginUser(email, password);

    setState(() {
      isLoading = false; // Set loading state to false when login is complete
    });

    // Check the response
    if (response.statusCode == 200) {
      // Handle success
      Map<String, dynamic> responseBody = json.decode(response.body);

      // Access the 'token' property
      String token = responseBody['token'];
      if (token != '') {
        prefs.setString('token', token);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                    token: token,
                  )),
        );
      } else {}

      print('Login successful! Token: $token');

      // if (response.body["token"] != null) {
      //   var myToken = response.body["token"];
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => const VerifyEmail()),
      //   );
      // }
    } else {
      // Handle error
      print('Login failed. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode.toInt() == 401) {
        Fluttertoast.showToast(
            msg: "Invalid password or email ..",
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 18);
      }
    }
  }

  void navigateToSecondPage() {
    // Use Navigator to navigate to the second page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/signin_balls.png'),
              const Text(
                'Sign in.',
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
                hintText: 'Email',
                controller: emailController,
              ),
              const SizedBox(height: 15),
              TextFormField(
                obscureText: true,
                controller:
                    passwordController, // Assign the controller to the TextFormField
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(19),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Pallete.borderColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Pallete.gradient2,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "password",
                ),
              ),
              const SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator() // Show loading indicator
                  : GradientButton(
                      onPressed: loginUserNow,
                      text: 'signin',
                    ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: navigateToSecondPage,
                child: const Text(
                  'don\'t have account yet ? signup',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
