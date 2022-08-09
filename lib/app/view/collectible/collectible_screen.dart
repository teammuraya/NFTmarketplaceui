import 'package:flutter/material.dart';
import 'package:screen_sizer/app/data/data_file.dart';
import 'package:screen_sizer/base/resizer/fetch_pixels.dart';

import '../../../base/Constant.dart';
import '../../../base/color_data.dart';
import '../../../base/widget_utils.dart';
import '../../routes/app_routes.dart';

class CollectibleScreen extends StatefulWidget {
  const CollectibleScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CollectibleScreen();
  }
}

class _CollectibleScreen extends State<CollectibleScreen> {
  void backClick() {
    Constant.backToPrev(context);
  }

  List<String> collectionList = DataFile.getAllCollectionListList();
  String selectedImage = "";

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    int crossAxisCountPopular = 4;
    double width = MediaQuery.of(context).size.width;
    double gridWidth = (width -
            (FetchPixels.getDefaultHorSpace(context) *
                (crossAxisCountPopular + 1))) /
        crossAxisCountPopular;

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
                getCustomFont(
                    "Choose your file to upload", 13, getFontSkip(context), 1,
                    fontWeight: FontWeight.w400),
                getVerSpace(FetchPixels.getPixelHeight(18)),
                buildContainer(context),
                getVerSpace(FetchPixels.getPixelHeight(15)),
                buildExpanded(crossAxisCountPopular, gridWidth, context),
                getButton(
                    context,
                    // "#E3E6EE".toColor(),
                    getCardColor(context),
                    true,
                    "Next",
                    getFontHint(context), () {
                  Constant.sendToNext(
                      context, Routes.collectibleDetailScreenRoute);
                },
                    EdgeInsets.symmetric(
                        vertical: FetchPixels.getPixelHeight(15)))
              ],
            ),
          ),
        ),
        onWillPop: () async {
          backClick();
          return false;
        });
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
            child: getCustomFont("1", 16, Colors.white, 1,
                fontWeight: FontWeight.w600),
          ),
        ),
        getHorSpace(FetchPixels.getPixelWidth(8)),
        Expanded(
          child: getCustomFont("Upload file", 15, getFontColor(context), 1,
              fontWeight: FontWeight.w600),
          flex: 1,
        )
      ],
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      height: FetchPixels.getPixelHeight(244),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(getButtonCorners())),
          image: getDecorationAssetImage(
              context,
              (selectedImage.isNotEmpty)
                  ? selectedImage
                  : "decoration_border.png",
              fit: (selectedImage.isNotEmpty) ? BoxFit.cover : BoxFit.fill)),
      child: Visibility(
        visible: selectedImage.isEmpty,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getSvgImageWithSize(context, "upload_icon.svg",
                FetchPixels.getPixelHeight(70), FetchPixels.getPixelHeight(70)),
            getVerSpace(FetchPixels.getPixelHeight(10)),
            getMultilineCustomFont("PNG, GIF, WEBP, MP4, OR \nMP3, Max 1GB.",
                13, getFontSkip(context),
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
                txtHeight: 1.46)
          ],
        ),
      ),
    );
  }

  Expanded buildExpanded(
      int crossAxisCountPopular, double gridWidth, BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: crossAxisCountPopular,
        childAspectRatio: gridWidth / gridWidth,
        shrinkWrap: true,
        primary: false,
        children: List.generate(collectionList.length, (index1) {
          return Center(
            child: InkWell(
              onTap: () {
                if (index1 != 0) {
                  setState(() {
                    selectedImage = collectionList[index1];
                  });
                }
              },
              child: SizedBox(
                width: gridWidth,
                height: gridWidth,
                child: getCircularImage(
                    context,
                    double.infinity,
                    double.infinity,
                    FetchPixels.getPixelHeight(12),
                    collectionList[index1]),
              ),
            ),
          );
        }),
      ),
      flex: 1,
    );
  }
}
