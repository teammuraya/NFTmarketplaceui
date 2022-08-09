import 'package:flutter/material.dart';
import 'package:screen_sizer/app/data/data_file.dart';
import 'package:screen_sizer/base/color_data.dart';
import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../models/model_notification.dart';

class TabNotification extends StatefulWidget {
  const TabNotification({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabNotification();
  }
}

class _TabNotification extends State<TabNotification> {
  TextEditingController searchController = TextEditingController();
  List<ModelNotification> notificationList = DataFile.getAllNotificationList();

  @override
  Widget build(BuildContext context) {
    double horSpace = FetchPixels.getDefaultHorSpace(context);

    return Column(
      children: [
        getVerSpace(FetchPixels.getPixelHeight(10)),
        topHeader(horSpace, "Notifications", context),
        getVerSpace(FetchPixels.getPixelHeight(27)),
        buildExpanded(horSpace)
      ],
    );
  }

  Expanded buildExpanded(double horSpace) {
    return Expanded(
      child: ListView(
        primary: true,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          getTitles("Today"),
          ListView.builder(
            itemCount: notificationList.length,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              ModelNotification modelDiscover = notificationList[index];
              return Container(
                width: double.infinity,
                height: FetchPixels.getPixelHeight(92),
                margin: EdgeInsets.symmetric(
                    horizontal: horSpace,
                    vertical: FetchPixels.getPixelHeight(10)),
                decoration: getButtonDecoration(
                    getCurrentTheme(context).dialogBackgroundColor,
                    corner: getButtonCorners(),
                    withBorder: false,
                    withCorners: true,
                    shadow: [
                      BoxShadow(
                          color: getCurrentTheme(context).shadowColor,
                          offset: const Offset(-5, 6),
                          blurRadius: 40)
                    ]),
                padding: EdgeInsets.symmetric(
                    horizontal: horSpace,
                    vertical: FetchPixels.getPixelHeight(16)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: FetchPixels.getPixelHeight(60),
                      height: FetchPixels.getPixelHeight(60),
                      decoration: BoxDecoration(
                          image: getDecorationAssetImage(
                              context, modelDiscover.image)),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: FetchPixels.getPixelHeight(2)),
                          child: getSvgImageWithSize(
                              context,
                              "status.svg",
                              FetchPixels.getPixelHeight(13),
                              FetchPixels.getPixelHeight(13)),
                        ),
                      ),
                    ),
                    getHorSpace(FetchPixels.getPixelWidth(12)),
                    Expanded(
                      child: Column(
                        children: [
                          getCustomFont(
                              modelDiscover.title, 16, getFontColor(context), 1,
                              fontWeight: FontWeight.w600),
                          getVerSpace(FetchPixels.getPixelHeight(5)),
                          getCustomFont(
                              modelDiscover.desc, 15, getFontColor(context), 1,
                              fontWeight: FontWeight.w400)
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      flex: 1,
                    ),
                    getCustomFont(
                        modelDiscover.time, 15, getFontSkip(context), 1,
                        fontWeight: FontWeight.w400)
                  ],
                ),
              );
            },
          ),
          getVerSpace(FetchPixels.getPixelHeight(25)),
          getTitles("Yesterday"),
          ListView.builder(
            itemCount: notificationList.length,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              ModelNotification modelDiscover = notificationList[index];
              return Container(
                width: double.infinity,
                height: FetchPixels.getPixelHeight(92),
                margin: EdgeInsets.symmetric(
                    horizontal: horSpace,
                    vertical: FetchPixels.getPixelHeight(10)),
                decoration: getButtonDecoration(
                    getCurrentTheme(context).dialogBackgroundColor,
                    corner: getButtonCorners(),
                    withBorder: false,
                    withCorners: true,
                    shadow: [
                      BoxShadow(
                          color: getCurrentTheme(context).shadowColor,
                          offset: const Offset(-5, 6),
                          blurRadius: 40)
                    ]),
                padding: EdgeInsets.symmetric(
                    horizontal: horSpace,
                    vertical: FetchPixels.getPixelHeight(16)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: FetchPixels.getPixelHeight(60),
                      height: FetchPixels.getPixelHeight(60),
                      decoration: BoxDecoration(
                          image: getDecorationAssetImage(
                              context, modelDiscover.image)),
                      child: Visibility(
                        visible: false,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: FetchPixels.getPixelHeight(2)),
                            child: getSvgImageWithSize(
                                context,
                                "status.svg",
                                FetchPixels.getPixelHeight(13),
                                FetchPixels.getPixelHeight(13)),
                          ),
                        ),
                      ),
                    ),
                    getHorSpace(FetchPixels.getPixelWidth(12)),
                    Expanded(
                      child: Column(
                        children: [
                          getCustomFont(
                              modelDiscover.title, 16, getFontColor(context), 1,
                              fontWeight: FontWeight.w600),
                          getVerSpace(FetchPixels.getPixelHeight(5)),
                          getCustomFont(
                              modelDiscover.desc, 15, getFontColor(context), 1,
                              fontWeight: FontWeight.w400)
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      flex: 1,
                    ),
                    getCustomFont(
                        modelDiscover.time, 15, getFontSkip(context), 1,
                        fontWeight: FontWeight.w400)
                  ],
                ),
              );
            },
          ),
        ],
      ),
      flex: 1,
    );
  }

  Widget getTitles(String string) {
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
        child: getCustomFont(string, 15, getFontColor(context), 1,
            fontWeight: FontWeight.w400));
  }
}
