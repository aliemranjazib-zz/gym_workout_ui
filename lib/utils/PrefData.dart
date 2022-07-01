import 'package:shared_preferences/shared_preferences.dart';

class PrefData {


  static String defaultString = "feelit_";
  static String signIn = defaultString+"signIn";
  static String isIntro = defaultString+"isIntro";
  static String isFirstTime = defaultString+"isFirstTime";
  static String mode = defaultString+"mode";






  static setIsSignIn(bool isFav) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(signIn, isFav);
  }

  static getIsSignIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(signIn) ?? false;
  }

  static setIsIntro(bool isFav) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isIntro, isFav);
  }

  static getIsIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isIntro) ?? true;
  }
  static setIsFirstTime(bool isFav) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isFirstTime, isFav);
  }

  static getIsFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isFirstTime) ?? true;
  }

  // static setThemeMode(int isFav) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt(mode, isFav);
  // }
  //
  // static getThemeMode() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getInt(mode) ?? 1;
  // }


}
