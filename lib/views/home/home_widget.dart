// ignore_for_file: library_private_types_in_public_api
import 'package:boofapp/controllers/controllers.dart';
import 'package:boofapp/utils/functions.dart';
import 'package:boofapp/utils/constant_widgets.dart';
import 'package:boofapp/utils/constants.dart';
import 'package:boofapp/utils/my_colors.dart';
import 'package:boofapp/utils/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});
  @override
  _HomeWidget createState() => _HomeWidget();
}

class _HomeWidget extends State<HomeWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (profileController) => Container(
        height: double.infinity,
        width: double.infinity,
        color: bgDarkWhite,
        child: Column(
          children: [
            ConstantWidget.getVerSpace(20.h),
            Expanded(
              flex: 1,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                scrollDirection: Axis.vertical,
                primary: true,
                shrinkWrap: true,
                  children: [
                    ConstantWidget.getVerSpace(12.h),
                    getCustomText(
                      'User Information',
                      textColor, 1,
                      TextAlign.start,
                      FontWeight.w600,
                      24.sp
                    ),
                    ConstantWidget.getVerSpace(16.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.h,
                        vertical: 20.h
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: "#0F000000".toColor(),
                              blurRadius: 28,
                              offset: const Offset(0, 6)
                            )
                          ],
                          borderRadius: BorderRadius.circular(12.h)
                      ),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Material(
                              child: profileController.userDetail.image != '' ? CachedNetworkImage(
                                height: 80.h,
                                width: 80.h,
                                imageUrl: profileController.userDetail.image!,
                              ) : Image.asset(
                                "${Constants.assetsImagePath}profile_imge.png",
                                width: 80.h, 
                                height: 80.h
                              ),
                            ),
                          ),
                          ConstantWidget.getHorSpace(16.h),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              getCustomText(
                                profileController.userDetail.firstName != null ? '${profileController.userDetail.firstName}' : '',
                                textColor, 1,
                                TextAlign.start,
                                FontWeight.w500,
                                19.sp
                              ),
                              ConstantWidget.getVerSpace(4.h),
                              getCustomText(
                                profileController.userDetail.email != null ? '${profileController.userDetail.email}' : '',
                                descriptionColor, 1,
                                TextAlign.start,
                                FontWeight.w500,
                                17.sp
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    ConstantWidget.getVerSpace(20.h),
                    InkWell(
                      child: Container(
                          width: 200.w,
                          height: 58.h,
                          margin: const EdgeInsets.only(top: 25),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: "#0F000000".toColor(),
                                  blurRadius: 28,
                                  offset: const Offset(0, 6)
                              )
                            ]
                          ),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  const Spacer(),
                                  profileController.isSignIn ? const SizedBox() : Container(
                                    height: 24.0,
                                    width: 24.0,
                                    margin: EdgeInsets.only(right: 16.w),
                                    child: SvgPicture.asset(
                                      '${Constants.iconsImagePath}google.svg',
                                      height: 24,
                                      width: 24,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  getCustomText(
                                    profileController.isSignIn ? "Sign Out" : "SignIn with Google",
                                    descriptionColor, 1,
                                    TextAlign.center,
                                    FontWeight.normal,
                                    22.sp
                                  ),
                                  const Spacer(),
                                ],
                              )
                          )
                      ),
                      onTap: ()
                      async{
                        if (profileController.isSignIn) {
                          checkNetwork(context, profileController);
                        } else {
                          profileController.signInWithGoogle().then((value){
                            profileController.getLogInStatus();
                          }).catchError((e) {
                            if (kDebugMode) {
                              print(e);
                            }
                          });
                        }
                      },
                    ),
                    ConstantWidget.getVerSpace(60.h),
                  ]),
              ),
            ],
          )),
    );
  }

  checkNetwork(mContext, profileController) async {
    bool isNetwork = await Functions.getNetwork();
    if (isNetwork) {
      profileController.logOut().then((value) {
        Functions.showToast('Log out', mContext);
      });
    } else {
      getNoInternet(mContext);
    }
  }
}
