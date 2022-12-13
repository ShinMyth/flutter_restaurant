import 'package:restaurant/screens/menu_screen/menu_screen_view.dart';
import 'package:restaurant/services/sqflite_database_service.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    // Navigate to menu screen after 2.5 seconds
    Future.delayed(const Duration(milliseconds: 2500), () async {
      // Setup the sqflite database
      await SqfliteDatabaseService().setupDatabase();

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
