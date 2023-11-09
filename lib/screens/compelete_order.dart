import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/design/widgets/input.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';
import 'package:thimar_course/gen/assets.gen.dart';
import 'package:thimar_course/screens/add_address.dart';

import '../core/logic/helper_methods.dart';
import '../core/widgets/custom_appbar.dart';
import '../features/adresss/get_adresses/bloc.dart';
import '../features/compelete_order/bloc.dart';

class CompleteOrderScreen extends StatefulWidget {
  final String? coupon;
  final double discount;
  final double totalPrice;

  const CompleteOrderScreen(
      {Key? key,
      required this.coupon,
      required this.discount,
      required this.totalPrice})
      : super(key: key);

  @override
  State<CompleteOrderScreen> createState() => _CompleteOrderScreenState();
}

class _CompleteOrderScreenState extends State<CompleteOrderScreen> {
  final addressesBloc = KiwiContainer().resolve<GetAddressesBloc>();
  final bloc = KiwiContainer().resolve<CompleteOrderBloc>();

  AddressModel? selectedAddress;
  TimeOfDay? time;
  DateTime? date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarScreen(
        text: 'إتمام الطلب',
        image: Assets.icons.backHome.path,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          Text(
            "الإسم : ${CacheHelper.getFullName()}",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
                color: Theme.of(context).primaryColor),
          ),
          Text(
            "الجوال : ${CacheHelper.getPhone()}",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
                color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 36.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "اختر عنوان التوصيل",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                    color: Theme.of(context).primaryColor),
              ),
              GestureDetector(
                onTap: () {
                  navigateTo(AddAddressesScreen(
                    phone: CacheHelper.getPhone(),
                    describe: "",
                    lat: 0.0,
                    lng: 0.0,
                    id: 0,
                  ));
                },
                child: Image.asset(
                  Assets.icons.addBackground.path,
                  width: 26.w,
                  height: 26.h,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Container(
            height: 35.h,
            width: 340.w,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17.r),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                )),
            child: GestureDetector(
              onTap: () {
                addressesBloc.add(GetAddressesDataEvent());
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(38.r),
                          topRight: Radius.circular(38.r))),
                  context: context,
                  builder: (context) => SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16.0.r),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 16.r),
                            child: Center(
                              child: Text(
                                "العناوين",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          BlocBuilder(
                            bloc: addressesBloc,
                            builder: (BuildContext context, state) {
                              if (addressesBloc.addressesList.isNotEmpty) {
                                return Column(
                                  children: [
                                    ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          addressesBloc.addressesList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) =>
                                              Padding(
                                        padding: EdgeInsets.only(bottom: 16.r),
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
                                              GestureDetector(
                                                onTap: () {
                                                  selectedAddress =
                                                      addressesBloc
                                                          .addressesList[index];
                                                  Navigator.pop(
                                                    context,
                                                  );
                                                  setState(() {});
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      addressesBloc
                                                          .addressesList[index]
                                                          .type,
                                                      style: TextStyle(
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                    Text(
                                                      "العنوان : ${addressesBloc.addressesList[index].location}",
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      addressesBloc
                                                          .addressesList[index]
                                                          .description,
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .hintColor,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      addressesBloc
                                                          .addressesList[index]
                                                          .phone,
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .hintColor,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
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
                                                        addressesBloc.add(
                                                            RemoveAddressesDataEvent(
                                                                index: index,
                                                                id: addressesBloc
                                                                    .addressesList[
                                                                        index]
                                                                    .id,
                                                                type: addressesBloc
                                                                    .addressesList[
                                                                        index]
                                                                    .type));

                                                        setState(() {});
                                                      },
                                                      child: Image.asset(
                                                        Assets
                                                            .icons.remove.path,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 8.w,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        navigateTo(
                                                            AddAddressesScreen(
                                                          phone: addressesBloc
                                                              .addressesList[
                                                                  index]
                                                              .phone,
                                                          describe: addressesBloc
                                                              .addressesList[
                                                                  index]
                                                              .description,
                                                          type: addressesBloc
                                                              .addressesList[
                                                                  index]
                                                              .type,
                                                          lat: addressesBloc
                                                              .addressesList[
                                                                  index]
                                                              .lat,
                                                          lng: addressesBloc
                                                              .addressesList[
                                                                  index]
                                                              .lng,
                                                          id: addressesBloc
                                                              .addressesList[
                                                                  index]
                                                              .id,
                                                        ));
                                                        debugPrint(
                                                            "object" * 34);
                                                        debugPrint(addressesBloc
                                                            .addressesList[
                                                                index]
                                                            .lat
                                                            .toString());
                                                        debugPrint(addressesBloc
                                                            .addressesList[
                                                                index]
                                                            .lng
                                                            .toString());
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
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        navigateTo(AddAddressesScreen(
                                          phone: '',
                                          describe: '',
                                          lng: 0.0,
                                          lat: 0.0,
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
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "إضافة عنوان",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else if (state is GetAddressesLoadingState) {
                                loadingWidget();
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedAddress == null
                        ? "اختر عنوان التوصيل"
                        : "المكان : ${selectedAddress!.location}",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Image.asset(
                    selectedAddress == null
                        ? Assets.icons.addBackground.path
                        : Assets.icons.arrowDown.path,
                    width: 26.w,
                    height: 26.h,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 36.h,
          ),
          Text(
            "تحديد وقت التوصيل",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
                color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2024),
                  );

                  debugPrint(date.toString());
                },
                child: Container(
                  width: 165.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: const Color(0xffF3F3F3))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "اختر اليوم والتاريخ",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Image.asset(
                        Assets.icons.clock.path,
                        width: 18.w,
                        height: 18.h,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                },
                child: Container(
                  width: 165.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: const Color(0xffF3F3F3))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "اختر الوقت",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Image.asset(
                        Assets.icons.calender.path,
                        width: 18.w,
                        height: 18.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 24.h,
          ),
          Text(
            "ملاحظات وتعليمات",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
                color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 4.h,
          ),
          Input(
            validator: (value) {
              return null;
            },
            inputType: InputType.normal,
            maxLines: 5,
          ),
          SizedBox(
            height: 24.h,
          ),
          Text(
            "اختر طريقة الدفع",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
                color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 98.w,
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.r),
                    border: Border.all(color: Theme.of(context).primaryColor)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      Assets.icons.money.path,
                      height: 25.h,
                      width: 30.w,
                    ),
                    Text(
                      "كاش",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              Container(
                width: 98.w,
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.r),
                    border: Border.all(
                      color: const Color(0xffE9E9E9),
                    )),
                child: Center(
                  child: Image.asset(Assets.icons.visaPay.path),
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              Container(
                width: 98.w,
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.r),
                    border: Border.all(
                      color: const Color(0xffE9E9E9),
                    )),
                child: Center(
                  child: Image.asset(Assets.icons.mastercard.path),
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            "ملخص الطلب",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
                color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 8.h,
          ),
          Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                height: 145.h,
                decoration: BoxDecoration(
                  color: const Color(0xffF3F8EE),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 76.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "الخصم",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "-${widget.discount}ر.س",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Divider(
                        height: .5.h,
                        color: const Color(0xffE2E2E2),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "المجموع",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${widget.totalPrice}ر.س",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              BlocBuilder(
                bloc: bloc,
                builder: (BuildContext context, state) {
                  return AppButton(
                      text: "إنهاء الطلب",
                      onPress: () {
                        bloc.add(PostCompleteOrderDataEvent(
                          time: time!,
                          date: date!,
                          addressId: selectedAddress?.id,
                          coupon: widget.coupon,
                        ));
                      });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
