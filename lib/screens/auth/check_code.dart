import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/features/auth/resend_code/bloc.dart';
import 'package:thimar_course/gen/assets.gen.dart';
import 'package:thimar_course/screens/auth/login.dart';
import 'package:thimar_course/screens/auth/register.dart';
import 'package:thimar_course/screens/auth/reset_password.dart';
import '../../core/design/widgets/btn.dart';
import '../../features/auth/check_code/bloc.dart';

class CheckCodeScreen extends StatefulWidget {
  final String phone;
  const CheckCodeScreen({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  State<CheckCodeScreen> createState() => _CheckCodeScreenState();
}

class _CheckCodeScreenState extends State<CheckCodeScreen> {
  bool isTimerRunning = true;

  final bloc = KiwiContainer().resolve<CheckCodeBloc>();
  final resendCodeBloc = KiwiContainer().resolve<ResendCodeBloc>();
@override
  void dispose() {
    // TODO: implement dispose
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
            Column(children: [
              Image.asset(
                Assets.images.logo.path,
                height: 150.h,
                width: 150.w,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'نسيت كلمة المرور',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'أدخل الكودالمكون من 4 أرقام المرسل علي رقم الجوال',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                children: [
                  Text(
                    bloc.phone,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateTo(const RegisterScreen());
                    },
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
              BlocConsumer(
                bloc: bloc,
                listener: (context, state) {
                  if (state is CheckCodeSuccessState) {
                    return navigateTo(ResetPasswordScreen(
                        phone: widget.phone, code: bloc.codeController.text));
                  }
                },
                builder: (BuildContext context, state) {
                  return AppButton(
                      isLoading: state is CheckCodeLoadingState,
                      text: 'تأكيد الكود',
                      onPress: () {
                        debugPrint(bloc.codeController.text);
                        if (formKey.currentState!.validate()) {
                          bloc.add(PostCheckCodeDataEvent());
                        }
                      });
                },
              ),
              SizedBox(
                height: 34.h,
              ),
              if (isTimerRunning)
                Column(
                  children: [
                    Text(
                      'لم تستلم الكود ؟',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      'يمكنك اعادة ارسال الكود بعد',
                      textAlign: TextAlign.center,
                      style: TextStyle(
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
              if (!isTimerRunning)
                BlocBuilder(
                  bloc: resendCodeBloc,
                  builder: (BuildContext context, state) => AppButton(
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
