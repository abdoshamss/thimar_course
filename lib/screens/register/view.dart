import 'package:flutter/material.dart';

import '../../core/design/widgets/btn.dart';
import '../../core/design/widgets/input.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'يمكنك تسجيل حساب جديد الان',
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
                  labelText: 'اسم المستخدم',
                  iconPath: 'assets/icons/phone.jpg',

                  textInputAction: TextInputAction.done,
                ),
                const Input(
                  labelText: 'رقم الجوال',
                  inputType: InputType.phone,
                  iconPath: 'assets/icons/phone.jpg',
                  maxLength: 11,
                ), const Input(
                  labelText: 'المدينة',
                  iconPath: 'assets/icons/phone.jpg',

                  textInputAction: TextInputAction.done,
                ),
                const Input(
                  labelText: 'كلمة المرور',
                  iconPath: 'assets/icons/phone.jpg',
                  inputType: InputType.password,
                  textInputAction: TextInputAction.done,
                ),const Input(
                  labelText: 'تأكيد كلمة المرور',
                  iconPath: 'assets/icons/phone.jpg',
                  inputType: InputType.password,
                  textInputAction: TextInputAction.done,
                ),

                Btn(text: 'تسجيل', onPress: () {}),
                const SizedBox(
                  height: 34,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'لديك حساب بالفعل',
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
