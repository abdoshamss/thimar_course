import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';
import 'package:thimar_course/features/edit_profile/cubit.dart';
import 'package:thimar_course/features/edit_profile/states.dart';
import 'package:thimar_course/features/get_cities/cubit.dart';
import 'package:thimar_course/features/get_cities/states.dart';

import '../../core/design/widgets/icon_with_bg.dart';
import '../../core/design/widgets/input.dart';

class ProfileDetailsScreen extends StatelessWidget {
  ProfileDetailsScreen({Key? key}) : super(key: key);

  File? selectedImage;
  var nameController = TextEditingController(text: CacheHelper.getFullName());
  var phoneController = TextEditingController(text: CacheHelper.getPhone());
  var cityController = TextEditingController(text: CacheHelper.getCity(),);
  var passwordController = TextEditingController(text: "HAHAHAH");
int cityId= CacheHelper.getCityId();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "البيانات الشخصية",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(start: 16),
          child: IconWithBg(
            icon: Icons.arrow_forward_ios_outlined,
            color: Theme.of(context).primaryColor,
            onPress: () {},
          ),
        ),
      ),
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
                              source: ImageSource.camera,
                              imageQuality: 30,
                            );
                            if (image2 != null) {
                              selectedImage = File(image2.path);
                              print(image2.path);
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
            controller: nameController,
            labelText: "اسم المستحدم",
          ),
          Input(
            controller: phoneController,
            labelText: "رقم الجوال",
            inputType: InputType.phone,
          ),
          StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return Input(
                labelText: "المدينة",
                onTap: () async {
                  var result = await showModalBottomSheet(
                    context: context,
                    builder: (context) => BlocProvider(
                      create: (BuildContext context) =>
                          GetCitiesScreenCubit()..getCities(),
                      child: BlocBuilder<GetCitiesScreenCubit,
                          GetCitiesScreenStates>(builder: (context, state) {
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

                                                  cityId =state.list[i].id;
                                                  Navigator.pop(
                                                      context,state.list[i].name);
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
                                                        child:
                                                            Text(state.list[i].name))),
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
                    cityController.text = result;
                    print(result);
                  }
                },
                controller: cityController,
              );
            },
          ),
          Input(
            labelText: "كلمة المرور",
            inputType: InputType.password,
            onTap: () {},
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
        child: BlocProvider(
          create: (BuildContext context)  =>EditProfileCubit(),
          child: BlocBuilder(
            bloc: EditProfileCubit(),
            builder: (context,state) {

              EditProfileCubit cubit=BlocProvider.of(context);
              return Btn(text: "تعديل البيانات",
                  isLoading: State is EditProfileLoadingState,
                  onPress: () {if(
                  selectedImage != null
                  ){

                    cubit.updateData(selectedImage!, nameController.text  , phoneController.text  , cityId);
                  }else{
                    const Text("Failed");
                    print("Failed"*20);
                  }

              });
            }
          ),
        ),
      )),
    );
  }
}
