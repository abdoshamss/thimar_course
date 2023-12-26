import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/core/widgets/map.dart';
import 'package:thimar_course/features/my_orders/cancel_order/bloc.dart';
import 'package:thimar_course/features/my_orders/my_orders_details/bloc.dart';
import 'package:thimar_course/gen/assets.gen.dart';
import '../core/widgets/custom_appbar.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int id;
  final bool isCancel;
  final String status;
  const OrderDetailsScreen(
      {Key? key,
      required this.id,
      required this.isCancel,
      required this.status})
      : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final bloc = KiwiContainer().resolve<MyOrdersDetailsBloc>();
  final cancelOrderBloc = KiwiContainer().resolve<CancelOrderBloc>();
  @override
  void initState() {
    super.initState();
    bloc.add(GetMyOrdersDetailsDataEvent(id: widget.id));
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
    cancelOrderBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarScreen(
        image: Assets.icons.backHome.path,
        text: "تفاصيل الطلب",
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: BlocBuilder(
          bloc: bloc,
          builder: (BuildContext context, state) {
            if (state is MyOrdersDetailsLoadingState) {
              return loadingWidget();
            } else if (state is MyOrdersDetailsSuccessState) {
              Color color = const Color(0xffEDF5E6);
              Color statusColor = Theme.of(context).primaryColor;
              String status = widget.status;

              switch (status) {
                case "in_way":
                case "في الطريق":
                  color = const Color(0xffEDF5E6);
                  statusColor = Theme.of(context).primaryColor;
                  status = "في الطريق";
                  break;
                case "canceled":
                case "طلب ملغي":
                  color = const Color(0xffFFE4E4);
                  statusColor = Colors.red;
                  status = "طلب ملغي";
                  break;
                case "pending":
                case "بإنتظار الموافقة":
                  color = const Color(0xffEDF5E6);
                  statusColor = Theme.of(context).primaryColor;
                  status = "بإنتظار الموافقة";
                  break;
              }
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
                                  "طلب #${state.list.list.id}",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.0.r),
                                  child: Text(
                                    state.list.list.date,
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
                                      color: color,
                                      borderRadius: BorderRadius.circular(8.r)),
                                  child: Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.w),
                                      child: Text(
                                        status,
                                        style: TextStyle(
                                          color: statusColor,
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
                                    "${state.list.list.stringTotalPrice}ر.س",
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
                            height: .2.h,
                          ),
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                SizedBox(
                                  width: 85.w,
                                  height: 25.h,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        state.list.list.products.length >= 3
                                            ? 3
                                            : state.list.list.products.length,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      width: 4.w,
                                    ),
                                    itemBuilder: (context, indexImages) =>
                                        Container(
                                      width: 25.w,
                                      height: 25.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7.r),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                state.list.list
                                                    .products[indexImages].url,
                                              ),
                                              fit: BoxFit.fill)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                if (state.list.list.products.length > 3)
                                  Container(
                                    height: 25.h,
                                    width: 25.w,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffEDF5E6),
                                      borderRadius: BorderRadius.circular(7.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        state.list.list.products.length > 3
                                            ? "${state.list.list.products.length - 3}+"
                                            : "0+",
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                              ]),
                            ]),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  if (state.list.list.address.lat != 0.0 &&
                      state.list.list.address.lng != 0.0)
                    Text(
                      "عنوان التوصيل",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (state.list.list.address.lat != 0.0 &&
                      state.list.list.address.lng != 0.0)
                    SizedBox(
                      height: 16.h,
                    ),
                  if (state.list.list.address.lat != 0.0 &&
                      state.list.list.address.lng != 0.0)
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
                                state.list.list.address.type,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp),
                              ),
                              Text(
                                state.list.list.address.location,
                                style: TextStyle(
                                    color: const Color(0xff999797),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp),
                              ),
                              Text(
                                state.list.list.address.description,
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            width: 75.w,
                            height: 65.h,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: MapItem(
                              lat: state.list.list.address.lat,
                              lng: state.list.list.address.lng,
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
                              "${state.list.list.stringPriceBeforeDiscount}ر.س",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "الخصم",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp),
                            ),
                            Text(
                              "${state.list.list.stringDiscount}ر.س",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0.r),
                          child: const Divider(
                            thickness: 2,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "الاجمالي بعد خصم المنتجات",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp),
                            ),
                            Text(
                              "${state.list.list.stringOrderPrice}ر.س",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp),
                            ),
                          ],
                        ),SizedBox(
                          height: 8.h,
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
                              "${state.list.list.stringDeliveryPrice}ر.س",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp),
                            ),
                          ],
                        ),SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "خصم عميل مميز",
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp),
                            ),
                            Text(
                              "-${state.list.list.stringVipDiscount}ر.س",
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0.r),
                          child: const Divider(
                            thickness: 2,
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
                              "${state.list.list.stringTotalPrice}.س",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0.r),
                          child: const Divider(
                            thickness: 2,
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
                            state.list.list.payType=="cash"?  Assets.icons.money.path:  Assets.images.visa.path,
                              width: state.list.list.payType=="cash"?70.w:50.w,
                              height:state.list.list.payType=="cash"? 30.h:15.h,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  if (widget.isCancel)
                    BlocConsumer(
                      bloc: cancelOrderBloc,
                      listener: (context, state) {
                        if (state is CancelOrderSuccessState) {
                          Navigator.pop(context, true);
                        }
                      },
                      builder: (context, state) {
                        return Center(
                          child: AppButton(
                              isLoading: state is CancelOrderLoadingState,
                              text: "إلغاء الطلب",
                              onPress: () {
                                cancelOrderBloc.add(
                                    PostCancelOrderDataEvent(id: widget.id));
                              },
                              type: BtnType.cancel),
                        );
                      },
                    ),
                  if (!widget.isCancel)
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
