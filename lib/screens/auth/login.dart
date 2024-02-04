import 'package:easy_localization/easy_localization.dart';
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
import 'package:thimar_course/generated/locale_keys.g.dart';
import 'package:thimar_course/screens/auth/forget_password.dart';
import 'package:thimar_course/screens/auth/register.dart';

import '../../features/auth/login/bloc.dart';
import '../home/view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _bloc = KiwiContainer().resolve<LoginBLoc>();

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          SizedBox(
            height: 16.h,
          ),
          Image.asset(
            Assets.images.logo.path,
            height: 150.h,
            width: 150.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.log_in_hello_again.tr(),
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.h),
              Text(
                LocaleKeys.log_in_you_can_login_now.tr(),
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: secondaryColorText),
              ),
              SizedBox(height: 27.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Input(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys
                              .log_in_please_enter_your_mobile_number
                              .tr();
                        } else if (value.length < 9) {
                          return LocaleKeys.log_in_please_enter_nine_number
                              .tr();
                        }
                        return null;
                      },
                      controller: _bloc.phoneController,
                      labelText: LocaleKeys.log_in_phone_number.tr(),
                      inputType: InputType.phone,
                      iconPath: Assets.icons.phone.path,
                    ),
                    Input(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys
                              .log_in_please_enter_your_password_again
                              .tr();
                        } else if (value.length < 6) {
                          return LocaleKeys
                              .log_in_please_enter_six_letters_at_min
                              .tr();
                        }
                        return null;
                      },
                      controller: _bloc.passwordController,
                      labelText: LocaleKeys.log_in_password.tr(),
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
                    LocaleKeys.log_in_forget_password.tr(),
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
                      navigateTo(HomeNavScreen(), removeHistory: true);
                    }
                  },
                  bloc: _bloc,
                  builder: (context, state) {
                    return Center(
                      child: AppButton(
                          isLoading: state is LoginLoadingState,
                          text: LocaleKeys.my_account_log_in.tr(),
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              _bloc.add(PostLoginDataEvent());
                            }
                          }),
                    );
                  }),
              SizedBox(
                height: 16.h,
              ),
              Center(
                child: AppButton(
                    text: LocaleKeys.log_in_login_as_visitor.tr(),
                    onPress: () {
                      navigateTo(HomeNavScreen());
                    }),
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
                        text: LocaleKeys.log_in_dont_have_an_account.tr(),
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => navigateTo(const RegisterScreen()),
                        text: LocaleKeys.log_in_register_now.tr(),
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
    );
  }
}
