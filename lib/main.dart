import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_course/core/design/res/colors.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/core/logic/kiwi.dart';
import 'package:thimar_course/firebase_options.dart';
import 'package:thimar_course/screens/auth/splash.dart';
import 'generated/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initKiwi();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: getMaterialColor(primaryColor.value),
  ));
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.instance.getToken().then((value) {
    debugPrint("My FCM tooooooooooooken");
    debugPrint(value.toString());
  });
  await CacheHelper.init();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        saveLocale: true,
        startLocale: const Locale('ar'),
        path:
            'assets/translations', // <-- change the path of the translation files
        assetLoader: const CodegenLoader(),
        fallbackLocale: const Locale('en'),
        child: const MyApp()),
  );
  // runApp(const MyApp());
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
        builder: (context, child) =>
            Directionality(textDirection: mat.TextDirection.rtl, child: child!),
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
              )),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0xffF3F3F3),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0xffF3F3F3),
              ),
            ),
          ),
          // snackBarTheme: const SnackBarThemeData(
          //     actionTextColor: Colors.red,
          //     backgroundColor: Colors.black,
          //     contentTextStyle: TextStyle(color: Colors.white),
          //     elevation: 20
          // ),
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}

// <key>CFBundleLocalizations</key>
//     <array>
//         <string>en</string>
//         <string>ar</string>
//     </array>

/////  966512345188   phone
////   1111           code
