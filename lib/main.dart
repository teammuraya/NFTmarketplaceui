import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:screen_sizer/app/routes/app_pages.dart';
import 'package:screen_sizer/base/color_data.dart';
import 'package:screen_sizer/base/restart_controller.dart';

import 'app/notifier/dark_mode.dart';
import 'base/my_behaviour.dart';
import 'base/my_custom_scroll_behavior.dart';
import 'generated/l10n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(RestartController(
    child: ChangeNotifierProvider(
        create: (context) => DarkMode(context), child: const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var darkThemeProvider = Provider.of<DarkMode>(context);

    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child!,
        );
      },
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate,
      ],
      title: 'Flutter_ScreenUtil',
      initialRoute: "/",
      theme: ThemeData(
          scaffoldBackgroundColor: "#FFFFFF".toColor(),
          textTheme: TextTheme(
              titleMedium: TextStyle(color: "#0F172A".toColor()),
              titleSmall: TextStyle(color: "#525E7B".toColor()),
              titleLarge: TextStyle(color: "#000000".toColor())),
          backgroundColor: "#E5E5E5".toColor(),
          hoverColor: "#F7F7FF".toColor(),
          cardColor: "#F2F5FF".toColor(),
          selectedRowColor: "#FFFFFF".toColor(),
          dialogBackgroundColor: "#FFFFFF".toColor(),
          focusColor: "#B9C1D3".toColor(),
          hintColor: "#525E7B".toColor(),
          disabledColor: "#525E7B".toColor(),
          canvasColor: "#F7F8FB".toColor(),
          dividerColor: "#D7DDEC".toColor(),
          shadowColor: const Color.fromRGBO(131, 157, 216, 0.11999999731779099),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: "#0F172A".toColor())),
      darkTheme: ThemeData(
          scaffoldBackgroundColor: "#161E2D".toColor(),
          backgroundColor: "#161E2D".toColor(),
          hoverColor: "#21F6F7FF".toColor(),
          dialogBackgroundColor: "#283048".toColor(),
          selectedRowColor: "#5E57FF".toColor(),
          focusColor: "#525E7B".toColor(),
          cardColor: "#2D354F".toColor(),
          dividerColor: "#2B354D".toColor(),
          canvasColor: "#525E7B".toColor(),
          hintColor: "#A6ADBE".toColor(),
          disabledColor: "#FFFFFF".toColor(),
          shadowColor: const Color.fromRGBO(0, 0, 0, 0.4699999988079071),
          textTheme: TextTheme(
              titleMedium: TextStyle(color: "#FFFFFF".toColor()),
              titleSmall: TextStyle(color: "#A6ADBE".toColor()),
              titleLarge: TextStyle(color: "#FFFFFF".toColor())),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: "#5E57FF".toColor())),
      themeMode:
          (darkThemeProvider.darkMode) ? ThemeMode.dark : ThemeMode.light,
      routes: AppPages.routes,
    );
  }
}
