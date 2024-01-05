import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

import '../../../features/get_adresses/bloc.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../screens/add_address.dart';
import '../../logic/helper_methods.dart';

class BottomSheetInHomeAppBar extends StatefulWidget {
  const BottomSheetInHomeAppBar({Key? key}) : super(key: key);

  @override
  State<BottomSheetInHomeAppBar> createState() => _BottomSheetInHomeAppBarState();
}

class _BottomSheetInHomeAppBarState extends State<BottomSheetInHomeAppBar> {
  final bloc = KiwiContainer().resolve<AddressesBloc>()..add(GetAddressesDataEvent());
  @override
  void dispose() {


    super.dispose();
    bloc.close();
  }
  @override
  Widget build(BuildContext context) {
    return   SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 16.r),
              child: Center(
                child: Text(
                  LocaleKeys.home_addresses.tr(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            BlocBuilder(
              bloc: bloc,
              builder: (BuildContext context, state) {
               if (bloc.addressesList.isNotEmpty) {
                  return Column(
                    children: [
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: bloc.addressesList.length,
                          itemBuilder:
                              (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w),
                                width: 345.w,
                                height: 100.h,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(15.r),
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .primaryColor,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black
                                              .withOpacity(.02),
                                          offset: const Offset(0, 6))
                                    ]),
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          bloc.addressesList[index]
                                              .type,
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "${LocaleKeys.home_address.tr()} : ${bloc.addressesList[index].location}",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight:
                                              FontWeight.w400),
                                        ),
                                        Text(
                                          bloc.addressesList[index]
                                              .description,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .hintColor,
                                              fontWeight:
                                              FontWeight.w400),
                                        ),
                                        Text(
                                          bloc.addressesList[index]
                                              .phone,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .hintColor,
                                              fontWeight:
                                              FontWeight.w400),
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
                                              bloc.add(
                                                  RemoveAddressesDataEvent(
                                                      index: index,
                                                      id: bloc
                                                          .addressesList[
                                                      index]
                                                          .id,
                                                      type: bloc
                                                          .addressesList[
                                                      index]
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
                                              navigateTo(
                                                  AddAddressesScreen(
                                                    id: bloc
                                                        .addressesList[
                                                    index]
                                                        .id,
                                                    phone: bloc
                                                        .addressesList[
                                                    index]
                                                        .phone,
                                                    describe: bloc
                                                        .addressesList[
                                                    index]
                                                        .description,
                                                    type: bloc
                                                        .addressesList[
                                                    index]
                                                        .type,
                                                    lat: bloc
                                                        .addressesList[
                                                    index]
                                                        .lat,
                                                    lng: bloc
                                                        .addressesList[
                                                    index]
                                                        .lng,
                                                  ));
                                            },
                                            child: Image.asset(
                                              Assets.icons.editAddress
                                                  .path,
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
                }else  if (bloc.addressesList.isEmpty) {
                 return Padding(
                   padding: EdgeInsets.all(8.0.r),
                   child: const Center(
                     child: Text("لا توجد بيانات"),
                   ),
                 );
               }    else if (state is GetAddressesLoadingState) {
                  return loadingWidget();
                }
                return const SizedBox.shrink();
              },
            ),
            GestureDetector(
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
                      LocaleKeys.home_add_addresses.tr(),
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
          ],
        ),
      ),
    );
  }
}
