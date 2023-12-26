import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/gen/assets.gen.dart';
import 'package:thimar_course/screens/auth/login.dart';
import 'package:thimar_course/screens/auth/register.dart';

class AppLogin extends StatelessWidget {
  const AppLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Image.asset(
          Assets.images.loginImg.path,
          width: 250.w,
          height: 250.h,
        ),
        Text(
          "انضم الينا لتري لعرض حميع الخدمات",
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            AppButton(
              text: "تسجيل الدخول",
              onPress: () {  navigateTo(const LoginScreen());},
              isBig: false,
            ),AppButton(
              text: "تسجيل",
              onPress: () {
                navigateTo(const RegisterScreen());
              },

              isBig: false,
            )
          ],
        )
      ],
    );
  }
}
