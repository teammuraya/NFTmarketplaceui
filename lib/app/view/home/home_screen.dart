import 'package:flutter/material.dart';
import 'package:screen_sizer/app/routes/app_routes.dart';
import 'package:screen_sizer/app/view/home/tabs/tab_discover.dart';
import 'package:screen_sizer/app/view/home/tabs/tab_home.dart';
import 'package:screen_sizer/app/view/home/tabs/tab_more.dart';
import 'package:screen_sizer/app/view/home/tabs/tab_notification.dart';
import 'package:screen_sizer/base/color_data.dart';
import 'package:screen_sizer/base/resizer/fetch_pixels.dart';
import 'package:screen_sizer/base/widget_utils.dart';

import '../../../base/Constant.dart';
import '../../../base/custom_animated_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  int currentPos = 0;

  List<Widget> tabList = [
    const TabHome(),
    const TabDiscover(),
    const TabHome(),
    const TabNotification(),
    const TabMore(),
  ];

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
          () {
        final arg = ModalRoute.of(context)!.settings.arguments as Map?;
        if (arg != null) {

          setState(() {
            currentPos=arg[Constant.homePos];
          });
        }
      },
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          appBar: getInVisibleAppBar(),
          backgroundColor: getCurrentTheme(context).scaffoldBackgroundColor,
          body: tabList[currentPos],
          bottomNavigationBar: CustomAnimatedBottomBar(
            containerHeight: FetchPixels.getPixelHeight(100),
            backgroundColor: getCurrentTheme(context).scaffoldBackgroundColor,
            selectedIndex: currentPos,
            showElevation: true,
            itemCornerRadius: 24,
            curve: Curves.easeIn,
            totalItemCount: 5,
            onItemSelected: (index) {
              if (index == 2) {
                showHomeDialog();
              }
              else {
                setState(() => currentPos = index);
              }

            },
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                title: 'Home',
                activeColor: getAccentColor(context),
                inactiveColor: Colors.transparent,
                textAlign: TextAlign.center,
                iconSize: FetchPixels.getPixelHeight(24),
                imageName: "Home.svg",
              ),
              BottomNavyBarItem(
                title: 'Search',
                activeColor: getAccentColor(context),
                inactiveColor: Colors.transparent,
                textAlign: TextAlign.center,
                iconSize: FetchPixels.getPixelHeight(24),
                imageName: "Search.svg",
              ),
              BottomNavyBarItem(
                title: 'Messages',
                activeColor: getAccentColor(context),
                inactiveColor: Colors.transparent,
                textAlign: TextAlign.center,
                iconSize: FetchPixels.getPixelHeight(24),
                imageName: "Plus.svg",
              ),
              BottomNavyBarItem(
                title: 'Cart',
                activeColor: getAccentColor(context),
                inactiveColor: Colors.transparent,
                textAlign: TextAlign.center,
                iconSize: FetchPixels.getPixelHeight(24),
                imageName: "Notification.svg",
              ),
              BottomNavyBarItem(
                title: 'All Pets',
                activeColor: getAccentColor(context),
                inactiveColor: Colors.transparent,
                textAlign: TextAlign.center,
                iconSize: FetchPixels.getPixelHeight(24),
                imageName: "More.svg",
              ),
            ],
          ),
        ),
        onWillPop: () async {
          Constant.closeApp();
          return false;
        });
  }

  showHomeDialog() {

    FetchPixels(context);
    double radius = FetchPixels.getPixelHeight(40);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(
        horizontal: FetchPixels.getPixelWidth(20),
        vertical: FetchPixels.getPixelHeight(10));

    List<BoxShadow> shadow = [
      BoxShadow(
          color: getCurrentTheme(context).shadowColor,
          offset: const Offset(-5, 6),
          blurRadius: 40)
    ];

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
              return SizedBox(
                height: FetchPixels.getPixelHeight(327),
                child: Column(
                  children: [
                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    Center(child: getDialogDividerTop(context)),
                    Expanded(
                      child: ListView(
                        children: [
                          getVerSpace(FetchPixels.getPixelHeight(10)),
                          getButton(
                            context,
                            getCurrentTheme(context).dialogBackgroundColor,
                            true,
                            "Single",
                            getFontColor(context),
                            () {
                              Navigator.of(context).pop();
                              Constant.sendToNext(context,Routes.collectibleScreenRoute);
                            },
                            edgeInsets,
                            isBorder: false,
                            shadow: shadow,
                            borderColor: getAccentColor(context),
                          ),
                          getButton(
                            context,
                            getCurrentTheme(context).dialogBackgroundColor,
                            true,
                            "Multiple",
                            getFontColor(context),
                            () {
                              Navigator.of(context).pop();
                              Constant.sendToNext(context,Routes.collectibleScreenRoute);                            },
                            edgeInsets,
                            isBorder: false,
                            shadow: shadow,
                            borderColor: getAccentColor(context),
                          ),
                          getButton(
                            context,
                            Colors.transparent,
                            true,
                            "Cancel",
                            getFontColor(context),
                            () {
                              Constant.backToPrev(context);
                            },
                            edgeInsets,
                            isBorder: true,
                            shadow: shadow,
                            borderColor: getFontColor(context),
                          ),
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
