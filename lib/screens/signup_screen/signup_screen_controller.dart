import 'package:restaurant/screens/menu_screen/menu_screen_controller.dart';
import 'package:restaurant/services/firebase_authentication_service.dart';
import 'package:restaurant/shared/shared_loading.dart';
import 'package:restaurant/shared/shared_snackbar.dart';
import 'package:flutter/material.dart';

class SignupScreenController {
  final Function() setstate;
  final BuildContext context;
  final MenuScreenController menuScreenController;

  SignupScreenController({
    required this.setstate,
    required this.context,
    required this.menuScreenController,
  });

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isObscureTextPassword = true;

  void changeIsObscureTextPassword() {
    isObscureTextPassword = !isObscureTextPassword;

    setstate();
  }

  Future<void> signUp() async {
    FocusManager.instance.primaryFocus?.unfocus();

    // Checks if there is no input for firstName, lastName, email and password
    if (firstName.text.isEmpty ||
        lastName.text.isEmpty ||
        email.text.isEmpty ||
        password.text.isEmpty) {
      showSharedSnackbar(
        title: "Invalid Input",
        message: "Please fill in all the fields.",
      );

      return;
    }

    showSharedLoading(context: context);

    // Calls firebase function for signup
    bool result = await FirebaseAuthenticationService().signUp(
      email: email.text,
      password: password.text,
    );

    // If the firebase signup is true then update display name
    if (result) {
      await FirebaseAuthenticationService().updateDisplayName(
        firstName: firstName.text,
        lastName: lastName.text,
      );
    }

    Navigator.pop(context);

    // If the firebase signup is true then navigate to home screen
    if (result) {
      Navigator.pop(context);
      Navigator.pop(context);
      menuScreenController.setstate();
    }
  }
}
