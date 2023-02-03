import 'dart:convert';
import 'package:boofapp/models/userdetail_model.dart';
import 'package:boofapp/routes/app_routes.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'pref_data.dart';
import 'package:html/parser.dart';

class Functions {
  static String constPrefix = 'boofapp';
  static String paramUserId = "${constPrefix}_userId";
  static String paramFirstName = "${constPrefix}_firstName";
  static String paramLastName = "${constPrefix}_lastName";
  static String paramUserName = "${constPrefix}_username";
  static String paramEmail = "${constPrefix}_email";
  static String paramPassword = "${constPrefix}_password";
  static String paramMobile = "${constPrefix}_mobile";
  static String paramAge = "${constPrefix}_age";
  static String paramGender = "${constPrefix}_gender";
  static String paramImage = "${constPrefix}_image";
  static String paramAddress = "${constPrefix}_address";
  static String paramCity = "${constPrefix}_city";
  static String paramCountry = "${constPrefix}_country";
  static String paramState = "${constPrefix}_state";
  static String paramDescription = "${constPrefix}_description";
  static String paramOldPassword = "${constPrefix}_oldPassword";
  static String paramNewPassword = "${constPrefix}_newPassword";
  static String paramDeviceId = "${constPrefix}_deviceId";
  static String termsAndCondition = "https://www.google.com";

  static Future<bool> isLogin() async {
    return await PrefData.getIsSignIn();
  }

  static Future<String> getDeviceId() async {
    String? deviceId = "";
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }
    return deviceId!;
  }

  static Future<bool> getNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  static checkNullResponse(var response) {
    if (response == null) {
      return null;
    }
  }

  static Future<Map> getCommonParams() async {
    bool isSignIn = await PrefData.getIsSignIn();
    String uDetails = await PrefData.getUserDetail();
    String deviceId = await getDeviceId();

    if (isSignIn && uDetails.isNotEmpty) {
      Map<String, dynamic> userMap;
      userMap = jsonDecode(uDetails) as Map<String, dynamic>;
      final UserDetail user = UserDetail.fromJson(userMap);
      if (kDebugMode) {
        print(user);
      }
      return {
        Functions.paramUserId: user.userId,
        Functions.paramDeviceId: deviceId,
      };
    } else {
      if (kDebugMode) {
        print("isSignIN------$isSignIn");
      }
      return {
        Functions.paramUserId: '',
        Functions.paramDeviceId: '',
      };
    }
  }

  static getCallService(BuildContext context, {
    required String serviceName,
    Map? data,
    required Function function
  }) async {
    bool isNetwork = await getNetwork();
    if (isNetwork) {
      Map commonData = await getCommonParams();
      if (data != null) {
        commonData.addAll(data);
      }
      function(commonData);
      return commonData;
    } else {
      // ignore: use_build_context_synchronously
      Functions.showToast("Please turn on Internet", context);
      return null;
    }
  }

  static Future<UserDetail> getUserDetail() async {
    String uDetails = await PrefData.getUserDetail();
    if (kDebugMode) {
      print("service---1$uDetails");
    }
    if (uDetails.isNotEmpty) {
      Map<String, dynamic> userMap;
      userMap = jsonDecode(uDetails) as Map<String, dynamic>;
      final UserDetail user = UserDetail.fromJson(userMap);
      if (kDebugMode) {
        print(user);
        print("service---$user");
      }
      return user;
    } else {
      return UserDetail();
    }
  }

  static void sendLoginPage(BuildContext context, {
    Function? function,
    Function? returnPage
  }) {
    if (kDebugMode) {
      print("function-----$returnPage");
    }
    Navigator.pushNamed(context, Routes.signInRoute, arguments: returnPage)
    .then((value) {
      if (function != null) {
        function();
      }
    });
  }

  static showToast(String s, BuildContext context) {
    if (s.isNotEmpty) {
      Fluttertoast.showToast(
        msg: s,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12
      );
    }
  }
}
