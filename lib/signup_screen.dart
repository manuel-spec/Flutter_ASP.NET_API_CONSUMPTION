import 'package:flutter/material.dart';
import 'package:flutter_responsive_login_ui/api/signup_api.dart';
import 'package:flutter_responsive_login_ui/login_screen.dart';
import 'package:flutter_responsive_login_ui/pallete.dart';
import 'package:flutter_responsive_login_ui/verifyEmail/verify_email.dart';
import 'package:flutter_responsive_login_ui/widgets/gradient_button.dart';
import 'package:flutter_responsive_login_ui/widgets/login_field.dart';
import 'package:flutter_responsive_login_ui/widgets/social_button.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Import the second page

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void registerUser() async {
    setState(() {
      isLoading = true; // Set loading state to true when login starts
    });

    SignupApi signupApi = SignupApi();

    // Get values from controllers
    String email = emailController.text;
    String password = passwordController.text;
    String fullName = fullNameController.text;

    // Make API request
    var response = await signupApi.registerUser(fullName, email, password);

    setState(() {
      isLoading = false; // Set loading state to true when login starts
    });

    // Check the response
    if (response.statusCode == 200) {
      // Handle success
      print('Registration successful! Response: ${response.body}');
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const VerifyEmail()), // Replace SecondPage with your desired page
      );
    } else {
      Fluttertoast.showToast(
          msg: "A valid form is required ..!",
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 18);
      // Handle error
      print('Registration failed. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  void navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const LoginScreen()), // Replace SecondPage with your desired page
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
                'Sign up.',
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
                hintText: 'Fullname',
                controller: fullNameController,
              ),
              const SizedBox(
                height: 15,
              ),
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
                  ? CircularProgressIndicator()
                  : GradientButton(
                      onPressed: registerUser,
                      text: 'signup',
                    ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: navigateToLogin,
                child: const Text(
                  'already have an account ? Login',
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
