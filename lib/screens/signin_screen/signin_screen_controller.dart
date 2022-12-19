import 'package:restaurant/screens/cart_screen/cart_screen_controller.dart';
import 'package:restaurant/screens/menu_screen/menu_screen_controller.dart';
import 'package:restaurant/services/firebase_authentication_service.dart';
import 'package:restaurant/shared/shared_loading.dart';
import 'package:restaurant/shared/shared_snackbar.dart';
import 'package:flutter/material.dart';

class SigninScreenController {
  final Function() setstate;
  final BuildContext context;
  final MenuScreenController menuScreenController;
  final CartScreenController? cartScreenController;

  SigninScreenController({
    required this.setstate,
    required this.context,
    required this.menuScreenController,
    this.cartScreenController,
  });

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isObscureTextPassword = true;

  void changeIsObscureTextPassword() {
    isObscureTextPassword = !isObscureTextPassword;

    setstate();
  }

  void resetTextFields() {
    FocusManager.instance.primaryFocus?.unfocus();

    email.clear();
    password.clear();

    isObscureTextPassword = true;

    setstate();
  }

  Future<void> signIn() async {
    FocusManager.instance.primaryFocus?.unfocus();

    // Checks if there is no input for email and password
    if (email.text.isEmpty || password.text.isEmpty) {
      showSharedSnackbar(
        title: "Invalid Input",
        message: "Please fill in all the fields.",
      );

      return;
    }

    showSharedLoading(context: context);

    // Calls firebase function for signin
    bool result = await FirebaseAuthenticationService().signIn(
      email: email.text,
      password: password.text,
    );

    Navigator.pop(context);

    // If the firebase signin is true then navigate to previous screen
    if (result) {
      Navigator.pop(context);
      menuScreenController.setstate();

      if (cartScreenController != null) {
        cartScreenController!.setstate();
      }
    }
  }
}
