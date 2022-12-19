import 'package:restaurant/screens/cart_screen/cart_screen_controller.dart';
import 'package:restaurant/screens/menu_screen/menu_screen_controller.dart';
import 'package:restaurant/screens/signup_screen/signup_screen_controller.dart';
import 'package:restaurant/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignupScreenView extends StatefulWidget {
  const SignupScreenView({
    Key? key,
    required this.menuScreenController,
    this.cartScreenController,
  }) : super(key: key);

  final MenuScreenController menuScreenController;
  final CartScreenController? cartScreenController;

  @override
  State<SignupScreenView> createState() => _SignupScreenViewState();
}

class _SignupScreenViewState extends State<SignupScreenView> {
  late SignupScreenController controller;

  @override
  void initState() {
    controller = SignupScreenController(
      setstate: () => setState(() {}),
      context: context,
      menuScreenController: widget.menuScreenController,
      cartScreenController: widget.cartScreenController,
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
                      controller: controller.firstName,
                      obscureText: false,
                      hintText: "First Name",
                    ),
                  ),
                  SizedBox(
                    width: 40.w,
                    child: CustomTextField(
                      controller: controller.lastName,
                      obscureText: false,
                      hintText: "Last Name",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.5.h),
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
              SizedBox(height: 5.h),
              ElevatedButton(
                onPressed: () => controller.signUp(),
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
