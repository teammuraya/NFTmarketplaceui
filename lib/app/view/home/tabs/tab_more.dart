import 'package:flutter/material.dart';
import 'package:screen_sizer/app/routes/app_routes.dart';
import 'package:screen_sizer/base/color_data.dart';
import 'package:screen_sizer/base/constant.dart';
import 'package:screen_sizer/base/pref_data.dart';
import 'package:screen_sizer/base/restart_controller.dart';
import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';

class TabMore extends StatefulWidget {
  const TabMore({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabMore();
  }
}

class _TabMore extends State<TabMore> {
  bool isDarkMode = false;

  @override
  void initState() {
    PrefData.getISDarkMode().then((value) {
      setState(() {
        isDarkMode = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double horSpace = FetchPixels.getDefaultHorSpace(context);

    return Column(
      children: [
        getVerSpace(FetchPixels.getPixelHeight(10)),
        topHeader(horSpace, "More", context, showProfile: false),
        getVerSpace(FetchPixels.getPixelHeight(27)),
        buildExpanded(context),
        buildButton(context),
        getVerSpace(FetchPixels.getPixelHeight(30))
      ],
    );
  }

  Widget buildButton(BuildContext context) {
    return getButton(
        context, getAccentColor(context), true, "Logout", Colors.white, () {
      PrefData.setLogIn(false);
      Constant.sendToNext(context, Routes.homeRoute);
    },
        EdgeInsets.symmetric(
            horizontal: FetchPixels.getPixelWidth(20),
            vertical: FetchPixels.getPixelHeight(10)));
  }

  Expanded buildExpanded(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        primary: true,
        children: [
          getSettingRow(context, "User.svg", "My Profile", () {
            Constant.sendToNext(context, Routes.profileScreenRoute);
          }),
          getSettingRow(context, "Bag.svg", "My Items", () {}),
          getSettingRow(context, "wallet_icon.svg", "Manage Funds", () {}),
          getSettingRow(context, "Play.svg", "Auto Play", () {}),
          getSettingRow(context, "Setting.svg", "Settings", () {}),
          getSettingRow(context, "Setting.svg", "Dark Theme", () {},
              withSwitch: true, onToggle: (boolVal) {
            setState(() {
              isDarkMode = boolVal;
            });
            PrefData.setDarkMode(boolVal);
            RestartController.rebirth(context);
          }, checked: isDarkMode)
        ],
      ),
      flex: 1,
    );
  }

  Widget getTitles(String string) {
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
        child: getCustomFont(string, 15, getFontColor(context), 1,
            fontWeight: FontWeight.w400));
  }
}
