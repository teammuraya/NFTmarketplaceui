import 'package:flutter/material.dart';
import 'package:screen_sizer/base/color_data.dart';
import 'package:screen_sizer/base/resizer/fetch_pixels.dart';
import 'package:screen_sizer/base/widget_utils.dart';
import '../../../base/Constant.dart';
import '../../../widgets/device_util.dart';
import '../../data/data_file.dart';
import '../../models/model_creator.dart';

class AllCreatorsList extends StatefulWidget {
  const AllCreatorsList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AllCreatorsList();
  }
}

class _AllCreatorsList extends State<AllCreatorsList> {
  backClick() {
    Constant.backToPrev(context);
  }

  List<ModelCreator> creatorList = DataFile.getCreatorsList();

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);

    double horPadding = FetchPixels.getDefaultHorSpace(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: horPadding);
    int crossAxisCountPopular = 2;
    double width = MediaQuery.of(context).size.width;
    if (DeviceUtil.isTablet) {
      crossAxisCountPopular = 3;
    } else {
      crossAxisCountPopular = 2;
    }
    double gridWidth = (width - (horPadding * (crossAxisCountPopular + 1))) /
        crossAxisCountPopular;
    double gridHeight = FetchPixels.getPixelHeight(199);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: getCurrentTheme(context).scaffoldBackgroundColor,
          appBar: getInVisibleAppBar(),
          body: Column(children: [
            getVerSpace(FetchPixels.getPixelHeight(18)),
            getCenterTitleHeader(context, "Popular Creators", edgeInsets, () {
              backClick();
            }, visibleMore: false),
            getVerSpace(FetchPixels.getPixelHeight(20)),
            buildExpanded(horPadding, crossAxisCountPopular, gridWidth,
                gridHeight, context)
          ]),
        ),
        onWillPop: () async {
          backClick();
          return false;
        });
  }

  Expanded buildExpanded(double horPadding, int crossAxisCountPopular,
      double gridWidth, double gridHeight, BuildContext context) {
    return Expanded(
      child: GridView.count(
        padding: EdgeInsets.symmetric(horizontal: horPadding / 2),
        crossAxisCount: crossAxisCountPopular,
        childAspectRatio: gridWidth / gridHeight,
        shrinkWrap: true,
        primary: false,
        children: List.generate(creatorList.length, (index1) {
          ModelCreator modelCreator = creatorList[index1];
          double imgSize = FetchPixels.getPixelHeight(59);
          return Center(
            child: Container(
              width: gridWidth,
              padding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getPixelWidth(16)),
              height: gridHeight,
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
                  getCustomFont(modelCreator.description ?? "", 13,
                      getFontSkip(context), 1,
                      fontWeight: FontWeight.w600, textAlign: TextAlign.center),
                  getVerSpace(FetchPixels.getPixelHeight(14)),
                  getSubButton(context, getAccentColor(context), true, "Follow",
                      Colors.white, () {}, EdgeInsets.zero),
                  Expanded(child: getVerSpace(0))
                ],
              ),
            ),
          );
        }),
      ),
      flex: 1,
    );
  }
}
