import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/design/res/colors.dart';
import 'package:thimar_course/gen/assets.gen.dart';

import '../../core/design/widgets/btn.dart';
import '../../core/design/widgets/input.dart';
import '../../core/logic/helper_methods.dart';
import '../../features/auth/reset_password/bloc.dart';
import '../../generated/locale_keys.g.dart';
import 'login.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String phone, code;
  const ResetPasswordScreen({Key? key, required this.phone, required this.code})
      : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final bloc = KiwiContainer().resolve<ResetPasswordBloc>();
  @override
  void dispose() {

    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    bloc.phone = widget.phone;
    bloc.code = widget.code;
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
                  LocaleKeys.reset_password_new_password.tr(),
                  style: TextStyle(
                      color: secondaryColorText,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Input(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 6) {
                              return LocaleKeys.reset_password_please_enter_new_password_in_6_letters_at_min.tr();
                            }
                            return null;
                          },
                          controller: bloc.newPasswordController,
                          labelText: LocaleKeys.reset_password_new_password.tr(),
                          iconPath: Assets.icons.password.path,
                          inputType: InputType.password,
                          textInputAction: TextInputAction.done,
                        ),
                        Input(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 6 ||
                                value != bloc.newPasswordController.text) {
                              return LocaleKeys.reset_password_please_enter_new_password_again.tr();
                            }
                            return null;
                          },
                          controller: bloc.confirmNewPasswordController,
                          labelText: LocaleKeys.reset_password_confirm_new_password.tr(),
                          iconPath: Assets.icons.password.path,
                          inputType: InputType.password,
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 8.h,
                ),
                BlocConsumer(
                  bloc: bloc,
                  listener: (context, state) {

                    if (state is ResetPasswordSuccessState) {}
                    navigateTo(const LoginScreen());
                  },
                  builder: (context, state) {
                    return AppButton(
                        isLoading: state is ResetPasswordLoadingState,
                        text: LocaleKeys.reset_password_change_password.tr(),
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            bloc.add(PostResetPasswordDataEvent());
                          }
                        });
                  },
                ),
                SizedBox(
                  height: 48.sp,
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
