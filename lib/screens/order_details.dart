import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/core/widgets/map.dart';
import 'package:thimar_course/features/my_orders/my_orders_details/bloc.dart';
import 'package:thimar_course/gen/assets.gen.dart';

import '../core/design/widgets/icon_with_bg.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int id;
  final bool typeButton;
  const OrderDetailsScreen(
      {Key? key, required this.id, required this.typeButton})
      : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final bloc = KiwiContainer().resolve<MyOrdersDetailsBloc>();
  @override
  void initState() {
    super.initState();
    bloc.add(GetMyOrdersDetailsDataEvent(id: widget.id));
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "تفاصيل الطلب",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leadingWidth: 60.w,
        leading: Padding(
          padding: EdgeInsetsDirectional.only(start: 16.w),
          child: IconWithBg(
            icon: Icons.arrow_back_ios_outlined,
            color: Theme.of(context).primaryColor,
            onPress: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: BlocBuilder(
          bloc: bloc,
          builder: (BuildContext context, state) {
            if (state is MyOrdersDetailsLoadingState) {
              loadingWidget();
            } else if (state is MyOrdersDetailsSuccessState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.r),
                    width: 345.w,
                    height: 115.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.02),
                              offset: const Offset(0, 6))
                        ]),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "طلب #${state.list.data.id}",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.0.r),
                                  child: Text(
                                    state.list.data.date,
                                    style: TextStyle(
                                      color: const Color(0xff9C9C9C),
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffEDF5E6),
                                      borderRadius: BorderRadius.circular(8.r)),
                                  child: Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.w),
                                      child: Text(
                                        state.list.data.status,
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 8.r,
                                  ),
                                  child: Text(
                                    "${state.list.data.orderPrice}ر.س",
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Divider(
                            color: const Color(0xffF3F3F3),
                            height: .2.h,
                          ),
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: List.generate(
                                  state.list.data.products.length,
                                  (indexImages) => Container(
                                    width: 25.w,
                                    height: 25.h,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                      state.list.data.products[indexImages].url,
                                    ))),
                                  ),
                                ),
                              ),
                              // Container(
                              //   height: 25.h,
                              //   width: 25.w,
                              //   decoration: BoxDecoration(
                              //     color: const Color(0xffEDF5E6),
                              //     borderRadius:
                              //     BorderRadius.circular(7.r),
                              //   ),
                              //   child: Center(
                              //     child: Text(
                              //       "+2",
                              //       style: TextStyle(
                              //         fontSize: 11.sp,
                              //         fontWeight: FontWeight.bold,
                              //         color: Theme.of(context)
                              //             .primaryColor,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              const Spacer(),
                              Container(
                                padding: EdgeInsets.all(6.r),
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.13),
                                    borderRadius: BorderRadius.circular(9.r)),
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Theme.of(context).primaryColor,
                                  size: 20,
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "عنوان التوصيل",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(8.r),
                    width: 345.w,
                    height: 85.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.02),
                              offset: const Offset(0, 6))
                        ]),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.list.data.address.type,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp),
                            ),
                            Text(
                              state.list.data.address.location,
                              style: TextStyle(
                                  color: const Color(0xff999797),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.sp),
                            ),
                            Text(
                              state.list.data.address.description,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 12.sp),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          width: 75.w,
                          height: 65.h,
                          child: MapItem(
                            lat: state.list.data.address.lat,
                            lng: state.list.data.address.lng,
                            lightMode: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    'ملخص الطلب',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(8.r),
                    height: 150.h,
                    width: 345.w,
                    decoration: BoxDecoration(
                      color: const Color(0xffF3F8EE),
                      borderRadius: BorderRadius.circular(13.r),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "إجمالي المنتجات",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp),
                            ),
                            Text(
                              "${state.list.data.orderPrice}ر.س",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "سعر التوصيل",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp),
                            ),
                            Text(
                              "${state.list.data.discount}ر.س",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Divider(
                            color: const Color(0xffF3F3F3),
                            height: .2.h,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "المجموع",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp),
                            ),
                            Text(
                              "${state.list.data.totalPrice}.س",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Divider(
                            color: const Color(0xffF3F3F3),
                            height: .2.h,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "تم الدفع بواسطة",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp),
                            ),
                            Image.asset(
                              Assets.images.visa.path,
                              width: 50.w,
                              height: 15.h,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  if (widget.typeButton)
                    AppButton(
                        text: "إلغاء الطلب",
                        onPress: () {},
                        type: BtnType.cancel),
                  if (!widget.typeButton)
                    AppButton(
                      text: "تقييم المنتجات",
                      onPress: () {},
                    ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
