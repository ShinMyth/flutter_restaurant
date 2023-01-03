import 'package:flutter/material.dart';
// import 'package:restaurant/data/menu_data.dart';
// import 'package:restaurant/services/shared_preferences_service.dart';
import 'package:restaurant/services/sqflite_database_service.dart';

class SplashScreenController {
  final BuildContext context;

  SplashScreenController({required this.context});

  Future<void> initializeSqfliteDatabase() async {
    await SqfliteDatabaseService().initializeSqfliteDatabase();
  }

  // Future<void> initializeSharedPreferences() async {
  //   await SharedPreferencesService().initializeSharedPreferences();

  //   if (prefs.getBool("isSetMenuData") == false) {
  //     MenuData menuData = MenuData(context: context);
  //     await menuData.setMenuData();
  //   }
  // }
}
