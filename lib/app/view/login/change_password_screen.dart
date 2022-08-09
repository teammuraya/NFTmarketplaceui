import 'package:flutter/material.dart';
import 'package:screen_sizer/app/routes/app_routes.dart';
import 'package:screen_sizer/app/view/dialogs/custom_app_dialog.dart';
import 'package:screen_sizer/base/color_data.dart';
import 'package:screen_sizer/base/constant.dart';
import 'package:screen_sizer/base/resizer/fetch_pixels.dart';
import 'package:screen_sizer/base/widget_utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordScreen();
  }
}

class _ChangePasswordScreen extends State<ChangePasswordScreen> {
  void finish() {
    Constant.backToPrev(context);
  }

  TextEditingController newPassEditingController = TextEditingController();
  TextEditingController confirmPassEditingController = TextEditingController();
  ValueNotifier<bool> isShowPass = ValueNotifier(false);
  ValueNotifier<bool> isShowConfirmPass = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: FetchPixels.getDefaultHorSpace(context)),
            primary: true,
            scrollDirection: Axis.vertical,
            child: Stack(
              children: [
                buildWidgetBackButton(context),
                buildWidgetTitle(context),
                buildWidgetSubTitle(context),
                buildPassWidget(),
                buildConfirmPassWidget(),
                buildSubmitButton(context),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          finish();
          return false;
        });
  }

  Widget buildConfirmPassWidget() {
    return getPaddingWidget(
                  EdgeInsets.only(top: FetchPixels.getPixelHeight(303)),
                  ValueListenableBuilder(
                    builder: (context, value, child) {
                      return getPassTextFiled(
                          context,
                          "Confirm Password",
                          confirmPassEditingController,
                          getFontSkip(context),
                          isShowConfirmPass.value, () {
                        isShowConfirmPass.value = !isShowConfirmPass.value;
                      });
                    },
                    valueListenable: isShowConfirmPass,
                  ));
  }

  Widget buildPassWidget() {
    return getPaddingWidget(
                  EdgeInsets.only(top: FetchPixels.getPixelHeight(224)),
                  ValueListenableBuilder(
                    builder: (context, value, child) {
                      return getPassTextFiled(
                          context,
                          "Password",
                          newPassEditingController,
                          getFontSkip(context),
                          isShowPass.value, () {
                        isShowPass.value = !isShowPass.value;
                      });
                    },
                    valueListenable: isShowPass,
                  ));
  }

  Widget buildSubmitButton(BuildContext context) {
    return getPaddingWidget(
        EdgeInsets.only(top: FetchPixels.getPixelHeight(402)),
        getButton(context,getAccentColor(context), true, "Submit", Colors.white, () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomAppDialog(context, () {
                  Constant.sendToNext(context, Routes.loginRoute);
                }, "padlock.svg", "Password Changed",
                    "Your password has been successfully\nchanged!", "Ok");
              });
        }, EdgeInsets.zero));
  }

  Widget buildWidgetSubTitle(BuildContext context) {
    return getPaddingWidget(
        EdgeInsets.only(top: FetchPixels.getPixelHeight(160)),
        getCustomFont("Please enter new password for change your password.", 15,
            getFontColor(context), 2,
            fontWeight: FontWeight.w400));
  }

  Widget buildWidgetTitle(BuildContext context) {
    return getPaddingWidget(
        EdgeInsets.only(top: FetchPixels.getPixelHeight(121)),
        getCustomFont("Change Password", 22, getFontColor(context), 1,
            fontWeight: FontWeight.w600));
  }

  Widget buildWidgetBackButton(BuildContext context) {
    return getPaddingWidget(
        EdgeInsets.only(top: FetchPixels.getPixelHeight(67)),
        getBackIcon(context, finish));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
