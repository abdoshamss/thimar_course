import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../core/design/widgets/btn.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({Key? key}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool isTimerRunning = true;

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
                    'أدخل الكودالمكون من 4 أرقام المرسل علي رقم الجوال',
                    style: TextStyle(
                        // color: ,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      '+9660548709',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'نغيير رقم الجوال',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 27,
                ),
                PinCodeTextField(
                  appContext: context,
                  length: 4,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    selectedColor: Theme.of(context).primaryColor,
                    inactiveColor: Theme.of(context).unselectedWidgetColor,
                    borderRadius: BorderRadius.circular(15),
                    fieldHeight: 60,
                    fieldWidth: 70,
                    activeFillColor: Colors.white,
                  ),
                  cursorColor: Theme.of(context).primaryColor,
                  animationDuration: const Duration(milliseconds: 300),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                ),
                Btn(text: 'تأكيد الكود', onPress: () {}),
                const SizedBox(
                  height: 34,
                ),
                const Text(
                  'لم تستلم الكود ؟',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Text(
                  'يمكنك اعادة ارسال الكود بعد',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if(isTimerRunning)
                CircularCountDownTimer(
                  duration: 60   ,
                  width: 66,
                  height: 70,
                  ringColor: Theme.of(context).unselectedWidgetColor,
                  ringGradient: null,
                  fillColor: Theme.of(context).primaryColor,
                  fillGradient: null,
                  backgroundColor: Colors.transparent,
                  backgroundGradient: null,
                  strokeWidth: 2.0,
                  isReverse: true,
                  strokeCap: StrokeCap.round,
                  textStyle: TextStyle(
                    fontSize: 21.0,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  onComplete: (){
isTimerRunning=false;
setState(() {

});
                },
                  textFormat: CountdownTextFormat.S,
                  timeFormatterFunction: (defaultFormatterFunction, duration) {
                    if (duration.inSeconds == 0) {
                      // only format for '0'
                      return "0";
                    } else {
                      // other durations by it's default format
                      return Function.apply(
                          defaultFormatterFunction, [duration]);
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Btn(
                  text: 'أعادة الارسال',
                  onPress: () {},
                  type: isTimerRunning
                      ? BtnType.outlineDisabled
                      : BtnType.outline,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ليس لديك حساب؟',
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'تسجيل الان ',
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
