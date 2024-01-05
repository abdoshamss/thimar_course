import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/design/widgets/input.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';
import 'package:thimar_course/core/widgets/map.dart';
import 'package:thimar_course/core/widgets/selectable_item.dart';
import 'package:thimar_course/generated/locale_keys.g.dart';
import '../core/widgets/custom_appbar.dart';
import '../features/get_adresses/bloc.dart';
import '../gen/assets.gen.dart';

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
    required this.lng,
    required this.id,
  }) : super(key: key);

  @override
  State<AddAddressesScreen> createState() => _AddAddressesScreenState();
}

class _AddAddressesScreenState extends State<AddAddressesScreen> {
  final _formKey = GlobalKey<FormState>();

  final _bloc = KiwiContainer().resolve<AddressesBloc>();

  @override
  Widget build(BuildContext context) {
    if (CacheHelper.getLanguage() == "en") {
      switch (widget.type) {
        case "المنزل":
          widget.type = "home";
          break;
        case "العمل":
          widget.type = "work";
          break;
      }
    }
    final phoneController = TextEditingController(
        text: widget.phone.isNotEmpty ? widget.phone : "");
    final describeController = TextEditingController(
        text: widget.describe.isNotEmpty ? widget.describe : "");
    return Scaffold(
      appBar: CustomAppBar(
        text: LocaleKeys.addresses_add_address.tr(),
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
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.r),
                    child: Container(
                      padding: EdgeInsets.all(10.r),
                      height: 55.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13.r),
                          border: Border.all(color: const Color(0xffF3F3F3))),
                      child: Row(
                        children: [
                          Text(
                            LocaleKeys.addresses_address_type.tr(),
                            style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              SelectableItem(
                                  LocaleKeys.addresses_work.tr(),
                                  widget.type == "المنزل" ||
                                      widget.type == "home", () {
                                setState(() {
                                  if (CacheHelper.getLanguage() == "en") {
                                    widget.type = "home";
                                  } else {
                                    widget.type = "المنزل";
                                  }
                                });
                              }),
                              SizedBox(
                                width: 8.w,
                              ),
                              SelectableItem(
                                  LocaleKeys.addresses_home.tr(),
                                  widget.type == "العمل" ||
                                      widget.type == "work", () {
                                setState(() {
                                  if (CacheHelper.getLanguage() == "en") {
                                    widget.type = "work";
                                  } else {
                                    widget.type = "العمل";
                                  }
                                });
                              })
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Input(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.log_in_please_enter_your_mobile_number.tr();
                      } else if (value.length < 9) {
                        return LocaleKeys.log_in_please_enter_nine_number.tr();
                      }
                      return null;
                    },
                    labelText:LocaleKeys.log_in_phone_number.tr(),
                    controller: phoneController,
                    inputType: InputType.phone,
                    saudiIcon: false,
                    textInputAction: TextInputAction.next,
                  ),
                  Input(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.addresses_please_enter_description.tr();
                      }
                      return null;
                    },
                    labelText:  LocaleKeys.addresses_description.tr(),
                    controller: describeController,
                    inputType: InputType.normal,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 48.h,
                  ),
                  AppButton(
                    text:LocaleKeys.addresses_add_address.tr(),
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        if (widget.phone.isEmpty) {
                          _bloc.add(AddAddressesDataEvent(
                            type: widget.type,
                            phone: phoneController.text,
                            description: describeController.text,
                            lat: double.parse(
                                CacheHelper.getLatitude().toString()),
                            lng: double.parse(
                                CacheHelper.getLongitude().toString()),
                          ));
                          debugPrint(widget.id.toString());
                          phoneController.clear();
                          describeController.clear();
                        } else {
                          _bloc.add(EditAddressesDataEvent(
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

    );
  }
}
