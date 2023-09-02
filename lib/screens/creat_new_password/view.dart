import 'package:flutter/material.dart';

import '../../core/design/widgets/btn.dart';
import '../../core/design/widgets/input.dart';

class CreatNewPasswordScreen extends StatelessWidget {
  const CreatNewPasswordScreen({Key? key}) : super(key: key);

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
                    'نسيت كلمة المرور',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'أدخل كلمة المرور الجديدة',
                    style: TextStyle(
                      // color: ,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 27,
                ),
                const Input(
                  labelText: 'كلمة المرور الجديدة',
                  iconPath: 'assets/icons/phone.jpg',
                  inputType: InputType.password,
                  textInputAction: TextInputAction.done,

                ),const Input(
                  labelText: 'تأكيد كلمة المرور الجديدة',
                  iconPath: 'assets/icons/phone.jpg',
                  inputType: InputType.password,
                  textInputAction: TextInputAction.done,

                ),
                Btn(text: 'تغيير كلمة المرور', onPress: () {}),
                const SizedBox(
                  height: 34,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'لديك حساب بالفعل؟',
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'تسجيل الدخول ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
