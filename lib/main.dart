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
import 'package:thimar_course/screens/be_vip.dart';
import 'generated/codegen_loader.g.dart';
import 'screens/charge_now.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.getToken().then((value) {
    debugPrint("My FCM tooooooooooooken");
    debugPrint(value.toString());
  });
  initKiwi();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: getMaterialColor(primaryColor.value),
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
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
          androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
                visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: getMaterialColor(primaryColor.value),
          unselectedWidgetColor: const Color(0xffF3F3F3),
          hintColor: const Color(0xff808080),
          fontFamily: "Tajawal",
          dividerColor: const Color(0xffF6F6F6),
          appBarTheme: const AppBarTheme(
              elevation: 0,
              color: Colors.white,
              centerTitle: true,
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
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        // home: const BeVipScreen(),
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

// main2() {
//   Person a = Person(id: 1, name: 'abdallah');
//   Person b = Person(id: 1, name: 'abdallah');
//   print(a == b); //
// }
//
// class Person {
//   final int id;
//   final String name;
//
//   Person({required this.id, required this.name});
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Person &&
//           runtimeType == other.runtimeType &&
//           name == other.name &&
//           id == other.id;
// }

///flutter build apk --no-tree-shake-icons
/// flutter build apk --debug
