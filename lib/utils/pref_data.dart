import 'package:boofapp/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefData {
  static String signIn = "${Constants.packageName}_signIn";
  static String isFirstSignUp = "${Constants.packageName}_isFirstSignUp";
  static String userDetail = "${Constants.packageName}_userDetail";
  static String isImage = "${Constants.packageName}_isImage";

  static Future<SharedPreferences> getPrefInstance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  static setImage(String image) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(isImage, image);
  }

  static Future<String> getImage() async {
    SharedPreferences preferences = await getPrefInstance();
    String isImageAvailable = preferences.getString(isImage) ?? "";
    return isImageAvailable;
  }

  static setIsSignIn(bool isFav) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(signIn, isFav);
  }

  static getIsSignIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(signIn) ?? false;
  }

  static setFirstSignUp(bool firstSignup) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isFirstSignUp, firstSignup);
  }

  static getFirstSignUp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isFirstSignUp) ?? true;
  }

  static setUserDetail(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userDetail, s);
  }

  static getUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userDetail) ?? '';
  }
}
