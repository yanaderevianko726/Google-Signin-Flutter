import 'package:boofapp/controllers/controllers.dart';
import 'package:boofapp/utils/constant_widgets.dart';
import 'package:boofapp/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'home_widget.dart';

HomeController homeController = Get.put(HomeController());

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeWidget()
  ];

  @override
  void initState() {
    super.initState();
    setStatusBarColor(bgDarkWhite);
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    setStatusBarColor(bgDarkWhite);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Obx(() {
              return _widgetOptions[homeController.index.value];
            }),
          ),
          backgroundColor: bgDarkWhite,
        ),
        onWillPop: () async {
          if (homeController.index.value != 0) {
            homeController.onChange(0.obs);
          } else {
            Future.delayed(const Duration(milliseconds: 100), () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            });
          }
          return false;
        }
    );
  }
}
