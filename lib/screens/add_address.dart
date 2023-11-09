import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/design/widgets/input.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';
import 'package:thimar_course/core/widgets/map.dart';
import 'package:thimar_course/core/widgets/selectable_item.dart';

import '../core/design/widgets/icon_with_bg.dart';
import '../features/adresss/get_adresses/bloc.dart';

class AddAddressesScreen extends StatefulWidget {
  final int id;
  final String phone;
  final String describe;

  double lat;
  double lng;

  String type;
  AddAddressesScreen({
    Key? key,
    required this.phone,
    required this.describe,
    this.type = "المنزل",
     required this.lat,
    required  this.lng,
   required this.id,
  }) : super(key: key);

  @override
  State<AddAddressesScreen> createState() => _AddAddressesScreenState();
}

class _AddAddressesScreenState extends State<AddAddressesScreen> {
  // String type = "المنزل";
  // bool isActive = true;

  final formKey = GlobalKey<FormState>();

  final bloc = KiwiContainer().resolve<GetAddressesBloc>();

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController(
        text: widget.phone.isNotEmpty ? widget.phone : "");
    final describeController = TextEditingController(
        text: widget.describe.isNotEmpty ? widget.describe : "");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "اضافة عنوان",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leadingWidth: 60.w,
        leading: Padding(
          padding: EdgeInsetsDirectional.only(start: 16.r),
          child: IconWithBg(
            icon: Icons.arrow_back_ios_outlined,
            color: Theme.of(context).primaryColor,
            onPress: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
              width: double.infinity,
              height: 400.h,
              child: MapItem(
                lat: widget.lat,
                lng: widget.lng,
              )),
          Padding(
            padding: EdgeInsets.all(16.0.r),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.r),
                    child: Container(
                      padding: EdgeInsets.all(10.r),
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13.r),
                          border: Border.all(color: const Color(0xffF3F3F3))),
                      child: Row(
                        children: [
                          Text(
                            "نوع العنوان",
                            style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              SelectableItem('المنزل', widget.type == "المنزل",
                                  () {
                                setState(() {
                                  widget.type = "المنزل";
                                });
                              }),
                              // GestureDetector(
                              //   onTap: () {
                              //     setState(() {
                              //       widget.type = "المنزل";
                              //     });
                              //   },
                              //   child: Container(
                              //     height: 40.h,
                              //     width: 70.w,
                              //     decoration: BoxDecoration(
                              //         color: widget.type == "المنزل"
                              //             ? Theme.of(context).primaryColor
                              //             : null,
                              //         borderRadius:
                              //             BorderRadius.circular(11.r)),
                              //     child: Center(
                              //       child: Text(
                              //         "المنزل",
                              //         style: TextStyle(
                              //           color: widget.type == "المنزل"
                              //               ? Colors.white
                              //               : Theme.of(context).primaryColor,
                              //           fontSize: 15.sp,
                              //           fontWeight: FontWeight.w300,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(
                                width: 8.w,
                              ),

                              SelectableItem('العمل', widget.type == "العمل",
                                  () {
                                setState(() {
                                  widget.type = "العمل";
                                });
                              })
                              // GestureDetector(
                              //   onTap: () {
                              //     setState(() {
                              //       widget.type = "العمل";
                              //     });
                              //   },
                              //   child: Container(
                              //     height: 40.h,
                              //     width: 70.w,
                              //     decoration: BoxDecoration(
                              //         color: widget.type == "المنزل"
                              //             ? null
                              //             : Theme.of(context).primaryColor,
                              //         borderRadius:
                              //             BorderRadius.circular(11.r)),
                              //     child: Center(
                              //       child: Text(
                              //         "العمل",
                              //         style: TextStyle(
                              //           color: widget.type == "المنزل"
                              //               ? Theme.of(context).primaryColor
                              //               : Colors.white,
                              //           fontSize: 15.sp,
                              //           fontWeight: FontWeight.w300,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Input(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "برجاء ادخال رقم الجوال";
                      } else if (value.length < 9) {
                        return "بالرجاء ادخال ٩ ارقام";
                      }
                      return null;
                    },
                    labelText: "أدخل رقم الجوال",
                    controller: phoneController,
                    inputType: InputType.phone,
                    saudiIcon: false,
                    textInputAction: TextInputAction.next,
                  ),
                  Input(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "برجاء ادخال الوصف";
                      }
                      return null;
                    },
                    labelText: "الوصف",
                    controller: describeController,
                    inputType: InputType.normal,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 48.h,
                  ),
                  AppButton(
                    text: "إضافة العنوان",
                    onPress: () {
                      if (formKey.currentState!.validate()) {
                        if (widget.phone.isEmpty) {
                          bloc.add(AddAddressesDataEvent(
                            type: widget.type,
                            phone: phoneController.text,
                            description: describeController.text,
                            lat: double.parse(CacheHelper.getLatitude().toString()),
                            lng:  double.parse(CacheHelper.getLongitude().toString()),
                          ));
                          debugPrint(widget.id.toString());
                          phoneController.clear();
                          describeController.clear();
                        } else {
                          bloc.add(EditAddressesDataEvent(
                              id: widget.id, type: widget.type));
                          debugPrint(widget.id.toString());
                          phoneController.clear();
                          describeController.clear();
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the my Location'),
      //   icon: const Icon(Icons.location_on),
      // ),
    );
  }
}
