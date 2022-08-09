import 'dart:async';

import 'package:flutter/material.dart';
import 'package:screen_sizer/app/routes/app_routes.dart';
import 'package:screen_sizer/base/color_data.dart';
import 'package:screen_sizer/base/constant.dart';
import 'package:screen_sizer/base/pref_data.dart';
import 'package:screen_sizer/base/resizer/fetch_pixels.dart';
import 'package:screen_sizer/base/widget_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    PrefData.isLogIn().then((value) {
      Timer(
        const Duration(seconds: 0),
        () {
          (value)
              ? Constant.sendToNext(context, Routes.homeScreenRoute)
              : Constant.sendToNext(context, Routes.introRoute);
        },
      );
    });
  }

  void backClick() {
    Constant.backToPrev(context);
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          body: Container(
            color: purpleColor,
            child: Center(
              child: getCustomFont("NFT", 34, Colors.white, 1,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        onWillPop: () async {
          backClick();
          return false;
        });
  }
}
