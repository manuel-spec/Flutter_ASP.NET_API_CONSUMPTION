import 'package:flutter/material.dart';
import 'package:flutter_responsive_login_ui/pallete.dart';

class LoginField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller; // Add controller as a parameter

  const LoginField({
    Key? key,
    required this.hintText,
    required this.controller, // Add this line
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 360,
      ),
      child: TextFormField(
        controller: controller, // Assign the controller to the TextFormField
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
          hintText: hintText,
        ),
      ),
    );
  }
}
