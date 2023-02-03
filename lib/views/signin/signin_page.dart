// ignore_for_file: library_private_types_in_public_api
import 'package:boofapp/utils/constant_widgets.dart';
import 'package:boofapp/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  @override
  _SignInPage createState() {
    return _SignInPage();
  }
}

class _SignInPage extends State<SignInPage> {
  final loginForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(bgDarkWhite);
    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: bgDarkWhite,
        body: Form(
          key: loginForm,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  children: [
                    SizedBox(
                      height: 80.h,
                    ),
                    ConstantWidget.getTextWidget("Login", textColor,
                        TextAlign.left, FontWeight.w700, 28.sp),
                    SizedBox(
                      height: 10.h,
                    ),
                    ConstantWidget.getTextWidget(
                      "Welcome back to our account!",
                      descriptionColor,
                      TextAlign.left,
                      FontWeight.w500,
                      15.sp
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            child: ConstantWidget.getTextWidget(
                              'Forgot Password ?',
                              textColor,
                              TextAlign.end,
                              FontWeight.w500,
                              17.sp
                            ),
                            onTap: () {

                            },
                          ),
                        ),
                      ],
                    ),
                    ConstantWidget.getVerSpace(40.h),
                  ],
                ),
              ),
              ConstantWidget.getVerSpace(36.h)
            ],
          ),
        ),
      ),
      onWillPop: () {
        Get.back();
        return Future.value(false);
      },
    );
  }
}
