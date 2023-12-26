import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/gen/assets.gen.dart';
import 'package:thimar_course/generated/locale_keys.g.dart';
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
                  LocaleKeys.forget_password_forget_password.tr(),
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  LocaleKeys.forget_password_enter_your_phone_number.tr(),
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
                        return LocaleKeys.log_in_please_enter_your_mobile_number.tr();
                      } else if (value.length < 9) {
                        return LocaleKeys.log_in_please_enter_nine_number.tr();
                      }
                      return null;
                    },
                    controller: bloc.phoneController,
                    labelText: LocaleKeys.log_in_phone_number.tr(),
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
                          text: LocaleKeys.forget_password_confirm_phone_number.tr(),
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
                          text: LocaleKeys.forget_password_you_have_an_account.tr(),
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => navigateTo(const LoginScreen()),
                          text: LocaleKeys.my_account_log_in.tr(),
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
