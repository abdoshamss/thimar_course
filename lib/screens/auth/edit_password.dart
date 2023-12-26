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

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({Key? key}) : super(key: key);

  @override
  State<EditPasswordScreen> createState() => _ChangePasswordStateScreen();
}

class _ChangePasswordStateScreen extends State<EditPasswordScreen> {
  final formKey = GlobalKey<FormState>();
final bloc =KiwiContainer().resolve<EditPasswordBloc>();
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: CustomAppBarScreen(text: "تغيير كلمة المرور", image: Assets.icons.backHome.path),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.r),
      child: Column(
        children: [
          Form(
              key: formKey,
              child: Column(
                children: [
                  Input(backgroundColor: true,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length < 6) {
                        return 'بالرجاء ادخال كلمة المرور من ٦ حروف';
                      }
                      return null;
                    },
                    controller: bloc.oldPasswordController,
                    labelText: 'كلمة المرور القديمة',
                    iconPath: Assets.icons.password.path,
                    inputType: InputType.password,
                    textInputAction: TextInputAction.done,
                  ),  Input(
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
                    textInputAction: TextInputAction.done,backgroundColor: true,
                  ),
                  Input(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length < 6
                         ) {
                        return 'بالرجاء ادخال كلمة المرور الجديدة مجددا';
                      }else if( value != bloc.newPasswordController.text){
                        return "كلمتان السر غير متطابقتان";
                      }
                      return null;
                    },
                    controller: bloc.confirmNewPasswordController,
                    labelText: 'تأكيد كلمة المرور الجديدة',
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
        child:        BlocConsumer(
          bloc: bloc,
          listener: (context, state) {

            if (state is EditPasswordSuccessState) {}
            navigateTo(const EditProfileDetailsScreen());
          },
          builder: (context, state) {
            return AppButton(
                isLoading: state is EditPasswordLoadingState,
                text: 'تغيير كلمة المرور',
                onPress: () {
                  if (formKey.currentState!.validate()) {
                    bloc.add(PostEditPasswordDataEvent());
                  }
                });
          },
        ),
      ),
    );

  }
}
