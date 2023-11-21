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
                  'أدخل كلمة المرور الجديدة',
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
                              return 'بالرجاء ادخال كلمة المرور الجديدة من ٦ حروف';
                            }
                            return null;
                          },
                          controller: bloc.newPasswordController,
                          labelText: 'كلمة المرور الجديدة',
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
                              return 'بالرجاء ادخال كلمة المرور الجديدة مجددا';
                            }
                            return null;
                          },
                          controller: bloc.confirmNewPasswordController,
                          labelText: 'تأكيد كلمة المرور الجديدة',
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
                    debugPrint(widget.code);
                    if (state is ResetPasswordSuccessState) {}
                    navigateTo(const LoginScreen());
                  },
                  builder: (context, state) {
                    return AppButton(
                        isLoading: state is ResetPasswordLoadingState,
                        text: 'تغيير كلمة المرور',
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
