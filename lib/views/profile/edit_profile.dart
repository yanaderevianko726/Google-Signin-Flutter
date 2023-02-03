import 'dart:io';
import 'package:boofapp/controllers/controllers.dart';
import 'package:boofapp/models/userdetail_model.dart';
import 'package:boofapp/utils/constant_widgets.dart';
import 'package:boofapp/utils/constants.dart';
import 'package:boofapp/utils/functions.dart';
import 'package:boofapp/utils/my_colors.dart';
import 'package:boofapp/utils/pref_data.dart';
import 'package:boofapp/utils/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  XFile? _image;
  String? imageUrl;
  int age = 0;
  String? state;
  String gender = "Male";
  String address = "";
  String city = "";
  String country = "";
  final editForm = GlobalKey<FormState>();

  RegExp emailExpress = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
  );

  Future<bool> _requestPop() {
    Get.back();
    return Future.value(false);
  }

  Future getImage(int type) async {
    XFile? pickedImage = await ImagePicker().pickImage(
      source: type == 1 ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 50
    );
    return pickedImage;
  }

  getProfileImage() {
    if (_image != null) {
      return Image.file(
        File(_image!.path),
        width: 100.h,
        height: 100.h,
      );
    } else if (imageUrl != null) {
      return Image.network(imageUrl!,
          width: 100.h, height: 100.h);
    } else {
      return Image.asset(
        "${Constants.assetsImagePath}profile_imge.png",
        width: 100.h, height: 100.h
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    String uDetails = await PrefData.getUserDetail();
    if (uDetails.isNotEmpty) {
      UserDetail userDetail = await Functions.getUserDetail();
      setState(() {
        age = int.parse(userDetail.age!);
        gender = userDetail.gender!;
        address = userDetail.address!;
        city = userDetail.city!;
        country = userDetail.country!;
        if (userDetail.state == null) {
          state = "";
        } else {
          state = userDetail.state!;
        }

        if (kDebugMode) {
          print("imageURl----${userDetail.gender}");
        }
        if (userDetail.image != null) {
          if (userDetail.image!.isNotEmpty) {
            imageUrl = userDetail.image;
          }
        }
        if (kDebugMode) {
          print("imageURl----${userDetail.image}");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Form(
        key: editForm,
        child: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (profileController) {
            return Scaffold(
              backgroundColor: bgDarkWhite,
              bottomNavigationBar: Container(
                padding: EdgeInsets.only(right: 20.h, bottom: 60.h, left: 20.h),
                child: getButton(context, accentColor, "Save", Colors.white, () {
                  if(editForm.currentState!.validate()){
                    checkNetwork(context);
                  }
                }, 20.sp,
                  weight: FontWeight.w700,
                  buttonHeight: 60.h,
                  borderRadius: BorderRadius.circular(22.h)
                ),
              ),
              body: SafeArea(
                child: ConstantWidget.getPaddingWidget(
                  EdgeInsets.symmetric(horizontal: 20.h),
                  Column(
                    children: [
                      ConstantWidget.getVerSpace(23.h),
                      buildAppBar(),
                      ConstantWidget.getVerSpace(50.h),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ClipOval(
                            child: Material(
                              child: getProfileImage(),
                            ),
                          ),
                          Positioned(
                            child: GestureDetector(
                              onTap: () async {
                                final tmpFile = await getImage(2);
                                setState(() {
                                  _image = tmpFile;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.h,
                                  vertical: 8.h
                                ),
                                height: 36.h,
                                width: 36.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50.h),
                                  boxShadow: [
                                    BoxShadow(
                                      color: containerShadow,
                                      blurRadius: 32,
                                      offset: const Offset(-2, 5)
                                    )
                                  ]
                                ),
                                child: getSvgImage("edit.svg"),
                              ),
                            )
                          )
                        ],
                      ),
                      ConstantWidget.getVerSpace(40.h),
                      ConstantWidget.getDefaultTextFiledWithLabel(
                        context, "Full Name", profileController.nameController,
                        isEnable: false,
                        height: 50.h,
                        withPrefix: true,
                        image: "profile.svg",
                        validator: (username) {
                          if (username == null || username.isEmpty) {
                            return "Please enter username.";
                          }
                          return null;
                        }
                      ),
                      ConstantWidget.getVerSpace(20.h),
                      ConstantWidget.getDefaultTextFiledWithLabel(
                        context, "Email", profileController.emailController,
                        isEnable: false,
                        height: 50.h,
                        withPrefix: true,
                        image: "mail.svg",
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return "Please enter email";
                          }
                          if (!emailExpress.hasMatch(email)) {
                            return "Please enter valid email.";
                          }
                          return null;
                        }
                      ),
                      ConstantWidget.getVerSpace(20.h),
                      ConstantWidget.getDefaultTextFiledWithLabel(
                        context, "Phone Number", profileController.phoneNumberController,
                        isEnable: false,
                        height: 50.h,
                        withPrefix: true,
                        image: "mail.svg", validator: (number) {
                          if (number == null || number.isEmpty) {
                            return "Please enter phone number.";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly]
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            _requestPop();
          },
          child: getSvgImage(
            "arrow_left.svg",
            height: 24.h,
            width: 24.h
          )
        ),
        ConstantWidget.getHorSpace(12.h),
        getCustomText(
          "Edit Profile",
          textColor, 1,
          TextAlign.start,
          FontWeight.w700, 22.sp
        )
      ],
    );
  }

  Future<void> checkNetwork(mContext) async {
    bool isNetwork = await Functions.getNetwork();
    if (!isNetwork) {
      getNoInternet(mContext);
    }
  }
}
