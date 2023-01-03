import 'package:restaurant/screens/menu_screen/menu_screen_view.dart';
import 'package:restaurant/screens/splash_screen/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  late SplashScreenController controller;

  @override
  void initState() {
    controller = SplashScreenController(context: context);

    // Navigate to menu screen after 2.5 seconds
    Future.delayed(const Duration(milliseconds: 2500), () async {
      await controller.initializeSqfliteDatabase();
      // await controller.initializeSharedPreferences();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MenuScreenView(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 35.w,
          width: 35.w,
          child: Image.asset("assets/images/flutter-logo-with-label.png"),
        ),
      ),
    );
  }
}
