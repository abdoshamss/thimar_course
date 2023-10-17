import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/design/res/colors.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/design/widgets/input.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/gen/assets.gen.dart';
import 'package:thimar_course/screens/auth/forget_password.dart';
import 'package:thimar_course/screens/auth/register.dart';
import '../../features/auth/login/bloc.dart';
import '../home/home_nav.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bloc = KiwiContainer().resolve<LoginBLoc>();
  @override
  void dispose() {
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
                  'مرحبا بك مرة اخري',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  'يمكنك تسجيل الدخول الان',
                  style: TextStyle(
                      // color: ,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: secondaryColorText),
                ),
                SizedBox(
                  height: 27.h,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Input(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'بالرجاء ادخال رقم الجوال';
                          } else if (value.length < 9) {
                            return 'بالرجاء ادخال ٩ ارقام';
                          }
                          return null;
                        },
                        controller: bloc.phoneController,
                        labelText: 'رقم الجوال',
                        inputType: InputType.phone,

                        iconPath: Assets.icons.phone.path,
                      ),
                      Input(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'بالرجاء ادخال كلمة السر';
                          } else if (value.length < 6) {
                            return 'بالرجاء ادخال ٦ حروف علي الاقل';
                          }
                          return null;
                        },
                        controller: bloc.passwordController,
                        labelText: 'كلمة المرور',
                        iconPath: Assets.icons.password.path,
                        inputType: InputType.password,
                        textInputAction: TextInputAction.done,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                GestureDetector(
                  onTap: () {
                    navigateTo(const ForgetPasswordScreen());
                  },
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'نسيت كلمة المرور ؟',
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                BlocConsumer(
                    listener: (context, state) {
                      if (state is LoginSuccessState) {
                        debugPrint("*******${CacheHelper.getToken()}**********");
                        navigateTo(const HomeNavScreen(), removeHistory: true);
                      }
                    },
                    bloc: bloc,
                    builder: (context, state) {
                      return Center(
                        child: AppButton(
                            isLoading: state is LoginLoadingState,
                            text: 'تسجيل الدخول',
                            onPress: () {
                              if (formKey.currentState!.validate()) {
                                bloc.add(PostLoginDataEvent());
                              }
                            }),
                      );
                    }),
                SizedBox(
                  height: 48.h,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'ليس لديك حساب ؟',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => navigateTo(const RegisterScreen()),
                          text: '  تسجيل الان ',
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
