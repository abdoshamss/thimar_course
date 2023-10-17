import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/gen/assets.gen.dart';
import 'package:thimar_course/screens/auth/account_activation.dart';
import 'package:thimar_course/screens/auth/login.dart';

import '../../core/design/res/colors.dart';
import '../../core/design/widgets/btn.dart';
import '../../core/design/widgets/input.dart';
import '../../features/auth/get_cities/bloc.dart';
import '../../features/auth/register/bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
    final bloc = KiwiContainer().resolve<RegisterBloc>();
    final citiesBloc = KiwiContainer().resolve<GetCitiesScreenBLoc>()..add(GetCitiesScreenDataEvent());
    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.close();
    citiesBloc.close();
  }
  @override
  Widget build(BuildContext context) {
    int? cityId;
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
            Form(
              key: formKey,
              child: Column(
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
                    'يمكنك تسجيل حساب جديد الان',
                    style: TextStyle(
                      // color: ,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400, color: secondaryColorText,
                    ),
                  ),
                  SizedBox(
                    height: 21.h,
                  ),
                  Input(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'بالرجاء ادخال اسمك بالكامل';
                      }
                      return null;
                    },
                    controller: bloc.fullNameController,
                    labelText: 'اسم المستخدم',
                    iconPath: Assets.icons.user.path,
                    textInputAction: TextInputAction.done,
                  ),
                  Input(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'بالرجاء ادخال رقم هاتفك';
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
                    controller: bloc.cityController,
                    isEnabled: false,
                    iconPath: Assets.icons.flag.path,
                    labelText: "المدينة",
                    enable: () async {
                      var result = await showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(38.r),
                                topRight: Radius.circular(38.r))),
                        context: context,
                        builder: (context) => BlocConsumer(
                          listener: (BuildContext context, Object? state) {},
                          bloc: citiesBloc,
                          builder: (context, state) {
                            if (state is GetCitiesScreenLoadingState) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                ),
                              );
                            } else if (state is GetCitiesScreenSuccessState) {
                              return Container(
                                padding: EdgeInsets.all(16.r),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    const Text("اختر مدينتك"),
                                    Center(
                                      child: SizedBox(
                                        height: 16.h,
                                      ),
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: List.generate(
                                              state.list.length,
                                              (i) => GestureDetector(
                                                    onTap: () {
                                                      cityId = state.list[i].id;
                                                      Navigator.pop(context,
                                                          state.list[i].name);
                                                    },
                                                    child: Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor
                                                              .withOpacity(.1),
                                                        ),
                                                        margin: EdgeInsets.only(
                                                            bottom: 16.h),
                                                        padding: EdgeInsets.all(
                                                            16.r),
                                                        child: Center(
                                                            child: Text(state
                                                                .list[i]
                                                                .name))),
                                                  )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return const Text("SomeThing Wrong");
                            }
                          },
                        ),
                        useSafeArea: true,
                      );
                      if (result != null) {
                        bloc.cityController.text = result;
                      }
                    },
                    validator: (value) {
                      if (bloc.cityController.text.isEmpty ||
                          cityId == null ||
                          value!.isEmpty) {
                        return 'بالرجاء ادخال مدينتك';
                      }
                      return null;
                    },
                  ),
                  Input(
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'بالرجاء ادخال كلمة السر';
                      }
                      return null;
                    },
                    controller: bloc.passwordController,
                    labelText: 'كلمة المرور',
                    iconPath: Assets.icons.password.path,
                    inputType: InputType.password,
                    textInputAction: TextInputAction.done,
                  ),
                  Input(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length < 6 ||
                          value != bloc.passwordController.text) {
                        return 'بالرجاء ادخال كلمة السر مجددا';
                      }
                      return null;
                    },
                    controller: bloc.passwordConfirmController,
                    labelText: 'تأكيد كلمة المرور',
                    iconPath: Assets.icons.password.path,
                    inputType: InputType.password,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  BlocConsumer(
                    bloc: bloc,
                    listener: (context, state) {
                      if (state is RegisterSuccessState) {
                        navigateTo(AccountActivationScreen(
                          phone: bloc.phoneController.text,
                        ));
                      }
                    },
                    builder: (context, state) {
                      return Center(
                        child: AppButton(
                          text: 'تسجيل',
                          isLoading: state is RegisterLoadingState,
                          onPress: () {
                            if (formKey.currentState!.validate()) {
                              bloc.add(PostRegisterDataEvent());
                            }
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 34.h,
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
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
