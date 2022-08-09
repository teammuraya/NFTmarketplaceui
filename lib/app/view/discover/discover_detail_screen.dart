import 'package:flutter/material.dart';
import 'package:screen_sizer/base/color_data.dart';
import 'package:screen_sizer/base/constant.dart';
import 'package:screen_sizer/base/resizer/fetch_pixels.dart';
import 'package:screen_sizer/base/widget_utils.dart';

class DiscoverDetailScreen extends StatefulWidget {
  const DiscoverDetailScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DiscoverDetailScreen();
  }
}

class _DiscoverDetailScreen extends State<DiscoverDetailScreen> {
  backClick() {
    Constant.backToPrev(context);
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    double horPadding = FetchPixels.getDefaultHorSpace(context);
    double verPadding = FetchPixels.getPixelHeight(20);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: horPadding);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: getCurrentTheme(context).scaffoldBackgroundColor,
          appBar: getInVisibleAppBar(),
          body: Column(
            children: [
              getVerSpace(FetchPixels.getPixelHeight(18)),
              buildCenterTitleHeader(context, edgeInsets),
              buildExpanded(horPadding, verPadding, context)
            ],
          ),
        ),
        onWillPop: () async {
          backClick();
          return false;
        });
  }

  Widget buildCenterTitleHeader(BuildContext context, EdgeInsets edgeInsets) {
    return getCenterTitleHeader(context, "Detail", edgeInsets, () {
      backClick();
    }, visibleMore: true, moreFunc: () {});
  }

  List<String> profileList = [
    "rizz.png",
    "Profile2.png",
    "Profile11.png",
    "Profile22.png",
    "Profile.png"
  ];

  Expanded buildExpanded(
      double horPadding, double verPadding, BuildContext context) {
    return Expanded(
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: horPadding, vertical: verPadding),
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: FetchPixels.getPixelWidth(14),
            vertical: FetchPixels.getPixelHeight(14)),
        decoration: getButtonDecoration(
            getCurrentTheme(context).dialogBackgroundColor,
            withBorder: false,
            withCorners: true,
            corner: getButtonCorners(),
            shadow: [
              BoxShadow(
                  color: getCurrentTheme(context).shadowColor,
                  offset: const Offset(-5, 6),
                  blurRadius: 40)
            ]),
        child: ListView(
          padding: EdgeInsets.zero,
          primary: true,
          shrinkWrap: true,
          children: [
            getCircularImage(
                context,
                double.infinity,
                FetchPixels.getPixelHeight(267),
                getButtonCorners(),
                "discover1.png",
                boxFit: BoxFit.cover),
            getVerSpace(verPadding),
            getCustomFont("Kenyan Mindset", 20, getFontBlackColor(context), 1,
                fontWeight: FontWeight.w600),
            getVerSpace(FetchPixels.getPixelHeight(10)),
            getMultilineCustomFont(
                "50% of the primary market sale earnings Will be awarded to Anti-Coruption ward.",
                15,
                getFontBlackColor(context),
                fontWeight: FontWeight.w400),
            getVerSpace(FetchPixels.getPixelHeight(16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: getCustomFont(
                      "Highest bid", 16, getFontSkip(context), 1,
                      fontWeight: FontWeight.w400),
                  flex: 1,
                ),
                getCustomFont("Ends in", 16, getFontSkip(context), 1,
                    fontWeight: FontWeight.w400)
              ],
            ),
            getVerSpace(FetchPixels.getPixelHeight(7)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getSvgImageWithSize(
                    context,
                    "arrow_up_down.svg",
                    FetchPixels.getPixelHeight(15),
                    FetchPixels.getPixelHeight(24),
                    color: getFontColor(context)),
                getHorSpace(FetchPixels.getPixelWidth(8)),
                Expanded(
                  child: getCustomFont("20.02 ${Constant.getCurrency(context)}",
                      16, getFontColor(context), 1,
                      fontWeight: FontWeight.w600),
                  flex: 1,
                ),
                getCustomFont("KSH 155,000 ${Constant.getCurrency(context)}",
                    16, getFontColor(context), 1,
                    fontWeight: FontWeight.w600)
              ],
            ),
            getVerSpace(FetchPixels.getPixelHeight(23)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getCircleImage(context, "profile_discover2.png",
                    FetchPixels.getPixelHeight(44)),
                getHorSpace(FetchPixels.getPixelWidth(8)),
                Expanded(
                  child: getCustomFont(
                      "Bonniface Mwangi", 15, getFontSkip(context), 1,
                      fontWeight: FontWeight.w600),
                  flex: 1,
                ),
                getSvgImageWithSize(
                    context,
                    "Heart.svg",
                    FetchPixels.getPixelHeight(16),
                    FetchPixels.getPixelHeight(16)),
                getHorSpace(FetchPixels.getPixelWidth(8)),
                getCustomFont("1256", 15, getFontSkip(context), 1,
                    fontWeight: FontWeight.w400)
              ],
            ),
            getVerSpace(FetchPixels.getPixelHeight(19)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: getSubButton(context, getCardColor(context), true,
                      "History", purpleColor, () {}, EdgeInsets.zero),
                  flex: 1,
                ),
                getHorSpace(FetchPixels.getPixelWidth(14)),
                Expanded(
                  child: getSubButton(context, getCardColor(context), true,
                      "Details", purpleColor, () {}, EdgeInsets.zero),
                  flex: 1,
                ),
                getHorSpace(FetchPixels.getPixelWidth(14)),
                Expanded(
                  child: getSubButton(context, getCardColor(context), true,
                      "Top bids", purpleColor, () {}, EdgeInsets.zero),
                  flex: 1,
                )
              ],
            ),
            getVerSpace(FetchPixels.getPixelHeight(20)),
            Divider(
              height: FetchPixels.getPixelHeight(1),
              color: getCurrentTheme(context).focusColor,
            ),
            getVerSpace(FetchPixels.getPixelHeight(20)),
            getCustomFont("Bids", 16, getFontColor(context), 1,
                fontWeight: FontWeight.w600),
            ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: FetchPixels.getPixelHeight(74),
                  padding: EdgeInsets.symmetric(
                      horizontal: FetchPixels.getPixelWidth(12)),
                  margin: EdgeInsets.symmetric(
                      vertical: FetchPixels.getPixelHeight(6)),
                  decoration: getButtonDecoration(
                      getCurrentTheme(context).canvasColor,
                      corner: getButtonCorners(),
                      withBorder: false,
                      withCorners: true),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      getCircleImage(context, profileList[index],
                          FetchPixels.getPixelHeight(50)),
                      getHorSpace(FetchPixels.getPixelWidth(10)),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                getCustomFont(
                                    "Rizz Jiwani", 15, getFontColor(context), 1,
                                    fontWeight: FontWeight.w600),
                                getHorSpace(FetchPixels.getPixelWidth(5)),
                                getSvgImageWithSize(
                                  context,
                                  "tick.svg",
                                  FetchPixels.getPixelHeight(16),
                                  FetchPixels.getPixelHeight(16),
                                ),
                                Expanded(child: getHorSpace(0), flex: 1),
                                getCustomFont(
                                    "Winning Bid",
                                    FetchPixels.getPixelHeight(15),
                                    getFontColor(context),
                                    1,
                                    fontWeight: FontWeight.w400)
                              ],
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(7)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: getCustomFont(
                                      "20.2 ETH",
                                      FetchPixels.getPixelHeight(15),
                                      getFontColor(context),
                                      1,
                                      fontWeight: FontWeight.w400),
                                  flex: 1,
                                ),
                                getCustomFont(
                                    "9 Jul 2021, 11:50 PM",
                                    FetchPixels.getPixelHeight(15),
                                    getFontColor(context),
                                    1,
                                    fontWeight: FontWeight.w400)
                              ],
                            ),
                          ],
                        ),
                        flex: 1,
                      )
                    ],
                  ),
                );
              },
              itemCount: profileList.length,
              primary: false,
              shrinkWrap: true,
            ),
            getVerSpace(FetchPixels.getPixelHeight(12)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: getButton(
                      context,
                      Colors.transparent,
                      true,
                      "Purchase",
                      getAccentColor(context),
                      () {},
                      const EdgeInsets.only(left: 1),
                      isBorder: true,
                      borderColor: getAccentColor(context)),
                  flex: 1,
                ),
                getHorSpace(FetchPixels.getPixelWidth(20)),
                Expanded(
                  child: getButton(
                      context,
                      getAccentColor(context),
                      true,
                      "Place Bid",
                      Colors.white,
                      () {},
                      const EdgeInsets.only(right: 1)),
                  flex: 1,
                ),
              ],
            ),
            getVerSpace(FetchPixels.getPixelHeight(14)),
          ],
        ),
      ),
      flex: 1,
    );
  }
}
