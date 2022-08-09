import 'package:flutter/material.dart';
import 'package:screen_sizer/app/routes/app_routes.dart';
import 'package:screen_sizer/app/view/collectible/collectible_screen.dart';
import 'package:screen_sizer/app/view/collectible/collectible_screen_detail.dart';
import 'package:screen_sizer/app/view/creators/all_creator_list.dart';
import 'package:screen_sizer/app/view/discover/discover_detail_screen.dart';
import 'package:screen_sizer/app/view/home/home_screen.dart';
import 'package:screen_sizer/app/view/intro.dart';
import 'package:screen_sizer/app/view/login/change_password_screen.dart';
import 'package:screen_sizer/app/view/login/login_screen.dart';
import 'package:screen_sizer/app/view/login/verify_code_screen.dart';
import 'package:screen_sizer/app/view/profile/edit_profile_screen.dart';
import 'package:screen_sizer/app/view/profile/profile_screen.dart';
import 'package:screen_sizer/app/view/splash_screen.dart';
import 'package:screen_sizer/app/view/trendings/top_collection_list.dart';
import 'package:screen_sizer/app/view/trendings/trending_list_screen.dart';

class AppPages {
  static const initialRoute = Routes.homeRoute;
  static Map<String, WidgetBuilder> routes = {
    Routes.homeRoute: (context) => const SplashScreen(),
    Routes.homeScreenRoute: (context) => const HomeScreen(),
    Routes.introRoute: (context) => const IntroView(),
    Routes.loginRoute: (context) => const LoginScreen(),
    Routes.verifyCodeRoute: (context) => const VerifyCodeScreen(),
    Routes.changePassRoute: (context) => const ChangePasswordScreen(),
    Routes.discoverDetailRoute: (context) => const DiscoverDetailScreen(),
    Routes.creatorListScreenRoute: (context) =>  const AllCreatorsList(),
    Routes.profileScreenRoute: (context) =>  const ProfileScreen(),
    Routes.editProfileScreenRoute: (context) =>  const EditProfileScreen(),
    Routes.collectibleScreenRoute: (context) =>  const CollectibleScreen(),
    Routes.collectibleDetailScreenRoute: (context) =>  const CollectibleDetailScreen(),
    Routes.trendingListScreenRoute: (context) =>  const TrendingListScreen(),
    Routes.topCollectionListScreenRoute: (context) =>  const TopCollectionList(),
  };
}

