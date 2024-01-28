import 'package:flutter/material.dart';
import 'package:flutter_responsive_login_ui/login_screen.dart'; // Import the LoginScreen

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  void navigateToLoginScreen() {
    // Use Navigator to navigate to the LoginScreen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
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
              const SizedBox(
                height: 300,
              ),
              const Center(
                  child: Text(
                'Check your email.',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.purple),
              )),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: navigateToLoginScreen,
                child: const Text(
                  'Login now',
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
