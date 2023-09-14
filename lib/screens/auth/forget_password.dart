import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/gen/assets.gen.dart';
import 'package:thimar_course/screens/auth/check_code.dart';
import '../../core/design/widgets/btn.dart';
import '../../core/design/widgets/input.dart';
import '../../core/logic/helper_methods.dart';
import '../../features/auth/forget_password/bloc.dart';
import 'login.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);



  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
    final bloc = KiwiContainer().resolve<ForgetPasswordBloc>();
    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.close();
  }
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.r),
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
                  'نسيت كلمة المرور',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  'أدخل رقم الجوال المرتبط بحسابك',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 27.h,
                ),
                Form(
                  key: formKey,
                  child: Input(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'بالرجاء ادخال رقم هاتفك';
                      } else if (value.length < 9) {
                        return "بالرجاء ادخال ٩ ارقام علي الاقل";
                      }
                      return null;
                    },
                    controller: bloc.phoneController,
                    labelText: 'رقم الجوال',
                    inputType: InputType.phone,
                    iconPath: Assets.icons.phone.path,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                BlocConsumer(
                  bloc: bloc,
                  listener: (BuildContext context, state) {
                    if (state is ForgetPasswordSuccessState) {
                      navigateTo(
                        CheckCodeScreen(
                          phone: bloc.phoneController.text,
                        ),
                      );
                    }
                  },
                  builder: (BuildContext context, Object? state) {
                    return Center(
                      child: AppButton(
                          isLoading: state is ForgetPasswordLoadingState,
                          text: 'تأكيد رقم الجوال ',
                          onPress: () {
                            if (formKey.currentState!.validate()) {
                              bloc.add(PostForgetPasswordDataEvent());
                            }
                          }),
                    );
                  },
                ),
                SizedBox(
                  height: 48.h,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'لديك حساب بالفعل؟',
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
          ],
        ),
      ),
    );
  }
}
