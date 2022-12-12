import 'package:restaurant/screens/menu_screen/menu_screen_view.dart';
import 'package:restaurant/screens/signup_screen/signup_screen_view.dart';
import 'package:restaurant/services/firebase_authentication_service.dart';
import 'package:restaurant/shared/shared_loading.dart';
import 'package:restaurant/shared/shared_snackbar.dart';
import 'package:restaurant/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SigninScreenView extends StatefulWidget {
  const SigninScreenView({Key? key}) : super(key: key);

  @override
  State<SigninScreenView> createState() => _SigninScreenViewState();
}

class _SigninScreenViewState extends State<SigninScreenView> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isObscureTextPassword = true;

  void changeIsObscureTextPassword() {
    setState(() {
      isObscureTextPassword = !isObscureTextPassword;
    });
  }

  void resetTextFields() {
    FocusManager.instance.primaryFocus?.unfocus();

    email.clear();
    password.clear();

    setState(() {
      isObscureTextPassword = true;
    });
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

    // If the firebase signin is true then navigate to home screen
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
                  "Sign In",
                  style: TextStyle(
                    fontSize: 26.sp,
                  ),
                ),
              ),
              SizedBox(height: 5.h),
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
              SizedBox(height: 3.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Don't have an account?",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16.sp,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreenView(),
                            ),
                          );

                          resetTextFields();
                        },
                      text: " Sign up",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h),
              ElevatedButton(
                onPressed: () => signIn(),
                child: Text(
                  "Sign in",
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
