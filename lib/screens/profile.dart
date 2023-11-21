import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';
import 'package:thimar_course/features/edit_profile/cubit.dart';
import 'package:thimar_course/features/edit_profile/states.dart';

import '../core/design/widgets/input.dart';
import '../core/widgets/custom_appbar.dart';
import '../features/auth/get_cities/bloc.dart';
import '../gen/assets.gen.dart';

class EditProfileDetailsScreen extends StatefulWidget {
  const EditProfileDetailsScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileDetailsScreen> createState() =>
      _EditProfileDetailsScreenState();
}

class _EditProfileDetailsScreenState extends State<EditProfileDetailsScreen> {
  File? selectedImage;

  var nameController = TextEditingController(text: CacheHelper.getFullName());

  var phoneController = TextEditingController(text: CacheHelper.getPhone());

  var cityController = TextEditingController(text: CacheHelper.getCity());

  var passwordController = TextEditingController();

  int cityId = CacheHelper.getCityId();

  final citiesBloc = KiwiContainer().resolve<GetCitiesScreenBLoc>()
    ..add(GetCitiesScreenDataEvent());

  final bloc = KiwiContainer().resolve<EditProfileCubit>();
  @override
  void dispose() {

    super.dispose();
    bloc.close();

    citiesBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarScreen(
          text: "البيانات الشخصية", image: Assets.icons.backHome.path),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          Center(
            child: Container(
              height: 85.h,
              width: 85.h,
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
              child: StatefulBuilder(
                builder: (BuildContext context,
                    void Function(void Function()) setState) {
                  return Stack(
                    children: [
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(.32),
                          BlendMode.darken,
                        ),
                        child: selectedImage != null
                            ? Image.file(
                                selectedImage!,
                                height: 85.h,
                                width: 85.h,
                                fit: BoxFit.fill,
                              )
                            : Image.network(
                                CacheHelper.getImage(),
                                fit: BoxFit.fill,
                                height: 85.h,
                                width: 85.h,
                              ),
                      ),
                      Center(
                        child: IconButton(
                          onPressed: () async {
                            final image2 = await ImagePicker.platform.pickImage(
                              source: ImageSource.gallery,
                              imageQuality: 30,
                            );
                            if (image2 != null) {
                              selectedImage = File(image2.path);
                              debugPrint(image2.path);
                            }
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Center(
                child: Text(
              "Abdo Shamss",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
              ),
            )),
          ),
          Center(
              child: Text(
            "+01033429389",
            style: TextStyle(
              color: Theme.of(context).hintColor,
              fontWeight: FontWeight.bold,
              fontSize: 17.sp,
            ),
          )),
          SizedBox(
            height: 8.h,
          ),
          Input(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'بالرجاء ادخال اسمك بالكامل';
              }
              return null;
            },
            controller: nameController,
            labelText: "اسم المستحدم",
          ),
          Input(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'بالرجاء ادخال رقم الجوال';
              }
              return null;
            },
            controller: phoneController,
            labelText: "رقم الجوال",
            inputType: InputType.phone,
          ),
          StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return Input(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'بالرجاء ادخال مدينتك';
                  }
                  return null;
                },
                iconPath: "assets/icons/flag.jpg",
                labelText: "المدينة",
                enable: () async {
                  var result = await showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(38.r),
                            topRight: Radius.circular(38.r))),
                    context: context,
                    builder: (context) => BlocBuilder(
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
                                            (index) => GestureDetector(
                                                  onTap: () {
                                                    cityId =
                                                        state.list[index].id;
                                                    Navigator.pop(context, [
                                                      state.list[index].name,
                                                      state.list[index].id
                                                    ]);
                                                  },
                                                  child: Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColor
                                                            .withOpacity(.1),
                                                      ),
                                                      margin: EdgeInsets.only(
                                                          bottom: 16.h),
                                                      padding:
                                                          EdgeInsets.all(16.r),
                                                      child: Center(
                                                          child: Text(state
                                                              .list[index]
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
                    useSafeArea: true,
                  );
                  if (result != null) {
                    cityController.text = result;
                    debugPrint(result);
                  }
                },
                controller: cityController,
              );
            },
          ),
          Input(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'بالرجاء ادخال كلمة المرور';
              }
              return null;
            },
            labelText: "كلمة المرور",
            inputType: InputType.password,
            enable: () {},
            controller: passwordController,
          ),

          // ElevatedButton(
          //   onPressed: () {
          //     showDialog(
          //       barrierDismissible: true,
          //       context: context,
          //       builder: (context) => SimpleDialog(
          //         title: const Text("Hello From Dialog"),
          //         children: [
          //           IconButton(
          //               onPressed: () {}, icon: const Icon(Icons.camera_alt)),
          //           IconButton(
          //               onPressed: () {}, icon: const Icon(Icons.camera_alt)),
          //         ],
          //       ),
          //     );
          //   },
          //   child: const Text("Show Dialog"),
          // ),
        ],
      ),
      bottomNavigationBar: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder(
                  bloc: bloc,
                  builder: (context, state) {
                    return AppButton(
                        text: "تعديل البيانات",
                        isLoading: State is EditProfileLoadingState,
                        onPress: () {
                          if (selectedImage != null) {
                            bloc.updateData(selectedImage!, nameController.text,
                                phoneController.text, cityId);
                          } else {
                            const Text("Failed");
                            debugPrint("Failed" * 20);
                          }
                        });
                  }))),
    );
  }
}
