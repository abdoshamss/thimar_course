import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/design/widgets/input.dart';
import 'package:thimar_course/core/widgets/custom_appbar.dart';
import 'package:thimar_course/gen/assets.gen.dart';
import 'package:thimar_course/screens/profile.dart';
import '../../core/design/widgets/btn.dart';
import '../../core/logic/helper_methods.dart';
import '../../features/auth/edit_password/bloc.dart';
import '../../generated/locale_keys.g.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({Key? key}) : super(key: key);

  @override
  State<EditPasswordScreen> createState() => _ChangePasswordStateScreen();
}

class _ChangePasswordStateScreen extends State<EditPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bloc = KiwiContainer().resolve<EditPasswordBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(text: LocaleKeys.change_password_change_password.tr()),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Input(
                      backgroundColor: true,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return LocaleKeys
                              .change_password_please_enter_your_old_password_again_at_least_six_letters
                              .tr();
                        }
                        return null;
                      },
                      controller: _bloc.oldPasswordController,
                      labelText: LocaleKeys.change_password_old_password.tr(),
                      iconPath: Assets.icons.password.path,
                      inputType: InputType.password,
                      textInputAction: TextInputAction.done,
                    ),
                    Input(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return LocaleKeys
                              .reset_password_please_enter_new_password_in_6_letters_at_min
                              .tr();
                        }
                        return null;
                      },
                      controller: _bloc.newPasswordController,
                      labelText: LocaleKeys.reset_password_new_password.tr(),
                      iconPath: Assets.icons.password.path,
                      inputType: InputType.password,
                      textInputAction: TextInputAction.done,
                      backgroundColor: true,
                    ),
                    Input(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return LocaleKeys
                              .reset_password_please_enter_new_password_again
                              .tr();
                        } else if (value != _bloc.newPasswordController.text) {
                          return LocaleKeys
                              .change_password_two_passwords_not_matching
                              .tr();
                        }
                        return null;
                      },
                      controller: _bloc.confirmNewPasswordController,
                      labelText:
                          LocaleKeys.reset_password_confirm_new_password.tr(),
                      iconPath: Assets.icons.password.path,
                      inputType: InputType.password,
                      textInputAction: TextInputAction.done,
                      backgroundColor: true,
                    ),
                  ],
                )),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.r),
        child: BlocConsumer(
          bloc: _bloc,
          listener: (context, state) {
            if (state is EditPasswordSuccessState) {}
            navigateTo(const EditProfileDetailsScreen());
          },
          builder: (context, state) {
            return AppButton(
                isLoading: state is EditPasswordLoadingState,
                text: LocaleKeys.change_password_change_password.tr(),
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    _bloc.add(PostEditPasswordDataEvent());
                  }
                });
          },
        ),
      ),
    );
  }
}
