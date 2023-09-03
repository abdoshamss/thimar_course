import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart' as mat;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_course/core/design/res/colors.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/firebase_options.dart';
import 'package:thimar_course/screens/home_nav/view.dart';

import 'package:thimar_course/screens/register/view.dart';

import 'generated/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.instance.getToken().then((value) {
    print("My toooooooken");
    print(value.toString());
  });
  await CacheHelper.init();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        saveLocale: true,
        startLocale: Locale('ar'),
        path:
            'assets/translations', // <-- change the path of the translation files
        assetLoader: CodegenLoader(),
        fallbackLocale: Locale('en'),
        child: MyApp()),
  );
  // runApp(const MyApp());
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => child!,
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: "Thimar",
        navigatorKey: navigatorKey,
        // builder: (context, child) =>
        // Directionality(textDirection: TextDirection.rtl, child: child!),
        // Directionality(textDirection:mat. TextDirection.rtl, child: child!),
        theme: ThemeData(
            // elevatedButtonTheme: ElevatedButtonThemeData(
            //   style: ElevatedButton.styleFrom(
            //     textStyle: TextStyle(
            //       color: Colors.white
            //     )
            //   )
            // ),
            androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
            scaffoldBackgroundColor: Colors.white,
            primarySwatch: getMaterialColor(primaryColor.value),
            unselectedWidgetColor: const Color(0xffF3F3F3),
            hintColor: const Color(0xff808080),
            fontFamily: "Tajawal",
            appBarTheme: const AppBarTheme(
                elevation: 0,
                color: Colors.white,
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: primaryColor,
                ))),
        debugShowCheckedModeBanner: false,
        home: HomeNavScreen(),
      ),
    );
  }
}

// <key>CFBundleLocalizations</key>
//     <array>
//         <string>en</string>
//         <string>ar</string>
//     </array>
