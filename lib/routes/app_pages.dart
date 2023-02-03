import 'package:boofapp/views/home/home_page.dart';
import 'package:boofapp/views/profile/edit_profile.dart';
import 'package:boofapp/views/signin/signin_page.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';

class AppPages {
  static const initialRoute = Routes.homeRoute;
  static Map<String, WidgetBuilder> routes = {
    Routes.homeRoute: (context) => const HomePage(),
    Routes.signInRoute: (context) => const SignInPage(),
    Routes.editProfileRoute: (context) => const EditProfile(),
  };
}
