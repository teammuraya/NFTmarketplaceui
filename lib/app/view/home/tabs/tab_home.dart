import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screen_sizer/app/data/data_file.dart';
import 'package:screen_sizer/app/models/model_steps.dart';
import 'package:screen_sizer/app/models/model_trending.dart';
import 'package:screen_sizer/app/routes/app_routes.dart';
import 'package:screen_sizer/app/view/dialogs/transaction_dialog.dart';
import 'package:screen_sizer/base/color_data.dart';
import 'package:screen_sizer/base/constant.dart';
import 'package:screen_sizer/widgets/device_util.dart';
import 'package:screen_sizer/base/resizer/fetch_pixels.dart';
import 'package:screen_sizer/base/widget_utils.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../../models/model_creator.dart';
import '../../../models/model_steps_color.dart';
import '../../../notifier/dark_mode.dart';
import '../../dialogs/custom_app_dialog.dart';

class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabHome();
  }
}

class _TabHome extends State<TabHome> {
  getHomeTitle(String txt) {
    return getCustomFont(txt, 20, getFontColor(context), 1,
        fontWeight: FontWeight.w600);
  }

  getViewAllTitle(Function function) {
    return InkWell(
      onTap: () {
        function();
      },
      child: getCustomFont("View All", 13, getFontSkip(context), 1,
          fontWeight: FontWeight.w600),
    );
  }

  List<ModelTrending> trendingList = DataFile.getTrendingList();
  List<ModelCreator> creatorList = DataFile.getCreatorsList();
  List<ModelTrending> topCollection = DataFile.getTopCollection();

