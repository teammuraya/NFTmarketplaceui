import 'package:flutter/material.dart';
import 'package:screen_sizer/base/color_data.dart';
import 'package:screen_sizer/base/constant.dart';
import 'package:screen_sizer/base/resizer/fetch_pixels.dart';
import 'package:screen_sizer/base/widget_utils.dart';

import '../../data/data_file.dart';
import '../../models/model_discover.dart';

class TrendingListScreen extends StatefulWidget {
  const TrendingListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TrendingListScreen();
  }
}

class _TrendingListScreen extends State<TrendingListScreen> {
  void backClick() {
    Constant.backToPrev(context);
  }



  List<ModelDiscover> discoverList = DataFile.getAllDiscoverList();

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    double horSpace = FetchPixels.getDefaultHorSpace(context);
    int crossAxisCountPopular = 2;
    double width = MediaQuery.of(context).size.width;
    double gridWidth = (width - (horSpace * (crossAxisCountPopular + 1))) /
        crossAxisCountPopular;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: getCurrentTheme(context).scaffoldBackgroundColor,
          appBar: getInVisibleAppBar(),
          body: Column(
            children: [
              getVerSpace(FetchPixels.getPixelHeight(18)),
              buildCenterTitleHeader(context),
              buildExpandView(horSpace, crossAxisCountPopular, gridWidth)
            ],
          ),
        ),
        onWillPop: () async {
          backClick();
          return false;
        });
  }

  Expanded buildExpandView(double horSpace, int crossAxisCountPopular, double gridWidth) {
    return Expanded(
              child: ListView.builder(
                itemCount: discoverList.length,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                primary: true,
                itemBuilder: (context, index) {
                  ModelDiscover modelDiscover = discoverList[index];
                  return buildDiscoverItem(context, modelDiscover, horSpace,
                      crossAxisCountPopular, gridWidth);
                },
              ),
              flex: 1,
            );
  }

  Widget buildCenterTitleHeader(BuildContext context) {
    return getCenterTitleHeader(
                context,
                "Trending",
                EdgeInsets.symmetric(
                    horizontal: FetchPixels.getDefaultHorSpace(context)), () {
              backClick();
            });
  }
}
