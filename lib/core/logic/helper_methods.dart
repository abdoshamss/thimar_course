import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/widgets/toast.dart';
import 'package:thimar_course/generated/locale_keys.g.dart';
import 'package:thimar_course/screens/auth/login.dart';

final navigatorKey = GlobalKey<NavigatorState>();
// Future<dynamic> push(String named, {dynamic arguments, NavigatorAnimation? type}) {
//   return Navigator.of(navigatorKey.currentContext!).push(SlideRight(named: named, arguments: arguments, type: type));
// }
// Future navigateTo(Widget page, {bool removeHistory = false}) async {
//   return Navigator.pushAndRemoveUntil(
//     navigatorKey.currentContext!,
//     MaterialPageRoute(
//       builder: (context) => page,
//     ),
//     (route) => !removeHistory,
//   );
// }

// Future navigateToWithAnimation(Widget page,
//     {bool removeHistory = false}) async {
//   return Navigator.pushAndRemoveUntil(
//     navigatorKey.currentContext!,
//     PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) => page,
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           const begin = Offset(0.0, 1.0);
//           const end = Offset.zero;
//           const curve = Curves.fastOutSlowIn;
//
//           final tween = Tween(begin: begin, end: end);
//           final curvedAnimation = CurvedAnimation(
//             parent: animation,
//             curve: curve,
//           );
//
//           return SlideTransition(
//             position: tween.animate(curvedAnimation),
//             // position: animation.drive(tween),
//             child: child,
//           );
//         }),
//     (route) => !removeHistory,
//   );
// }
Future navigateTo(Widget page, {bool removeHistory = false}) async {
  return Navigator.pushAndRemoveUntil(
    navigatorKey.currentContext!,
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
    ),
    (route) => !removeHistory,
  );
}

enum MessageType {
  warning,
  success,
  error,
}

//    getLocation(double lat, double lng) async {
//
//   List<Placemark> placeMarks = await placemarkFromCoordinates(lat, lng);
//   print(placeMarks.toString());
//   print("1" * 80);
//   print(placeMarks[0].subAdministrativeArea.toString());
//
//   return placeMarks[0].subAdministrativeArea.toString();
// }

void showMessage(String message,
    {MessageType messageType = MessageType.success}) {
  if (message.isNotEmpty) {
    Color bgColor = Colors.green;
    if (messageType == MessageType.warning) {
      bgColor = Colors.yellow;
    } else if (messageType == MessageType.error) {
      bgColor = Colors.red;
    }

    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
        padding: EdgeInsets.all(16.r),
        backgroundColor: bgColor,

        shape: const StadiumBorder(),
        behavior: SnackBarBehavior.floating,
        content: Center(
            child: Text(
          message,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ))));
    // ToastView.createView(message  , navigatorKey.currentContext!, 3, 3, bgColor, Colors.black, 16.r, Border.all());
  }
}

AwesomeDialog dialog() => AwesomeDialog(
      context: navigatorKey.currentContext!,
      animType: AnimType.scale,
      dialogType: DialogType.question,
      body: Center(
        child: Text(
          LocaleKeys.login_first.tr(),
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      btnOk: AppButton(
        text: LocaleKeys.cancel.tr(),
        onPress: () {
          Navigator.pop(navigatorKey.currentContext!);
        },
        type: BtnType.cancel,
        isBig: false,
      ),
      btnCancel: AppButton(
        text: LocaleKeys.my_account_log_in.tr(),
        onPress: () {
          navigateTo(const LoginScreen());
        },
        isBig: false,
      ),
    )..show();
Widget loadingWidget() => const Center(
      child: CircularProgressIndicator(),
    );
Widget noInternet() => Center(
      child: Text(LocaleKeys.no_internet.tr()),
    );
Future<void> getMaps(double lat, double lng) async {
  final availableMaps = await MapLauncher.installedMaps;
  print(availableMaps);
  if (await MapLauncher.isMapAvailable(MapType.google) ?? false) {
    await availableMaps.first.showMarker(
      coords: Coords(lat, lng),
      title: "test",
    );
  }
}

///  Platform  Firebase App Id
// android   1:563451404729:android:7c1a21beea852083c89668
// ios       1:563451404729:ios:81d9cb784ba2b783c89668
