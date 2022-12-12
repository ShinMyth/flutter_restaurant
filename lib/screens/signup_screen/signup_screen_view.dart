import 'package:restaurant/screens/menu_screen/menu_screen_view.dart';
import 'package:restaurant/services/firebase_authentication_service.dart';
import 'package:restaurant/shared/shared_loading.dart';
import 'package:restaurant/shared/shared_snackbar.dart';
import 'package:restaurant/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignupScreenView extends StatefulWidget {
  const SignupScreenView({Key? key}) : super(key: key);

  @override
  State<SignupScreenView> createState() => _SignupScreenViewState();
}

class _SignupScreenViewState extends State<SignupScreenView> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isObscureTextPassword = true;

  void changeIsObscureTextPassword() {
    setState(() {
      isObscureTextPassword = !isObscureTextPassword;
    });
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
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MenuScreenView(),
        ),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: appBar(context),
        body: Container(
          height: 100.h -
              (appBar(context).preferredSize.height +
                  MediaQuery.of(context).padding.top),
          width: 100.w,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100.w,
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 26.sp,
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 40.w,
                    child: CustomTextField(
                      controller: firstName,
                      obscureText: false,
                      hintText: "First Name",
                    ),
                  ),
                  SizedBox(
                    width: 40.w,
                    child: CustomTextField(
                      controller: lastName,
                      obscureText: false,
                      hintText: "Last Name",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.5.h),
              CustomTextField(
                controller: email,
                obscureText: false,
                hintText: "Email",
                suffixIcon: const Icon(Icons.email),
              ),
              SizedBox(height: 2.5.h),
              CustomTextField(
                controller: password,
                obscureText: isObscureTextPassword,
                hintText: "Password",
                suffixIcon: GestureDetector(
                  onTap: () => changeIsObscureTextPassword(),
                  child: Icon(
                    isObscureTextPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              ElevatedButton(
                onPressed: () => signUp(),
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  appBar(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.black54,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