  @override
  Widget build(BuildContext context) {
    double horSpace = FetchPixels.getDefaultHorSpace(context);
    double verSpace = FetchPixels.getPixelHeight(20);
    Widget horWidget = getHorSpace(horSpace);
    int minVal = 3;
    if (kIsWeb) {
      minVal = 8;
    } else if (DeviceUtil.isTablet) {
      minVal = 6;
    }
    return ListView(
      primary: true,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        getVerSpace(FetchPixels.getPixelHeight(10)),
        topHeader(horWidget, context),
        getVerSpace(verSpace),
        buildRow(horWidget, context),
        widgetTrendingList(verSpace, minVal, horSpace),
        buildDefaultTitles1(horWidget, context),
        widgetCreatorList(verSpace, minVal, horSpace),
        buildDefaultTitles2(horWidget, context),
        widgetTopCollectionList()
      ],
    );
  }

  buildDefaultTitles2(Widget horWidget, BuildContext context) {
    return getDefaultTitles(horWidget, "Top Collections", () {
      Constant.sendToNext(context, Routes.topCollectionListScreenRoute);
    });
  }

  buildDefaultTitles1(Widget horWidget, BuildContext context) {
    return getDefaultTitles(horWidget, "Popular Creators", () {
      Constant.sendToNext(context, Routes.creatorListScreenRoute);
    });
  }

  Row buildRow(Widget horWidget, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        horWidget,
        getHomeTitle("Trending"),
        getHorSpace(FetchPixels.getPixelWidth(8)),
        getSvgImageWithSize(context, "fire.svg", FetchPixels.getPixelHeight(24),
            FetchPixels.getPixelHeight(24)),
        Expanded(
          child: getHorSpace(0),
          flex: 1,
        ),
        getViewAllTitle(() {
          Constant.sendToNext(context, Routes.trendingListScreenRoute);
        }),
        getHorSpace(FetchPixels.getDefaultHorSpace(context)),
      ],
    );
  }

  getDefaultTitles(Widget horWidget, String title, Function function) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        horWidget,
        getHomeTitle(title),
        Expanded(
          child: getHorSpace(0),
          flex: 1,
        ),
        getViewAllTitle(function),
        getHorSpace(FetchPixels.getDefaultHorSpace(context)),
      ],
    );
  }

  showBidDialog() {
    FetchPixels(context);
    TextEditingController controllerBid = TextEditingController();
    double radius = FetchPixels.getPixelHeight(40);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(
        horizontal: FetchPixels.getDefaultHorSpace(context));
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
                heightFactor: 0.6,
                child: ListView(
                  children: [
                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    Center(child: getDialogDividerTop(context)),
                    getVerSpace(FetchPixels.getPixelHeight(26)),
                    buildHeader(edgeInsets, context),
                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    getPaddingWidget(
                        edgeInsets,
                        getMultilineCustomFont(
                            "You are about to place a bid on C O I\n N Z from NFT.",
                            15,
                            getFontColor(context),
                            fontWeight: FontWeight.w400,
                            txtHeight: 1.46)),
                    getVerSpace(FetchPixels.getPixelHeight(20)),
                    getPaddingWidget(
                        edgeInsets,
                        getCustomFont("Your Bid", 16, getFontColor(context), 1,
                            fontWeight: FontWeight.w600)),
                    getVerSpace(FetchPixels.getPixelHeight(8)),
                    getPaddingWidget(
                        edgeInsets,
                        getDefaultTextFiled(context, "Enter Bid", controllerBid,
                            getFontColor(context))),
                    buildColumn(context),
                    getButton(context, getAccentColor(context), true,
                        "Place bid", Colors.white, () {
                      Constant.backToPrev(context);
                      showDialogFollowSteps();
                    },
                        EdgeInsets.only(
                            bottom: FetchPixels.getPixelHeight(51),
                            left: FetchPixels.getDefaultHorSpace(context),
                            right: FetchPixels.getDefaultHorSpace(context))),
                    Center(
                      child: getDialogDividerBottom(context),
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  Container buildColumn(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: FetchPixels.getDefaultHorSpace(context),
          vertical: FetchPixels.getPixelHeight(20)),
      width: double.infinity,
      padding: EdgeInsets.all(FetchPixels.getPixelHeight(20)),
      decoration: getButtonDecoration(
          getCurrentTheme(context).dialogBackgroundColor,
          withBorder: false,
          withCorners: true,
          corner: FetchPixels.getPixelHeight(12),
          shadow: [
            BoxShadow(
                color: getCurrentTheme(context).shadowColor,
                offset: const Offset(-5, 6),
                blurRadius: 40)
          ]),
      child: Column(
        children: [
          getTitleFont(
              "Your balance", "9.8568${Constant.getCurrency(context)}"),
          getVerSpace(FetchPixels.getPixelHeight(16)),
          getTitleFont("Service fee", "0.05${Constant.getCurrency(context)}"),
          getVerSpace(FetchPixels.getPixelHeight(16)),
          Divider(
            height: FetchPixels.getPixelHeight(1),
            color: getCurrentTheme(context).focusColor,
          ),
          getVerSpace(FetchPixels.getPixelHeight(16)),
          getTitleFont(
              "Total bid amount", "0.00${Constant.getCurrency(context)}"),
        ],
      ),
    );
  }

  Widget buildHeader(EdgeInsets edgeInsets, BuildContext context) {
    return getPaddingWidget(
        edgeInsets,
        Row(
          children: [
            Expanded(
              child: getCustomFont("Place a bid", 22, getFontColor(context), 1,
                  fontWeight: FontWeight.w600),
              flex: 1,
            ),
            getCloseButton(context, () {
              Constant.backToPrev(context);
            })
          ],
        ));
  }

  showDialogFollowSteps() {
    FetchPixels(context);
    List<ModelSteps> stepList = DataFile.getAllStepsList();
    double radius = FetchPixels.getPixelHeight(40);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(
        horizontal: FetchPixels.getDefaultHorSpace(context));
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
                heightFactor: 0.75,
                child: ListView(
                  children: [
                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    Center(child: getDialogDividerTop(context)),
                    getVerSpace(FetchPixels.getPixelHeight(26)),
                    getPaddingWidget(
                        edgeInsets,
                        Row(
                          children: [
                            Expanded(
                              child: getCustomFont(
                                  "Follow Steps", 22, getFontColor(context), 1,
                                  fontWeight: FontWeight.w600),
                              flex: 1,
                            ),
                            getCloseButton(context, () {
                              Constant.backToPrev(context);
                            })
                          ],
                        )),
                    buildList(stepList, edgeInsets, setState),
                    Center(
                      child: getDialogDividerBottom(context),
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  ListView buildList(
      List<ModelSteps> stepList, EdgeInsets edgeInsets, StateSetter setState) {
    return ListView.builder(
      itemBuilder: (context, index) {
        ModelSteps modelStep = stepList[index];
        double imgSize = FetchPixels.getPixelHeight(55);
        double verFetch = FetchPixels.getPixelHeight(20);
        ModelStepsColor stepColor = getStatusButtonColor(modelStep);
        return Container(
          margin: EdgeInsets.symmetric(
              horizontal: FetchPixels.getDefaultHorSpace(context),
              vertical: verFetch),
          padding: edgeInsets,
          height: FetchPixels.getPixelHeight(151),
          decoration: getButtonDecoration(
              getCurrentTheme(context).dialogBackgroundColor,
              withBorder: false,
              withCorners: true,
              corner: FetchPixels.getPixelHeight(12),
              shadow: [
                BoxShadow(
                    color: getCurrentTheme(context).shadowColor,
                    offset: const Offset(-5, 6),
                    blurRadius: 40)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  getSvgImageWithSize(
                      context, stepColor.icon, imgSize, imgSize),
                  getHorSpace(FetchPixels.getPixelWidth(13)),
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getCustomFont(
                              modelStep.title, 15, getFontColor(context), 1,
                              fontWeight: FontWeight.w600),
                          getVerSpace(FetchPixels.getPixelHeight(5)),
                          getCustomFont(
                              modelStep.desc, 15, getFontColor(context), 1,
                              fontWeight: FontWeight.w400),
                        ]),
                    flex: 1,
                  )
                ],
              ),
              getVerSpace(FetchPixels.getPixelHeight(16)),
              getSubButton(context, stepColor.buttonColor, true, stepColor.text,
                  stepColor.textColor, () {
                bool isActive = modelStep.status == Constant.stepStatusActive;
                bool isWrong = modelStep.status == Constant.stepStatusWrong;
                if (isActive || isWrong) {
                  if (index == 0) {
                    stepList[0].status = Constant.stepStatusDone;
                    stepList[1].status = Constant.stepStatusActive;
                    setState(() {});
                  } else if (index == 1 && isWrong) {
                    stepList[1].status = Constant.stepStatusDone;
                    stepList[2].status = Constant.stepStatusActive;
                    setState(() {});
                  } else if (index == 1) {
                    stepList[1].status = Constant.stepStatusWrong;
                    setState(() {});
                  } else {
                    Constant.backToPrev(context);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return TransactionDialog(
                              context, () {}, "robert_1225");
                        });
                  }
                }
              }, EdgeInsets.zero)
            ],
          ),
        );
      },
      itemCount: stepList.length,
      primary: false,
      shrinkWrap: true,
    );
  }

  ModelStepsColor getStatusButtonColor(ModelSteps status) {
    var darkThemeProvider = Provider.of<DarkMode>(context);
    bool isDark = darkThemeProvider.darkMode;
    switch (status.status) {
      case 0:
        return ModelStepsColor(
            getFontSkip(context),
            (isDark)
                ? getCurrentTheme(context).hoverColor
                : "#E3E6EE".toColor(),
            status.image,
            "Start Now");
      case 1:
        return ModelStepsColor(
            Colors.white, getAccentColor(context), status.image, "Start Now");
      case 2:
        return ModelStepsColor(
            (isDark) ? "#29F086".toColor() : "#04B155".toColor(),
            (isDark) ? "#478DAAA3".toColor() : "#DCFBEB".toColor(),
            "Check.svg",
            "Done");
      case 3:
        return ModelStepsColor(
            (isDark) ? "#FF4343".toColor() : "#DD3333".toColor(),
            (isDark) ? "#52AA8D8D".toColor() : "#FFEAEA".toColor(),
            "Close_icon.svg",
            "Failed");
      default:
        return ModelStepsColor(getFontSkip(context),
            getCurrentTheme(context).hoverColor, status.image, "Start Now");
    }
  }

  getTitleFont(String title, String subTitle) {
    return Row(
      children: [
        Expanded(
          child: getCustomFont(title, 15, getFontColor(context), 1,
              fontWeight: FontWeight.w400),
          flex: 1,
        ),
        getCustomFont(subTitle, 16, getFontColor(context), 1,
            fontWeight: FontWeight.w600)
      ],
    );
  }

  ListView widgetTopCollectionList() {
    return ListView.builder(
      padding: EdgeInsets.only(top: FetchPixels.getPixelHeight(4)),
      scrollDirection: Axis.vertical,
      primary: false,
      shrinkWrap: true,
      itemCount: topCollection.length,
      itemBuilder: (context, index) {
        ModelTrending modelTrend = topCollection[index];
        return topCollectionListItem(
            context, modelTrend, index, index != topCollection.length - 1);
      },
    );
  }

  SizedBox widgetCreatorList(double verSpace, int minVal, double horSpace) {
    return SizedBox(
      width: double.infinity,
      height: FetchPixels.getPixelHeight(199) + (verSpace * 2),
      child: ListView.builder(
        itemCount: min(minVal, creatorList.length),
        shrinkWrap: true,
        primary: false,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          double itemWidth = FetchPixels.getPixelHeight(147);
          double imgSize = FetchPixels.getPixelHeight(59);
          double imgMargin = FetchPixels.getPixelHeight(14);
          ModelCreator modelCreator = creatorList[index];
          return Container(
            width: itemWidth,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: imgMargin),
            margin: (index != 0)
                ? EdgeInsets.symmetric(
                    horizontal: horSpace / 2, vertical: verSpace)
                : EdgeInsets.only(
                    left: horSpace,
                    right: horSpace / 2,
                    top: verSpace,
                    bottom: verSpace),
            decoration: getButtonDecoration(
              getCardColor(context),
              withCorners: true,
              corner: FetchPixels.getPixelHeight(12),
              withBorder: false,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: getVerSpace(0)),
                getCircleImage(context, modelCreator.image ?? "", imgSize),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                getCustomFont(
                    modelCreator.title ?? "", 13, getFontColor(context), 1,
                    fontWeight: FontWeight.w600, textAlign: TextAlign.center),
                getVerSpace(FetchPixels.getPixelHeight(8)),
                getCustomFont(
                    modelCreator.description ?? "", 13, getFontSkip(context), 1,
                    fontWeight: FontWeight.w600, textAlign: TextAlign.center),
                getVerSpace(FetchPixels.getPixelHeight(14)),
                getSubButton(context, getAccentColor(context), true, "Follow",
                    Colors.white, () {}, EdgeInsets.zero),
                Expanded(child: getVerSpace(0))
              ],
            ),
          );
        },
      ),
    );
  }

  SizedBox widgetTrendingList(double verSpace, int minVal, double horSpace) {
    return SizedBox(
      width: double.infinity,
      height: FetchPixels.getPixelHeight(305) + (verSpace * 2),
      child: ListView.builder(
        itemCount: min(minVal, trendingList.length),
        shrinkWrap: true,
        primary: false,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          double itemWidth = FetchPixels.getPixelHeight(276);
          double imgMargin = FetchPixels.getPixelHeight(14);
          ModelTrending _modelTrend = trendingList[index];
          return Container(
            width: itemWidth,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: imgMargin),
            margin: (index != 0)
                ? EdgeInsets.symmetric(
                    horizontal: horSpace / 2, vertical: verSpace)
                : EdgeInsets.only(
                    left: horSpace,
                    right: horSpace / 2,
                    top: verSpace,
                    bottom: verSpace),
            decoration: getButtonDecoration(
                getCurrentTheme(context).dialogBackgroundColor,
                withCorners: true,
                corner: FetchPixels.getPixelHeight(12),
                withBorder: false,
                shadow: [
                  BoxShadow(
                      color: getCurrentTheme(context).shadowColor,
                      offset: const Offset(-5, 6),
                      blurRadius: 40)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: FetchPixels.getPixelHeight(191),
                  decoration: BoxDecoration(
                      image: getDecorationAssetImage(context, _modelTrend.image,
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(
                          Radius.circular(FetchPixels.getPixelHeight(12)))),
                  margin: EdgeInsets.symmetric(vertical: imgMargin),
                ),
                getCustomFont(_modelTrend.title, 16, getFontColor(context), 1,
                    fontWeight: FontWeight.w600),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getCustomFont(
                              _modelTrend.subTitle, 13, getFontSkip(context), 1,
                              fontWeight: FontWeight.w400),
                          getVerSpace(FetchPixels.getPixelHeight(5)),
                          Row(
                            children: [
                              getSvgImageWithSize(
                                  context,
                                  "arrow_up_down.svg",
                                  FetchPixels.getPixelHeight(11),
                                  FetchPixels.getPixelHeight(18),
                                  color: getFontColor(context)),
                              getHorSpace(FetchPixels.getPixelHeight(8)),
                              Expanded(
                                child: getCustomFont(
                                    "${_modelTrend.amount} ${Constant.getCurrency(context)}",
                                    13,
                                    getFontColor(context),
                                    1,
                                    fontWeight: FontWeight.w600),
                                flex: 1,
                              )
                            ],
                          )
                        ],
                      ),
                      flex: 1,
                    ),
                    getSubButton(context, getAccentColor(context), true,
                        "Place Bid", Colors.white, () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomAppDialog(
                              context,
                              () {
                                showBidDialog();
                              },
                              "wallet.svg",
                              "",
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vulputate pulvinar mi, eu tempus ligula. Quisque at turpis laoreet, tincidunt nisl ac, sagittis tellus.",
                              "Connect Wallet",
                              withClose: true,
                            );
                          });
                    }, EdgeInsets.zero, width: FetchPixels.getPixelHeight(91))
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Row topHeader(Widget horWidget, BuildContext context) {
    return Row(
      children: [
        horWidget,
        Container(
          // width: FetchPixels.getPixelWidth(137),
          height: FetchPixels.getPixelHeight(50),
          decoration: getButtonDecoration(getCardColor(context),
              withBorder: false,
              withCorners: true,
              corner: FetchPixels.getPixelHeight(25)),
          padding: EdgeInsets.only(
              left: FetchPixels.getPixelWidth(7),
              right: FetchPixels.getPixelWidth(14)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getSvgImageWithSize(
                  context,
                  "currency_icon.svg",
                  FetchPixels.getPixelHeight(36),
                  FetchPixels.getPixelHeight(36)),
              getHorSpace(FetchPixels.getPixelWidth(8)),
              getCustomFont("23.02 ${Constant.getCurrency(context)}", 15,
                  getFontColor(context), 1,
                  fontWeight: FontWeight.w600)
            ],
          ),
        ),
        Expanded(
          child: getHorSpace(0),
          flex: 1,
        ),
        getCircleImage(context, "Profile.png", FetchPixels.getPixelHeight(44)),
        getHorSpace(FetchPixels.getDefaultHorSpace(context))
      ],
    );
  }
}
