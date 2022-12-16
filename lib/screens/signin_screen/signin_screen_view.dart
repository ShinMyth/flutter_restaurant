import 'package:restaurant/screens/menu_screen/menu_screen_controller.dart';
import 'package:restaurant/screens/signin_screen/signin_screen_controller.dart';
import 'package:restaurant/screens/signup_screen/signup_screen_view.dart';
import 'package:restaurant/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SigninScreenView extends StatefulWidget {
  const SigninScreenView({Key? key, required this.menuScreenController})
      : super(key: key);

  final MenuScreenController menuScreenController;

  @override
  State<SigninScreenView> createState() => _SigninScreenViewState();
}

class _SigninScreenViewState extends State<SigninScreenView> {
  late SigninScreenController controller;

  @override
  void initState() {
    controller = SigninScreenController(
      setstate: () => setState(() {}),
      context: context,
      menuScreenController: widget.menuScreenController,
    );
    super.initState();
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
                controller: controller.email,
                obscureText: false,
                hintText: "Email",
                suffixIcon: const Icon(Icons.email),
              ),
              SizedBox(height: 2.5.h),
              CustomTextField(
                controller: controller.password,
                obscureText: controller.isObscureTextPassword,
                hintText: "Password",
                suffixIcon: GestureDetector(
                  onTap: () => controller.changeIsObscureTextPassword(),
                  child: Icon(
                    controller.isObscureTextPassword
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
                              builder: (context) => SignupScreenView(
                                menuScreenController:
                                    widget.menuScreenController,
                              ),
                            ),
                          );

                          controller.resetTextFields();
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
                onPressed: () => controller.signIn(),
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
