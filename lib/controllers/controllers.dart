import 'dart:convert';

import 'package:boofapp/models/userdetail_model.dart';
import 'package:boofapp/utils/constants.dart';
import 'package:boofapp/utils/pref_data.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeController extends GetxController {
  RxInt index = 0.obs;
  RxInt progressIndex = 0.obs;

  onProgressChange(RxInt value) {
    progressIndex.value = value.value;
    update();
  }

  onChange(RxInt value) {
    index.value = value.value;
    update();
  }
}

class ProfileController extends GetxController {
  late DatabaseReference dbRef = FirebaseDatabase.instance.reference();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '541006623269-6adp24cphkne0bdku12au6anujhlpa3n.apps.googleusercontent.com',
  );

  UserDetail userDetail = UserDetail();
  bool isSignIn = false;

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNumberController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initUI();
    getLogInStatus();
    getUser();
  }

  initUI() {
    nameController.text = '';
    emailController.text = '';
    phoneNumberController.text = '';
  }

  getLogInStatus() async {
    isSignIn = await PrefData.getIsSignIn();
    if (kDebugMode) {
      print('isSignIn---->$isSignIn');
    }
    update();
  }

  getUser() async {
    String uDetails = await PrefData.getUserDetail();
    if (uDetails.isNotEmpty) {
      Map<String, dynamic> userMap;
      userMap = jsonDecode(uDetails) as Map<String, dynamic>;
      userDetail = UserDetail.fromJson(userMap);
      if (kDebugMode) {
        print(userDetail);
      }
      PrefData.setIsSignIn(true);
      PrefData.setUserDetail(json.encode(userDetail));
      getLogInStatus();
      update();
    }
  }

  Future<bool> signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    if(googleSignInAccount != null){
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential authResult = await _auth.signInWithCredential(credential);
      User? user = authResult.user;
      if(user!=null){
        userDetail = UserDetail();
        userDetail.userId = user.uid;
        userDetail.firstName = user.displayName;
        userDetail.email = user.email;
        userDetail.mobile = user.phoneNumber;
        userDetail.image = user.photoURL;

        dbRef.child('users').child('${userDetail.userId}').set(
            userDetail.toJson()
        );

        PrefData.setIsSignIn(true);
        PrefData.setUserDetail(json.encode(userDetail));
        getLogInStatus();
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }
  }

  Future<bool> logOut() async {
    await _googleSignIn.signOut();
    userDetail = UserDetail();
    PrefData.setIsSignIn(false);
    PrefData.setUserDetail("");
    getLogInStatus();
    return true;
  }

  Future<void> share() async {
    String share = "BooF \n${Constants.getAppLink()}";
    await FlutterShare.share(
      title: 'share',
      text: share,
    );
  }
}

class ForgotController extends GetxController {
  String code = "+27";
  String codeName = "ZA";

  @override
  void onInit() {
    super.onInit();
    initCode();
  }

  initCode() {
    code = "+27";
    codeName = "ZA";
  }

  changeCode(CountryCode value) {
    code = value.dialCode.toString();
    codeName = value.code.toString();
    update();
  }
}