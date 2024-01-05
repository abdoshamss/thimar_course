import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/features/edit_profile/bloc.dart';
import 'package:thimar_course/screens/auth/edit_password.dart';

import '../core/design/widgets/input.dart';
import '../core/widgets/custom_appbar.dart';
import '../features/auth/get_cities/bloc.dart';
import '../gen/assets.gen.dart';
import '../generated/locale_keys.g.dart';

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

  final citiesBloc = KiwiContainer().resolve<GetCitiesScreenBLoc>();

  final bloc = KiwiContainer().resolve<EditProfileBloc>();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
    citiesBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: LocaleKeys.my_account_personal_data.tr(),
        value: true,
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
                    void Function(void Function()) setState2) {
                  return Stack(
                    children: [
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(.32),
                          BlendMode.darken,
                        ),
                        child: selectedImage == null
                            ? Image.network(
                                CacheHelper.getImage(),
                                fit: BoxFit.fill,
                                height: 85.h,
                                width: 85.h,
                              )
                            : Image.file(
                                selectedImage!,
                                height: 85.h,
                                width: 85.h,
                                fit: BoxFit.fill,
                              ),
                      ),
                      Center(
                        child: IconButton(
                          onPressed: () async {
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(38.r),
                                      topRight: Radius.circular(38.r))),
                              builder: (context) => Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Padding(
                                  padding: EdgeInsets.all(16.r),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Icon(Icons.close),
                                          Text(
                                            LocaleKeys.profile_select_image_from
                                                .tr(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 32.r,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              final image2 = await ImagePicker
                                                  .platform
                                                  .pickImage(
                                                source: ImageSource.gallery,
                                                imageQuality: 30,
                                              );
                                              if (image2 != null) {
                                                selectedImage =
                                                    File(image2.path);
                                                debugPrint(image2.path);
                                                Navigator.pop(navigatorKey
                                                    .currentContext!);
                                              }
                                              setState2(() {});
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.image_rounded,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                Text(LocaleKeys.profile_gallery
                                                    .tr()),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              final image2 = await ImagePicker
                                                  .platform
                                                  .pickImage(
                                                source: ImageSource.camera,
                                                imageQuality: 30,
                                              );
                                              if (image2 != null) {
                                                selectedImage =
                                                    File(image2.path);
                                                debugPrint(image2.path);
                                                Navigator.pop(context);
                                              }
                                              setState2(() {});
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.camera_alt,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                Text(LocaleKeys.profile_camera
                                                    .tr()),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  CacheHelper.getFullName().isEmpty
                      ? LocaleKeys.my_account_user_name.tr()
                      : CacheHelper.getFullName(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                if (CacheHelper.getIsVip() == 1)
                  Image.asset(
                    Assets.icons.vip.path,
                    width: 25.w,
                    height: 25.h,
                  ),
              ],
            ),
          ),
          Center(
              child: Text(
            "${CacheHelper.getPhone()}+",
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
            backgroundColor: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.register_please_enter_full_name.tr();
              }
              return null;
            },
            controller: nameController,
            labelText: LocaleKeys.register_user_name.tr(),
          ),
          Input(
            backgroundColor: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.log_in_please_enter_your_mobile_number.tr();
              }
              return null;
            },
            controller: phoneController,
            labelText: LocaleKeys.log_in_phone_number.tr(),
            inputType: InputType.phone,
          ),
          StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState3) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 280.w,
                    child: Input(
                      backgroundColor: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.register_please_enter_your_city
                              .tr();
                        }
                        return null;
                      },
                      iconPath: Assets.icons.flag.path,
                      labelText: LocaleKeys.register_city.tr(),
                      enable: () async {
                        citiesBloc.add(GetCitiesScreenDataEvent());
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
                                } else if (state
                                    is GetCitiesScreenSuccessState) {
                                  return Container(
                                    padding: EdgeInsets.all(16.r),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(LocaleKeys
                                            .register_choose_your_city
                                            .tr()),
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
                                                  (index) => GestureDetector(
                                                        onTap: () {
                                                          cityId = state
                                                              .list[index].id;
                                                          Navigator.pop(
                                                            context,
                                                            state.list[index]
                                                                .name,
                                                          );
                                                        },
                                                        child: Container(
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor
                                                                  .withOpacity(
                                                                      .1),
                                                            ),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                        16.h),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    16.r),
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
                                  return Text(
                                      LocaleKeys.register_something_wrong.tr());
                                }
                              }),
                          useSafeArea: true,
                        );
                        if (result != null) {
                          debugPrint(result);
                          cityController.text = result;
                        }
                      },
                      controller: cityController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: IconButton(
                        onPressed: () {
                          CacheHelper.removeCityName();
                          cityController.text = "";
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 26,
                        )),
                  ),
                ],
              );
            },
          ),
          Input(
            backgroundColor: true,
            isEnabled: true,
            enable: () {
              navigateTo(const EditPasswordScreen());
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                LocaleKeys.log_in_please_enter_your_password_again.tr();
              }
              return null;
            },
            backIcon: true,
            labelText: LocaleKeys.log_in_password.tr(),
            inputType: InputType.password,
            controller: passwordController,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(16.r),
          child: BlocBuilder(
              bloc: bloc,
              builder: (context, state) {
                return AppButton(
                    text: LocaleKeys.profile_edit_data.tr(),
                    isLoading: State is EditProfileLoadingState,
                    onPress: () async {
                      if (selectedImage != null) {
                        await CacheHelper.setImage(selectedImage!.path);
                        bloc.add(PostEditProfileDataEvent(
                            image: selectedImage!,
                            name: nameController.text,
                            cityId: cityId,
                            phone: phoneController.text));
                      } else {
                        showMessage(LocaleKeys.profile_please_add_photo.tr());
                      }
                      setState(() {});
                    });
              })),
    );
  }
}
