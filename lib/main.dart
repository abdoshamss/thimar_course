import 'package:flutter/material.dart';
import 'package:thimar_course/core/design/res/colors.dart';
import 'package:thimar_course/screens/login/view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) =>
          Directionality(textDirection: TextDirection.rtl, child: child!),
      theme: ThemeData(
        primarySwatch: getMaterialColor(primaryColor.value),
        unselectedWidgetColor: Color(0xffF3F3F3),
      ),
      debugShowCheckedModeBanner: false,
      home: PageView(
        children: [
          LoginScreen(),
        ],
      ),
    );
  }
}
