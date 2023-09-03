import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/design/widgets/input.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/screens/login/cubit.dart';
import 'package:thimar_course/screens/login/states.dart';
import 'package:thimar_course/screens/profile/view.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: Builder(builder: (context) {
        LoginCubit cubit = BlocProvider.of(context);
        return Scaffold(
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.jpg',
                      height: 150,
                      width: 150,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'مرحبا بك مرة اخري',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'يمكنك تسجيل الدخول الان',
                        style: TextStyle(
                            // color: ,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 27,
                    ),
                    Input(
                      controller: cubit.phoneController,
                      labelText: 'رقم الجوال',
                      inputType: InputType.phone,
                      iconPath: 'assets/icons/phone.jpg',
                    ),
                    Input(
                      controller: cubit.passwordController,
                      labelText: 'كلمة المرور',
                      iconPath: 'assets/icons/password.jpg',
                      inputType: InputType.password,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'نسيت كلمة المرور ؟',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 21,
                    ),
                    BlocConsumer(
                        listener: (context, state) {
                          if (state is LoginSuccessState) {
                            navigateTo(  ProfileDetailsScreen());
                          }
                        },
                        bloc: cubit,
                        builder: (context, state) {
                          if (state is LoginLoadingState) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ),
                            );
                          }
                          return Btn(
                              text: 'تسجيل الدخول',

                              onPress: () {
                                cubit.postLogin( );
                              });
                        }),
                    const SizedBox(
                      height: 34,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ليس لديك حساب؟',
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'تسجيل الان ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
