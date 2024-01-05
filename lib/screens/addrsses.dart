import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/design/widgets/app_empty.dart';
import 'package:thimar_course/generated/locale_keys.g.dart';

import '../core/logic/helper_methods.dart';
import '../core/widgets/custom_appbar.dart';
import '../features/get_adresses/bloc.dart';
import '../gen/assets.gen.dart';
import 'add_address.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({Key? key}) : super(key: key);

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  final bloc = KiwiContainer().resolve<AddressesBloc>()
    ..add(GetAddressesDataEvent());

  @override
  void dispose() {
    super.dispose();

    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: LocaleKeys.my_account_addresses.tr(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            BlocBuilder(
              bloc: bloc,
              builder: (BuildContext context, state) {
                if (state is GetAddressesLoadingState) {
                  return loadingWidget();
                } else if (bloc.addressesList.isNotEmpty) {
                  return Column(
                    children: [
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: bloc.addressesList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 16.r),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                width: 345.w,
                                height: 100.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                    border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(.02),
                                          offset: const Offset(0, 6))
                                    ]),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          bloc.addressesList[index].type,
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "${LocaleKeys.addresses_address.tr()} : ${bloc.addressesList[index].location}",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          bloc.addressesList[index].description,
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).hintColor,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          bloc.addressesList[index].phone,
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).hintColor,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16.h,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              bloc.add(RemoveAddressesDataEvent(
                                                  index: index,
                                                  id: bloc
                                                      .addressesList[index].id,
                                                  type: bloc
                                                      .addressesList[index]
                                                      .type));

                                              setState(() {});
                                            },
                                            child: Image.asset(
                                              Assets.icons.remove.path,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                              navigateTo(AddAddressesScreen(
                                                id: bloc
                                                    .addressesList[index].id,
                                                phone: bloc
                                                    .addressesList[index].phone,
                                                describe: bloc
                                                    .addressesList[index]
                                                    .description,
                                                type: bloc
                                                    .addressesList[index].type,
                                                lat: bloc
                                                    .addressesList[index].lat,
                                                lng: bloc
                                                    .addressesList[index].lng,
                                              ));
                                            },
                                            child: Image.asset(
                                              Assets.icons.editAddress.path,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ],
                  );
                }
                return Center(
                  child: AppEmpty(),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);

            navigateTo(AddAddressesScreen(
              phone: '',
              describe: '',
              lng: 0,
              lat: 0,
              id: 0,
            ));
          },
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(15.r),
            borderPadding: EdgeInsets.all(1.r),
            dashPattern: const [4, 4],
            color: Theme.of(context).primaryColor,
            child: Container(
              width: 345.w,
              height: 55.h,
              decoration: BoxDecoration(
                color: const Color(0xffF9FCF5),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Center(
                child: Text(
                  LocaleKeys.addresses_add_address.tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
