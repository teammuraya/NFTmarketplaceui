import 'package:flutter/material.dart';
import 'package:screen_sizer/app/data/data_file.dart';
import 'package:screen_sizer/app/routes/app_routes.dart';
import 'package:screen_sizer/base/color_data.dart';
import 'package:screen_sizer/base/constant.dart';
import 'package:screen_sizer/base/resizer/fetch_pixels.dart';
import 'package:screen_sizer/base/widget_utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfileScreen();
  }
}

class _ProfileScreen extends State<ProfileScreen> {
  List<String> profileList = DataFile.getAllGalleryList();

  void backClick() {
    Constant.sendToNext(context, Routes.homeScreenRoute,
        arguments: {Constant.homePos: 4});
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    double horSpace = FetchPixels.getDefaultHorSpace(context);
    double iconSize = FetchPixels.getPixelHeight(24);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: horSpace);
    int crossAxisCountPopular = 2;
    double width = MediaQuery.of(context).size.width;
    double gridWidth = (width - (horSpace * 3)) / 2;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: getCurrentTheme(context).scaffoldBackgroundColor,
          appBar: getInVisibleAppBar(),
          extendBodyBehindAppBar: true,
          body: ListView(
            padding: EdgeInsets.zero,
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildProfileTopView(context),
              getVerSpace(FetchPixels.getPixelHeight(16)),
              buildTitleWidget(edgeInsets, context),
              getVerSpace(FetchPixels.getPixelHeight(5)),
              buildEmailWidget(edgeInsets, context),
              getVerSpace(FetchPixels.getPixelHeight(16)),
              buildBioWidget(edgeInsets, context),
              getVerSpace(FetchPixels.getPixelHeight(16)),
              buildSocialView(edgeInsets, context, iconSize),
              buildExpanded(horSpace, crossAxisCountPopular, gridWidth, context)
            ],
          ),
        ),
        onWillPop: () async {
          backClick();
          return false;
        });
  }

  Widget buildProfileTopView(BuildContext context) {
    return getProfileTopView(
      context,
      () {
        backClick();
      },
      "My Profile",
      visibleMore: true,
      moreFunc: () {
        showProfileDialog();
      },
    );
  }

  Widget buildTitleWidget(EdgeInsets edgeInsets, BuildContext context) {
    return getPaddingWidget(
        edgeInsets,
        getCustomFont("Shawn Muraya", 22, getFontColor(context), 1,
            fontWeight: FontWeight.w600));
  }

  Widget buildEmailWidget(EdgeInsets edgeInsets, BuildContext context) {
    return getPaddingWidget(
        edgeInsets,
        getCustomFont("@shawn_nova_", 15, getFontSkip(context), 1,
            fontWeight: FontWeight.w400));
  }

  Widget buildBioWidget(EdgeInsets edgeInsets, BuildContext context) {
    return getPaddingWidget(
        edgeInsets,
        getMultilineCustomFont(
            "NFT ledgers claim to provide a public certificate of authenticity.",
            15,
            getFontSkip(context),
            fontWeight: FontWeight.w400));
  }

  Widget buildSocialView(
      EdgeInsets edgeInsets, BuildContext context, double iconSize) {
    return getPaddingWidget(
        edgeInsets,
        Row(
          children: [
            getSvgImageWithSize(context, "insta.svg", iconSize, iconSize),
            getHorSpace(FetchPixels.getPixelWidth(16)),
            getSvgImageWithSize(context, "fb.svg", iconSize, iconSize),
            getHorSpace(FetchPixels.getPixelWidth(16)),
            getSvgImageWithSize(context, "twitter.svg", iconSize, iconSize)
          ],
        ));
  }

  GridView buildExpanded(double horSpace, int crossAxisCountPopular,
      double gridWidth, BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.symmetric(
          horizontal: horSpace / 2, vertical: horSpace / 2),
      crossAxisCount: crossAxisCountPopular,
      childAspectRatio: gridWidth / gridWidth,
      shrinkWrap: true,
      primary: false,
      children: List.generate(profileList.length, (index1) {
        return Center(
          child: SizedBox(
            width: gridWidth,
            height: gridWidth,
            child: getCircularImage(context, double.infinity, double.infinity,
                FetchPixels.getPixelHeight(12), profileList[index1]),
          ),
        );
      }),
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
                    Expanded(
                      child: ListView(
                        children: [
                          getVerSpace(FetchPixels.getPixelHeight(26)),
                          getSettingRow(context, "edit.svg", "Edit Profile",
                              () {
                            Constant.backToPrev(context);
                            Constant.sendToNext(
                                context, Routes.editProfileScreenRoute);
                          }),
                          getSettingRow(context, "Export.svg", "Share", () {}),
                          getSettingRow(
                              context, "Gallery.svg", "Replace Cover", () {}),
                          getSettingRow(
                              context, "User.svg", "Remove Cover", () {}),
                          getButton(context, Colors.transparent, true, "Cancel",
                              getAccentColor(context), () {
                            Constant.backToPrev(context);
                          },
                              EdgeInsets.symmetric(
                                  horizontal: horSpace,
                                  vertical: FetchPixels.getPixelHeight(10)),
                              isBorder: true,
                              borderColor: getAccentColor(context)),
                          getVerSpace(FetchPixels.getPixelHeight(20)),
                        ],
                      ),
                      flex: 1,
                    ),
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
}
