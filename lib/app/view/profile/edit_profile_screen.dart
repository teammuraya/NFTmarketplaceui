import 'package:flutter/material.dart';
import 'package:screen_sizer/base/color_data.dart';
import 'package:screen_sizer/base/constant.dart';
import 'package:screen_sizer/base/resizer/fetch_pixels.dart';
import 'package:screen_sizer/base/widget_utils.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditProfileScreen();
  }
}

class _EditProfileScreen extends State<EditProfileScreen> {
  void backClick() {
    Constant.backToPrev(context);
  }

  TextEditingController nameCont = TextEditingController(text: "Shawn Muraya");
  TextEditingController emailCont =
      TextEditingController(text: "ShawnMuraya@gmail.com");
  TextEditingController instaCont =
      TextEditingController(text: "https://www.instagram.com/");
  TextEditingController fbCont =
      TextEditingController(text: "https://www.facebook.com/");
  TextEditingController twitterCont =
      TextEditingController(text: "https://www.twitter.com/");

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    Widget verSpace = getVerSpace(FetchPixels.getPixelHeight(20));
    return WillPopScope(
        child: Scaffold(
          backgroundColor: getCurrentTheme(context).scaffoldBackgroundColor,
          appBar: getInVisibleAppBar(),
          extendBodyBehindAppBar: true,
          body: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            padding: EdgeInsets.zero,
            primary: true,
            shrinkWrap: true,
            children: [
              getProfileTopView(context, () {
                backClick();
              }, "Edit Profile", visibleMore: false, visibleEdit: true),
              getVerSpace(FetchPixels.getPixelHeight(16)),
              buildExpanded(context, verSpace)
            ],
          ),
        ),
        onWillPop: () async {
          backClick();
          return false;
        });
  }

  ListView buildExpanded(BuildContext context, Widget verSpace) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(
          horizontal: FetchPixels.getDefaultHorSpace(context)),
      primary: false,
      children: [
        getDefaultTextFiled(
          context,
          "Name",
          nameCont,
          getFontColor(context),
        ),
        verSpace,
        getDefaultTextFiled(
          context,
          "Email",
          emailCont,
          getFontColor(context),
        ),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        getCustomFont("Social Accounts", 15, getFontColor(context), 1,
            fontWeight: FontWeight.w600),
        verSpace,
        getDefaultTextFiled(
          context,
          "Instagram",
          instaCont,
          getFontColor(context),
        ),
        verSpace,
        getDefaultTextFiled(
          context,
          "Facebook",
          fbCont,
          getFontColor(context),
        ),
        verSpace,
        getDefaultTextFiled(
          context,
          "Twitter",
          twitterCont,
          getFontColor(context),
        ),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        getButton(context, getAccentColor(context), true, "Save", Colors.white,
            () {
          backClick();
        }, EdgeInsets.zero)
      ],
    );
  }

  showProfileDialog() {
    FetchPixels(context);
    double horSpace = FetchPixels.getPixelWidth(20);
    double radius = FetchPixels.getPixelHeight(40);

    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: getCurrentTheme(context).scaffoldBackgroundColor,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius))),
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return FractionallySizedBox(
                heightFactor: 0.58,
                child: Column(
                  children: [
                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    Center(child: getDialogDividerTop(context)),
                    buildExpandView(context, horSpace),
                    Center(
                      child: getDialogDividerBottom(context),
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(15))
                  ],
                ),
              );
            },
          );
        });
  }

  Expanded buildExpandView(BuildContext context, double horSpace) {
    return Expanded(
      child: ListView(
        children: [
          getVerSpace(FetchPixels.getPixelHeight(26)),
          getSettingRow(context, "edit.svg", "Edit Profile", () {}),
          getSettingRow(context, "Export.svg", "Share", () {}),
          getSettingRow(context, "Gallery.svg", "Replace Cover", () {}),
          getSettingRow(context, "User.svg", "Remove Cover", () {}),
          buildButton(context, horSpace),
          getVerSpace(FetchPixels.getPixelHeight(20)),
        ],
      ),
      flex: 1,
    );
  }

  Widget buildButton(BuildContext context, double horSpace) {
    return getButton(
        context, Colors.transparent, true, "Cancel", getAccentColor(context),
        () {
      Constant.backToPrev(context);
    },
        EdgeInsets.symmetric(
            horizontal: horSpace, vertical: FetchPixels.getPixelHeight(10)),
        isBorder: true,
        borderColor: getAccentColor(context));
  }
}
