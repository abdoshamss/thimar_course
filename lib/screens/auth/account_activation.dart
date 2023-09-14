import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:thimar_course/gen/assets.gen.dart';
import 'package:thimar_course/screens/auth/register.dart';

import '../../core/design/res/colors.dart';
import '../../core/design/widgets/btn.dart';
import '../../core/logic/helper_methods.dart';
import '../../features/auth/activation/bloc.dart';
import '../../features/auth/resend_code/bloc.dart';
import 'login.dart';

class AccountActivationScreen extends StatefulWidget {
  final String phone;

  const AccountActivationScreen({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  State<AccountActivationScreen> createState() =>
      _AccountActivationScreenState();
}

class _AccountActivationScreenState extends State<AccountActivationScreen> {
  bool isTimerRunning = true;
  final bloc = KiwiContainer().resolve<ActivationBloc>();
  final resendCodeBloc = KiwiContainer().resolve<ResendCodeBloc>();
  @override
  void dispose() {

    super.dispose();
  bloc.close();
  resendCodeBloc.close();
  }
  @override
  Widget build(BuildContext context) {


    bloc.phone = widget.phone;
    resendCodeBloc.phone = widget.phone;
    final timerController = CountDownController()..start();
    final formKey = GlobalKey<FormState>();

    return Scaffold(

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
              Image.asset(
               Assets.images.logo.path,
                height: 150.h,
                width: 150.w,
              ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Text(
                'تفعيل الحساب',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                'أدخل الكودالمكون من 4 أرقام المرسل علي رقم الجوال',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: secondaryColorText),
              ),
              SizedBox(
                height: 8.h,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.phone,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: secondaryColorText,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => navigateTo(const RegisterScreen()),
                      text: '  تغيير رقم الجوال ',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 27.h,
              ),
              Form(
                key: formKey,
                child: PinCodeTextField(
                  validator: (value) {
                    if (value!.isEmpty || value.length < 4) {
                      return "ادخل الكود";
                    }
                    return null;
                  },
                  appContext: context,
                  controller: bloc.codeController,
                  length: 4,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    selectedColor: Theme.of(context).primaryColor,
                    inactiveColor: Theme.of(context).unselectedWidgetColor,
                    borderRadius: BorderRadius.circular(15.r),
                    fieldHeight: 60,
                    fieldWidth: 70,
                    activeFillColor: Colors.white,
                  ),
                  cursorColor: Theme.of(context).primaryColor,
                  animationDuration: const Duration(milliseconds: 300),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                ),
              ),
              SizedBox(
                height: 21.h,
              ),
              BlocConsumer(
                bloc: bloc,
                listener: (context, state) {
                  if (state is ActivationAccountSuccessState) {
                     return navigateTo(const LoginScreen());
                  }
                },
                builder: (BuildContext context, state) {
                  return Center(
                    child: AppButton(
                        isLoading:
                            state is ActivationAccountLoadingState  ,
                        text: 'تأكيد الكود',
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            bloc.add(PostActivationAccountDataEvent());
                          }
                        }),
                  );
                },
              ),
              SizedBox(
                height: 32.h,
              ),
              if (isTimerRunning)
                Center(
                  child: Column(
                    children: [
                      Text(
                        'لم تستلم الكود ؟',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 16.sp, color: secondaryColorText),
                      ),
                      Text(
                        'يمكنك اعادة ارسال الكود بعد',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: secondaryColorText,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      StatefulBuilder(
                        builder: (BuildContext context,
                                void Function(void Function()) setStatex) =>
                            CircularCountDownTimer(
                          controller: timerController,
                          duration: 120,
                          width: 66.w,
                          height: 70.h,
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
                            fontSize: 21.0.sp,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          onComplete: () {
                            isTimerRunning = false;
                            setState(() {});
                          },
                          textFormat: CountdownTextFormat.MM_SS,
                          timeFormatterFunction:
                              (defaultFormatterFunction, duration) {
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
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              if (!isTimerRunning)
                Center(
                  child: AppButton(
                    text: 'أعادة الارسال',
                    onPress: () {
                      resendCodeBloc.add(PostResendCodeDataEvent());
                      isTimerRunning = true;
                      setState(() {});
                      timerController.restart(duration: 4);
                    },
                    type: BtnType.outline,
                  ),
                ),
            ]),
            SizedBox(
              height: 48.h,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'لديك حساب بالفعل ؟',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => navigateTo(const LoginScreen()),
                      text: '  تسجيل الدخول ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
