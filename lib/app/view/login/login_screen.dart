import 'package:flutter/material.dart';
import 'package:screen_sizer/app/routes/app_routes.dart';
import 'package:screen_sizer/base/color_data.dart';
import 'package:screen_sizer/base/constant.dart';
import 'package:screen_sizer/base/pref_data.dart';
import 'package:screen_sizer/base/resizer/fetch_pixels.dart';

import '../../../base/widget_utils.dart';
import '../../../generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  ValueNotifier notifier = ValueNotifier(true);
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passController = TextEditingController();
  ValueNotifier<bool> isShowPass = ValueNotifier(false);
  bool chkVal = false;

  void finishView() {
    Constant.backToPrev(context);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        final arg = ModalRoute.of(context)!.settings.arguments as Map?;
        if (arg != null) {
          bool login = arg[Constant.fromLogin];
          notifier.value = login;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: getCurrentTheme(context).scaffoldBackgroundColor,
          appBar: getInVisibleAppBar(
              color: getCurrentTheme(context).scaffoldBackgroundColor),
          body: SingleChildScrollView(
            primary: true,
            padding: EdgeInsets.symmetric(
                horizontal: FetchPixels.getDefaultHorSpace(context)),
            scrollDirection: Axis.vertical,
            child: ValueListenableBuilder(
              valueListenable: notifier,
              builder: (context, value, child) {
                return Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    buildTitleWidget(context),
                    buildSubTitleWidget(context),
                    buildButtonSelectionWidget(context),
                    buildDetailView()
                  ],
                );
              },
            ),
          ),
        ),
        onWillPop: () async {
          finishView();
          return false;
        });
  }

  ValueListenableBuilder<dynamic> buildDetailView() {
    return ValueListenableBuilder(
      builder: (context, value, child) {
        return (notifier.value)
            ? buildLoginWidget(context)
            : buildSignUpWidget(context);
      },
      valueListenable: notifier,
    );
  }

  Widget buildButtonSelectionWidget(BuildContext context) {
    return getPaddingWidget(
        EdgeInsets.only(top: FetchPixels.getPixelHeight(202)),
        Container(
          height: FetchPixels.getPixelHeight(60),
          decoration: getButtonDecoration(
            getCurrentTheme(context).hoverColor,
            withBorder: false,
            withCorners: true,
            corner: FetchPixels.getPixelHeight(30),
          ),
          padding: EdgeInsets.all(FetchPixels.getPixelHeight(6)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: getButtonDecoration(
                    (notifier.value)
                        ? getCurrentTheme(context).selectedRowColor
                        : Colors.transparent,
                    withBorder: false,
                    withCorners: true,
                    // corner: 33
                    corner: FetchPixels.getPixelHeight(24),
                  ),
                  child: InkWell(
                    onTap: () {
                      notifier.value = true;
                    },
                    child: Center(
                      child: getCustomFont(
                          S.of(context).login,
                          15,
                          (notifier.value)
                              ? getFontColor(context)
                              : getCurrentTheme(context).disabledColor,
                          1,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: getButtonDecoration(
                    (!notifier.value)
                        ? getCurrentTheme(context).selectedRowColor
                        : Colors.transparent,
                    withBorder: false,
                    withCorners: true,
                    // corner: 33
                    corner: FetchPixels.getPixelHeight(24),
                  ),
                  child: InkWell(
                    onTap: () {
                      notifier.value = false;
                    },
                    child: Center(
                      child: getCustomFont(
                          "Sign Up",
                          15,
                          (!notifier.value)
                              ? getFontColor(context)
                              : getCurrentTheme(context).disabledColor,
                          1,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                flex: 1,
              ),
            ],
          ),
        ));
  }

  Widget buildSubTitleWidget(BuildContext context) {
    return getPaddingWidget(
        EdgeInsets.only(top: FetchPixels.getPixelHeight(150)),
        getCustomFont("Hello, welcome back to our marketplace.", 15,
            getFontColor(context), 1,
            textAlign: TextAlign.start, fontWeight: FontWeight.w400));
  }

  Widget buildTitleWidget(BuildContext context) {
    return getPaddingWidget(
        EdgeInsets.only(top: FetchPixels.getPixelHeight(111)),
        getCustomFont((notifier.value) ? "Login Account" : "Create an Account",
            22, getFontColor(context), 1,
            textAlign: TextAlign.start, fontWeight: FontWeight.w600));
  }

  Stack buildSignUpWidget(BuildContext context) {
    return Stack(
      children: [
        getPaddingWidget(
            EdgeInsets.only(top: FetchPixels.getPixelHeight(312)),
            getDefaultTextFiled(context, "Full name", fullNameController,
                getFontColor(context))),
        getPaddingWidget(
            EdgeInsets.only(top: FetchPixels.getPixelHeight(392)),
            getDefaultTextFiled(
                context, "Email", emailController, getFontColor(context))),
        getPaddingWidget(
            EdgeInsets.only(top: FetchPixels.getPixelHeight(471)),
            getDefaultCountryPickerTextFiled(context, "Mobile Number",
                mobileController, getFontColor(context))),
        getPaddingWidget(
            EdgeInsets.only(top: FetchPixels.getPixelHeight(550)),
            ValueListenableBuilder(
              builder: (context, value, child) {
                return getPassTextFiled(context, "Password", passController,
                    getFontColor(context), isShowPass.value, () {
                  isShowPass.value = !isShowPass.value;
                });
              },
              valueListenable: isShowPass,
            )),
        getPaddingWidget(
          EdgeInsets.only(top: FetchPixels.getPixelHeight(629)),
          Row(
            children: [
              SizedBox(
                height: FetchPixels.getPixelHeight(24),
                width: FetchPixels.getPixelHeight(24),
                child: Checkbox(
                  onChanged: (value) {
                    setState(() {
                      chkVal = value!;
                    });
                  },
                  value: chkVal,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  side: BorderSide(width: 0.5, color: greyFont),
                  activeColor: primaryColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              ),
              getHorSpace(FetchPixels.getPixelWidth(5)),
              getCustomFont("I accepted", 15, getFontColor(context), 1,
                  textAlign: TextAlign.start, fontWeight: FontWeight.w400),
              getCustomFont(
                  " Terms & Privacy Policy", 15, getAccentColor(context), 1,
                  textAlign: TextAlign.start, fontWeight: FontWeight.w400),
            ],
          ),
        ),
        getPaddingWidget(
            EdgeInsets.only(top: FetchPixels.getPixelHeight(703)),
            getButton(
                context, getAccentColor(context), true, "Sign Up", Colors.white,
                () {
              Constant.sendToNext(context, Routes.verifyCodeRoute);
            }, EdgeInsets.zero))
      ],
    );
  }

  Stack buildLoginWidget(BuildContext context) {
    return Stack(
      children: [
        getPaddingWidget(
            EdgeInsets.only(top: FetchPixels.getPixelHeight(302)),
            getDefaultTextFiled(
                context, "Email", emailController, getFontColor(context))),
        getPaddingWidget(
            EdgeInsets.only(top: FetchPixels.getPixelHeight(380)),
            ValueListenableBuilder(
              builder: (context, value, child) {
                return getPassTextFiled(context, "Password", passController,
                    getFontColor(context), isShowPass.value, () {
                  isShowPass.value = !isShowPass.value;
                });
              },
              valueListenable: isShowPass,
            )),
        getPaddingWidget(
            EdgeInsets.only(top: FetchPixels.getPixelHeight(460)),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  Constant.sendToNext(context, Routes.changePassRoute);
                },
                child: getCustomFont(
                    "Forgot Password?", 15, getFontSkip(context), 1,
                    fontWeight: FontWeight.w400, textAlign: TextAlign.end),
              ),
            )),
        getPaddingWidget(
            EdgeInsets.only(top: FetchPixels.getPixelHeight(568)),
            getButton(context, getAccentColor(context), true,
                S.of(context).login, Colors.white, () {
              PrefData.setLogIn(true);
              Constant.sendToNext(context, Routes.homeScreenRoute);
            }, EdgeInsets.zero)),
        getPaddingWidget(
            EdgeInsets.only(top: FetchPixels.getPixelHeight(668)),
            SizedBox(
              width: double.infinity,
              child: getCustomFont(
                  "Or sign in with", 15, getFontSkip(context), 1,
                  fontWeight: FontWeight.w400, textAlign: TextAlign.center),
            )),
        getPaddingWidget(
            EdgeInsets.only(top: FetchPixels.getPixelHeight(710)),
            SizedBox(
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: getButton(
                          context,
                          getCurrentTheme(context).hoverColor,
                          true,
                          "Google",
                          getFontColor(context),
                          () {},
                          EdgeInsets.zero,
                          isIcon: true,
                          icons: "google.svg"),
                      flex: 1,
                    ),
                    getHorSpace(FetchPixels.getDefaultHorSpace(context)),
                    Expanded(
                      child: getButton(
                          context,
                          getCurrentTheme(context).hoverColor,
                          true,
                          "Facebook",
                          getFontColor(context),
                          () {},
                          EdgeInsets.zero,
                          isIcon: true,
                          icons: "facebook.svg"),
                      flex: 1,
                    ),
                  ]),
            ))
      ],
    );
  }
}
