import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/gen/assets.gen.dart';
import 'package:thimar_course/screens/auth/login.dart';
import 'package:thimar_course/screens/home/home_nav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), ()   {
      if (CacheHelper.getToken()!.isEmpty) {
        navigateTo(const LoginScreen());
      } else {
      navigateTo(const HomeNavScreen(), removeHistory: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.splashBackground.path),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 200.w,
            child: Stack(
              children: [
                Image.asset(
                  Assets.images.mainLogo.path,
                  height: 190.h,
                  width: 175.w,
                ),
                Positioned(
                  right: 70,
                  top: 5,
                  child: BounceInDown(
                    child: Image.asset(
                      Assets.images.topLeaves.path,
                      height: 30.h,
                      width: 45.w,
                    ),
                  ),
                ),
                Positioned(
                  top: 70,
                  right: 100,
                  child: FlipInY(
                    child: Image.asset(
                      Assets.images.sideLeaves.path,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
