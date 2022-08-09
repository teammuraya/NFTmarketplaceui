import 'package:flutter/material.dart';
import 'package:screen_sizer/app/data/data_file.dart';
import 'package:screen_sizer/app/models/model_discover.dart';
import 'package:screen_sizer/base/color_data.dart';
import 'package:screen_sizer/base/constant.dart';

import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';

class TabDiscover extends StatefulWidget {
  const TabDiscover({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabDiscover();
  }
}

class _TabDiscover extends State<TabDiscover> {
  TextEditingController searchController = TextEditingController();
  List<ModelDiscover> discoverList = DataFile.getAllDiscoverList();

  @override
  Widget build(BuildContext context) {
    double horSpace = FetchPixels.getDefaultHorSpace(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: horSpace);
    int crossAxisCountPopular = 2;
    double width = MediaQuery.of(context).size.width;
    double gridWidth = (width - (horSpace * 3)) / 2;

    return Column(
      children: [
        getVerSpace(FetchPixels.getPixelHeight(10)),
        topHeader(horSpace, "Discover", context),
        getVerSpace(FetchPixels.getPixelHeight(27)),
        buildPaddingWidget(edgeInsets, context),
        buildExpanded(horSpace, crossAxisCountPopular, gridWidth)
      ],
    );
  }

  Widget buildPaddingWidget(EdgeInsets edgeInsets, BuildContext context) {
    return getPaddingWidget(
            edgeInsets,
            getSearchWidget(context, searchController, () {
              showFilterDialog();
            }, (value) {
            }));
  }

  Expanded buildExpanded(double horSpace, int crossAxisCountPopular, double gridWidth) {
    return Expanded(
          child: ListView.builder(
            itemCount: discoverList.length,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            primary: true,
            itemBuilder: (context, index) {
              ModelDiscover modelDiscover = discoverList[index];
              return buildDiscoverItem(context, modelDiscover, horSpace,crossAxisCountPopular, gridWidth);
            },
          ),
          flex: 1,
        );
  }

  showFilterDialog() {
    List<String> list = ["Hot Bids", "Popular Bids", "Trending Bids"];
    FetchPixels(context);
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
                heightFactor: 0.5,
                child: ListView(
                  padding: edgeInsets,
                  children: [
                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    Center(child: getDialogDividerTop(context)),
                    getVerSpace(FetchPixels.getPixelHeight(26)),
                    Row(
                      children: [
                        Expanded(
                          child: getCustomFont(
                              "Sort by", 20, getFontColor(context), 1,
                              fontWeight: FontWeight.w600),
                          flex: 1,
                        ),
                        getCloseButton(context, () {
                          Constant.backToPrev(context);
                        })
                      ],
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        double sizeEdit = FetchPixels.getPixelHeight(60);
                        double iconSize = FetchPixels.getPixelHeight(24);
                        return Container(
                          width: double.infinity,
                          height: sizeEdit,
                          decoration: getButtonDecoration(Colors.transparent,
                              withBorder: true,
                              corner: getButtonCorners(),
                              borderColor:
                                  getCurrentTheme(context).focusColor),
                          margin: EdgeInsets.symmetric(
                              vertical: FetchPixels.getPixelHeight(10)),
                          padding: EdgeInsets.symmetric(
                              horizontal: FetchPixels.getPixelWidth(16)),
                          child: Row(
                            children: [
                              Expanded(
                                child: getCustomFont(
                                    list[index], 15, getFontColor(context), 1,
                                    fontWeight: FontWeight.w400),
                                flex: 1,
                              ),
                              getSvgImageWithSize(
                                  context,
                                  (index == 0)
                                      ? "selected.svg"
                                      : "unselected.svg",
                                  iconSize,
                                  iconSize)
                            ],
                          ),
                        );
                      },
                      itemCount: list.length,
                      primary: false,
                      shrinkWrap: true,
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    Row(
                      children: [
                        Expanded(
                          child: getButton(
                              context,
                              Colors.transparent,
                              true,
                              "Reset",
                              getFontColor(context),
                              () {},
                              EdgeInsets.zero,
                              isBorder: true,
                              borderColor: getAccentColor(context)),
                          flex: 1,
                        ),
                        getHorSpace(FetchPixels.getPixelWidth(20)),
                        Expanded(
                          child: getButton(context, getAccentColor(context),
                              true, "Apply", Colors.white, () {
                            Constant.backToPrev(context);
                          }, EdgeInsets.zero),
                          flex: 1,
                        )
                      ],
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(52)),
                    Center(child: getDialogDividerBottom(context)),
                    getVerSpace(FetchPixels.getPixelHeight(13)),
                  ],
                ),
              );
            },
          );
        });
  }
}
