import 'package:flutter/material.dart';
import 'package:screen_sizer/base/resizer/fetch_pixels.dart';

import '../../../base/Constant.dart';
import '../../../base/color_data.dart';
import '../../../base/widget_utils.dart';
import '../../data/data_file.dart';
import '../../models/model_trending.dart';

class TopCollectionList extends StatefulWidget {
  const TopCollectionList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TopCollectionList();
  }
}

class _TopCollectionList extends State<TopCollectionList> {
  void backClick() {
    Constant.backToPrev(context);
  }

  List<ModelTrending> topCollection = DataFile.getTopCollection();

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: getCurrentTheme(context).scaffoldBackgroundColor,
          appBar: getInVisibleAppBar(),
          body: Column(
            children: [
              getVerSpace(FetchPixels.getPixelHeight(18)),
              buildCenterTitleHeader(context),
              getVerSpace(FetchPixels.getPixelHeight(27)),
              buildExpandedView()
            ],
          ),
        ),
        onWillPop: () async {
          backClick();
          return false;
        });
  }

  Expanded buildExpandedView() {
    return Expanded(
              child: ListView.builder(
                itemCount: topCollection.length,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                primary: true,
                itemBuilder: (context, index) {
                  ModelTrending modelTrend = topCollection[index];
                  return topCollectionListItem(context, modelTrend, index,
                      index != topCollection.length - 1);
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
