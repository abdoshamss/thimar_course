import 'package:flutter/material.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/design/widgets/input.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/logo.jpg',
                  height: 150,
                  width: 150,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'مرحبا بك مرة اخري',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'يمكنك تسجيل الدخول الان',
                    style: TextStyle(
                        // color: ,
                      fontSize: 16,
                        ),
                  ),
                ),
                SizedBox(
                  height: 27,
                ),
                const Input(
                  labelText: 'رقم الجوال',
                  isPhone: true,
                  iconPath: 'assets/icons/phone.jpg',
                ),
                const Input(
                  labelText: 'كلمة المرور',
                  iconPath: 'assets/icons/phone.jpg',
                ),
                SizedBox(
                  height: 6,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'نسيت كلمة المرور ؟',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 21,
                ),
                Btn(text: 'تسجيل الدخول', onPress: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
