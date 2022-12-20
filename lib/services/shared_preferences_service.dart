import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

class SharedPreferencesService {
  Future<void> initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();

    bool contains = prefs.containsKey("isSetMenuData");
    if (contains == false) {
      await prefs.setBool("isSetMenuData", false);
    }
  }
}
