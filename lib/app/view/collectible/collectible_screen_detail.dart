import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:screen_sizer/app/data/data_file.dart';
import 'package:screen_sizer/app/routes/app_routes.dart';
import 'package:screen_sizer/base/resizer/fetch_pixels.dart';

import '../../../base/Constant.dart';
import '../../../base/color_data.dart';
import '../../../base/widget_utils.dart';

class CollectibleDetailScreen extends StatefulWidget {
  const CollectibleDetailScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CollectibleDetailScreen();
  }
}

class _CollectibleDetailScreen extends State<CollectibleDetailScreen> {
  void backClick() {
    Constant.backToPrev(context);
  }

  List<String> collectionList = DataFile.getAllCollectionListList();
  List<String> priceList = ["Fixed Price", "Live Auction"];
  TextEditingController labelCont = TextEditingController();
  TextEditingController descCont = TextEditingController();
  int selectedPos = 0;
  bool status1 = false;
  bool status2 = false;

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: getCurrentTheme(context).scaffoldBackgroundColor,
          appBar: getInVisibleAppBar(),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: FetchPixels.getDefaultHorSpace(context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getVerSpace(FetchPixels.getPixelHeight(15)),
                getCenterTitleHeader(
                    context, "New Collectible", EdgeInsets.zero, () {
                  backClick();
                }),
                getVerSpace(FetchPixels.getPixelHeight(40)),
                buildRow(context),
                getVerSpace(FetchPixels.getPixelHeight(8)),
                getCustomFont("Describe your item", 13, getFontSkip(context), 1,
                    fontWeight: FontWeight.w400),
                getVerSpace(FetchPixels.getPixelHeight(22)),
                buildExpanded(context),
                buildButton(context)
              ],
            ),
          ),
        ),
        onWillPop: () async {
          backClick();
          return false;
        });
  }

  Widget buildButton(BuildContext context) {
    return getButton(
        context,
        // "#E3E6EE".toColor(),
        getAccentColor(context),
        true,
        "Save",
        Colors.white, () {
      Constant.sendToNext(context, Routes.profileScreenRoute);
    }, EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(15)));
  }

  List<String> spinnerItems = ['1 ETH', '2 ETH', '3 ETH', '4 ETH', '5 ETH'];
  List<String> spinnerItems2 = ['10%','20%','30%'];

  String dropdownValue = "1 ETH";
  String dropdownValue1 = "10%";

  Expanded buildExpanded(BuildContext context) {
    return Expanded(
      child: ListView(
          children: [
            getDefaultTextFiled(
                context, "Label", labelCont, getFontSkip(context)),
            getVerSpace(FetchPixels.getPixelHeight(20)),
            getDefaultTextFiled(
              context,
              "Description...",
              descCont,
              getFontSkip(context),
              minLines: true,
            ),
            getVerSpace(FetchPixels.getPixelHeight(20)),
            SizedBox(
              height: getButtonHeight(),
              child: Row(
                children: [
                  // Expanded(
                  //   child: Container(
                  //     decoration: getButtonDecoration(
                  //       Colors.transparent,
                  //       withCorners: true,
                  //       corner: getButtonCorners(),
                  //       withBorder: true,
                  //       borderColor: getCurrentTheme(context).focusColor,
                  //     ),
                  //     child: getButtonWithEndIcon(
                  //         context,
                  //         Colors.transparent,
                  //         true,
                  //         "1 ETH",
                  //         getFontColor(context),
                  //         () {},
                  //         EdgeInsets.zero,
                  //         isBorder: true,
                  //         borderColor: getCurrentTheme(context).focusColor,
                  //         isIcon: true,
                  //         icons: "currency_icon.svg"),
                  //   ),
                  //   flex: 1,
                  // ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: FetchPixels.getPixelWidth(10),
                      ),
                      height: double.infinity,
                      decoration: getButtonDecoration(
                        Colors.transparent,
                        withCorners: true,
                        corner: getButtonCorners(),
                        withBorder: true,
                        borderColor: getCurrentTheme(context).focusColor,
                      ),
                      child: getMediaQueryWidget(
                          context,
                          Center(
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              isDense: true,
                              isExpanded: true,

                              alignment: Alignment.center,
                              focusColor: Colors.transparent,
                              icon: getSvgImage(context, "currency_icon.svg",
                                  getEditIconSize()),
                              // iconSize: 24,
                              // elevation: 16,
                              style: TextStyle(
                                  fontFamily: Constant.fontsFamily,
                                  color: getFontHint(context),
                                  fontWeight: FontWeight.w400,
                                  fontSize: getEditFontSize()),
                              // style: TextStyle(color: Colors.red, fontSize: 18,),
                              underline: getVerSpace(0),
                              // underline: Container(
                              //   height: 2,
                              //   color: Colors.deepPurpleAccent,
                              // ),
                              onChanged: (String? data) {
                                setState(() {
                                  dropdownValue = data!;
                                });
                              },
                              items: spinnerItems
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          )),
                    ),
                    // getButtonWithEndIcon(
                    //     context,
                    //     Colors.transparent,
                    //     true,
                    //     "10%",
                    //     getFontColor(context),
                    //     () {},
                    //     EdgeInsets.zero,
                    //     isBorder: true,
                    //     borderColor:
                    //         getCurrentTheme(context).focusColor,
                    //     isIcon: true,
                    //     icons: "arrow_bottom.svg"),
                    flex: 1,
                  ),
                  getHorSpace(FetchPixels.getPixelWidth(20)),

                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: FetchPixels.getPixelWidth(10),
                      ),
                      height: double.infinity,
                      decoration: getButtonDecoration(
                        Colors.transparent,
                        withCorners: true,
                        corner: getButtonCorners(),
                        withBorder: true,
                        borderColor: getCurrentTheme(context).focusColor,
                      ),
                      child: getMediaQueryWidget(
                          context,
                          Center(
                            child: DropdownButton<String>(
                              value: dropdownValue1,
                              isDense: true,
                              isExpanded: true,

                              alignment: Alignment.center,
                              focusColor: Colors.transparent,
                              icon: getSvgImage(context, "arrow_bottom.svg",
                                  getEditIconSize()),
                              // iconSize: 24,
                              // elevation: 16,
                              style: TextStyle(
                                  fontFamily: Constant.fontsFamily,
                                  color: getFontHint(context),
                                  fontWeight: FontWeight.w400,
                                  fontSize: getEditFontSize()),
                              // style: TextStyle(color: Colors.red, fontSize: 18,),
                              underline: getVerSpace(0),
                              // underline: Container(
                              //   height: 2,
                              //   color: Colors.deepPurpleAccent,
                              // ),
                              onChanged: (String? data) {
                                setState(() {
                                  dropdownValue1 = data!;
                                });
                              },
                              items: spinnerItems2
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          )),
                    ),
                    // getButtonWithEndIcon(
                    //     context,
                    //     Colors.transparent,
                    //     true,
                    //     "10%",
                    //     getFontColor(context),
                    //     () {},
                    //     EdgeInsets.zero,
                    //     isBorder: true,
                    //     borderColor:
                    //         getCurrentTheme(context).focusColor,
                    //     isIcon: true,
                    //     icons: "arrow_bottom.svg"),
                    flex: 1,
                  )
                ],
              ),
            ),
            getVerSpace(FetchPixels.getPixelHeight(30)),
            SizedBox(
              height: FetchPixels.getPixelHeight(52),
              child: ListView.builder(
                itemCount: priceList.length,
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    height: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: FetchPixels.getPixelWidth(19)),
                    decoration: getButtonDecoration(
                        (selectedPos == index)
                            ? getCardColor(context)
                            : Colors.transparent,
                        withCorners: true,
                        corner: getButtonCorners()),
                    child: Center(
                      child: getCustomFont(
                          priceList[index], 16, getFontColor(context), 1,
                          fontWeight: FontWeight.w600),
                    ),
                  );
                },
              ),
            ),
            getVerSpace(FetchPixels.getPixelHeight(30)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      getCustomFont(
                          "Unlock once purchased", 16, getFontColor(context), 1,
                          fontWeight: FontWeight.w600),
                      getVerSpace(FetchPixels.getPixelHeight(8)),
                      getMultilineCustomFont(
                          "Content will be unlocked after successful\ntransaction",
                          13,
                          getFontColor(context),
                          fontWeight: FontWeight.w400,
                          txtHeight: 1.46)
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  flex: 1,
                ),
                getHorSpace(FetchPixels.getPixelWidth(50)),
                FlutterSwitch(
                  value: status1,
                  padding: 0.5,
                  inactiveColor: getCardColor(context),
                  inactiveToggleColor: purpleColor,
                  activeColor: getAccentColor(context),
                  width: FetchPixels.getPixelHeight(61),
                  height: FetchPixels.getPixelHeight(35),
                  onToggle: (val) {
                    setState(() {
                      status1 = val;
                    });
                  },
                )
              ],
            ),
            getVerSpace(FetchPixels.getPixelHeight(20)),
            Divider(
              height: FetchPixels.getPixelHeight(1),
              color: getCardColor(context),
            ),
            getVerSpace(FetchPixels.getPixelHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      getCustomFont("Put on sale", 16, getFontColor(context), 1,
                          fontWeight: FontWeight.w600),
                      getVerSpace(FetchPixels.getPixelHeight(8)),
                      getMultilineCustomFont("You'll receive bids on this item",
                          13, getFontColor(context),
                          fontWeight: FontWeight.w400, txtHeight: 1.46)
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  flex: 1,
                ),
                getHorSpace(FetchPixels.getPixelWidth(50)),
                FlutterSwitch(
                  value: status2,
                  padding: 0.5,
                  inactiveColor: getCardColor(context),
                  inactiveToggleColor: purpleColor,
                  activeColor: getAccentColor(context),
                  width: FetchPixels.getPixelHeight(61),
                  height: FetchPixels.getPixelHeight(35),
                  onToggle: (val) {
                    setState(() {
                      status2 = val;
                    });
                  },
                )
              ],
            ),
            getVerSpace(FetchPixels.getPixelHeight(20)),
          ],
          shrinkWrap: true,
          primary: true,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical),
      flex: 1,
    );
  }

  Row buildRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: FetchPixels.getPixelHeight(30),
          height: FetchPixels.getPixelHeight(30),
          decoration: BoxDecoration(shape: BoxShape.circle, color: purpleColor),
          child: Center(
            child: getCustomFont("2", 16, Colors.white, 1,
                fontWeight: FontWeight.w600),
          ),
        ),
        getHorSpace(FetchPixels.getPixelWidth(8)),
        Expanded(
          child: getCustomFont("Item Details", 15, getFontColor(context), 1,
              fontWeight: FontWeight.w600),
          flex: 1,
        )
      ],
    );
  }
}
