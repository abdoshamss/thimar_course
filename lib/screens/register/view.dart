import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';
import 'package:thimar_course/features/get_cities/cubit.dart';
import 'package:thimar_course/screens/register/cubit.dart';
import 'package:thimar_course/screens/register/states.dart';

import '../../core/design/widgets/btn.dart';
import '../../core/design/widgets/input.dart';
import '../../features/get_cities/states.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int cityId = 0;

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
                      'يمكنك تسجيل حساب جديد الان',
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
                    // controller: cubit.fullNameController,
                    labelText: 'اسم المستخدم',
                    iconPath: 'assets/icons/person.jpg',
                    textInputAction: TextInputAction.done,
                  ),
                  Input(
                    // controller: cubit.phoneController,
                    labelText: 'رقم الجوال',
                    inputType: InputType.phone,
                    iconPath: 'assets/icons/flag.jpg',
                  ),
                 Input(
                        labelText: "المدينة",
                        onTap: () async {
                          var result = await showModalBottomSheet(
                            context: context,
                            builder: (context) => BlocProvider(
                              create: (BuildContext context) =>
                                  GetCitiesScreenCubit()..getCities(),
                              child: BlocBuilder<GetCitiesScreenCubit,
                                      GetCitiesScreenStates>(
                                  builder: (context, state) {
                                if (state is GetCitiesScreenLoadingState) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  );
                                } else if (state
                                    is GetCitiesScreenSuccessState) {
                                  return Container(
                                    padding: EdgeInsets.all(16.r),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        const Text("Select Your City"),
                                        const Center(
                                          child: SizedBox(
                                            height: 16,
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
                                                          cityId = state
                                                              .list[i].id;
                                                          Navigator.pop(
                                                              context,
                                                              state.list[i]
                                                                  .name);
                                                        },
                                                        child: Container(
                                                            width: double
                                                                .infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor
                                                                  .withOpacity(
                                                                      .1),
                                                            ),
                                                            margin: EdgeInsets
                                                                .only(
                                                                    bottom: 16
                                                                        .h),
                                                            padding:
                                                                EdgeInsets
                                                                    .all(
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
                              }),
                            ),
                            useSafeArea: true,
                          );
                          if (result != null) {
                            // cubit.cityController.text = result;
                            print(result);
                          }
                        },
                        // controller: cubit.cityController,
                      ),

                  Input(
                    // controller: cubit.passwordController,
                    labelText: 'كلمة المرور',
                    iconPath: 'assets/icons/password.jpg',
                    inputType: InputType.password,
                    textInputAction: TextInputAction.done,
                  ),
                  Input(
                    // controller: cubit.passwordConfirmController,
                    labelText: 'تأكيد كلمة المرور',
                    iconPath: 'assets/icons/password.jpg',
                    inputType: InputType.password,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
                 return Btn(text: 'تسجيل', onPress: () {


                 });  },),
                  const SizedBox(
                    height: 34,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'لديك حساب بالفعل',
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // cubit.register();
                        },
                        child: const Text(
                          'تسجيل الدخول ',
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

  }
}
