// ignore_for_file: must_be_immutable
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';
import 'utils/my_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyB9WZh2J_d_gFfGXd9XVf3t0G9rviqM4mM",
        appId: "1:541006623269:web:1defcad2ac55df691a05cc",
        messagingSenderId: "541006623269",
        projectId: "boofapp-59572"
      )
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ThemeData themeData = ThemeData(
    primaryColor: primaryColor,
    hoverColor: Colors.transparent,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primaryColorDark: primaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: accentColor
    )
  );
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BoofApp',
      theme: themeData,
      initialRoute: AppPages.initialRoute,
      routes: AppPages.routes,
    );
  }
}
