import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thimar_course/core/design/widgets/app_login.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/generated/locale_keys.g.dart';

import '../../../features/my_orders/current/bloc.dart';
import '../../../features/my_orders/finished/bloc.dart';
import '../../order_details.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  final myCurrentOrdersBloc = KiwiContainer().resolve<MyCurrentOrdersBloc>()
    ..add(GetMyCurrentOrdersDataEvent());
  final myFinishedOrdersBloc = KiwiContainer().resolve<MyFinishedOrdersBloc>()
    ..add(GetMyFinishedOrdersDataEvent());
  String isSelectable =
      CacheHelper.getLanguage() == "en" ? "current" : "الحالية";

  @override
  void dispose() {
    super.dispose();
    myCurrentOrdersBloc.close();
    myFinishedOrdersBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.home_nav_my_orders.tr(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: SingleChildScrollView(
          child: CacheHelper.getToken()!.isEmpty
              ? Column(
                  children: [
                    SizedBox(
                      height: 170.h,
                    ),
                    const AppLogin(),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 55.h,
                      width: 340.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: const Color(0xffF3F3F3)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 8.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              isSelectable = CacheHelper.getLanguage() == "en"
                                  ? "current"
                                  : "الحالية";
                              myCurrentOrdersBloc
                                  .add(GetMyCurrentOrdersDataEvent());
                              setState(() {});
                            },
                            child: Container(
                              width: 160.w,
                              height: 42.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: isSelectable == "الحالية" ||
                                        isSelectable == "current"
                                    ? Theme.of(context).primaryColor
                                    : null,
                              ),
                              child: Center(
                                child: Text(
                                  CacheHelper.getLanguage() == "en"
                                      ? "current"
                                      : "الحالية",
                                  style: TextStyle(
                                    color: isSelectable == "الحالية" ||
                                            isSelectable == "current"
                                        ? Colors.white
                                        : const Color(0xffA2A1A4),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              isSelectable = CacheHelper.getLanguage() == "en"
                                  ? "finished"
                                  : "المنتهية";
                              myFinishedOrdersBloc
                                  .add(GetMyFinishedOrdersDataEvent());
                              setState(() {});
                            },
                            child: Container(
                              width: 160.w,
                              height: 42.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: isSelectable == "المنتهية" ||
                                        isSelectable == "finished"
                                    ? Theme.of(context).primaryColor
                                    : null,
                              ),
                              child: Center(
                                child: Text(
                                  CacheHelper.getLanguage() == "en"
                                      ? "finished"
                                      : "المنتهية",
                                  style: TextStyle(
                                    color: isSelectable == "المنتهية" ||
                                            isSelectable == "finished"
                                        ? Colors.white
                                        : const Color(0xffA2A1A4),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Column(
                      children: [
                        if (isSelectable == "الحالية" ||
                            isSelectable == "current")
                          BlocBuilder(
                              bloc: myCurrentOrdersBloc,
                              builder: (context, state) {
                                if (state is MyCurrentOrdersLoadingState) {
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: 3,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: 16.h,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Color color = const Color(0xffEDF5E6);
                                      Color statusColor =
                                          Theme.of(context).primaryColor;
                                      String status = "status";

                                      return Container(
                                        width: 345.w,
                                        height: 100.h,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(.02),
                                                  offset: const Offset(0, 6))
                                            ]),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${LocaleKeys.orders_order.tr()} #0000",
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontSize: 17.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      "date",
                                                      style: TextStyle(
                                                        color: const Color(
                                                            0xff9C9C9C),
                                                        fontSize: 17.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      7.r)),
                                                      child: Center(
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      8.w),
                                                          child: Text(
                                                            status,
                                                            style: TextStyle(
                                                              color:
                                                                  statusColor,
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.h),
                                              child: Divider(
                                                height: .2.h,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(children: [
                                                        Shimmer.fromColors(
                                                            baseColor: Theme.of(
                                                                    context)
                                                                .primaryColor
                                                                .withOpacity(
                                                                    .1),
                                                            highlightColor: Theme
                                                                    .of(context)
                                                                .primaryColor
                                                                .withOpacity(
                                                                    .03),
                                                            child: SizedBox(
                                                              width: 85.w,
                                                              height: 25.h,
                                                              child: ListView
                                                                  .separated(
                                                                      scrollDirection:
                                                                          Axis
                                                                              .horizontal,
                                                                      physics:
                                                                          const NeverScrollableScrollPhysics(),
                                                                      itemCount:
                                                                          3,
                                                                      separatorBuilder:
                                                                          (context, index) =>
                                                                              SizedBox(
                                                                                width: 4.w,
                                                                              ),
                                                                      itemBuilder: (context,
                                                                              indexImages) =>
                                                                          Shimmer
                                                                              .fromColors(
                                                                            baseColor:
                                                                                Theme.of(context).primaryColor.withOpacity(.1),
                                                                            highlightColor:
                                                                                Theme.of(context).primaryColor.withOpacity(.03),
                                                                            child:
                                                                                Shimmer.fromColors(
                                                                              baseColor: Theme.of(context).primaryColor.withOpacity(.1),
                                                                              highlightColor: Theme.of(context).primaryColor.withOpacity(.03),
                                                                              child: Container(
                                                                                width: 25.w,
                                                                                height: 25.h,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(7.r),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )),
                                                            )),
                                                      ]),
                                                      SizedBox(
                                                        width: 4.w,
                                                      ),
                                                      Shimmer.fromColors(
                                                        baseColor: Theme.of(
                                                                context)
                                                            .primaryColor
                                                            .withOpacity(.1),
                                                        highlightColor:
                                                            Theme.of(context)
                                                                .primaryColor
                                                                .withOpacity(
                                                                    .03),
                                                        child: Container(
                                                          height: 25.h,
                                                          width: 25.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                0xffEDF5E6),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7.r),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "0+",
                                                              style: TextStyle(
                                                                fontSize: 11.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ]),
                                                Shimmer.fromColors(
                                                  baseColor: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(.1),
                                                  highlightColor:
                                                      Theme.of(context)
                                                          .primaryColor
                                                          .withOpacity(.03),
                                                  child: Text(
                                                    "totalprice ر.س",
                                                    style: TextStyle(
                                                        fontSize: 15.sp,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                } else if (state
                                    is MyCurrentOrdersSuccessState) {
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.list.list.length,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: 16.h,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Color color = const Color(0xffEDF5E6);
                                      Color statusColor =
                                          Theme.of(context).primaryColor;
                                      String status =
                                          state.list.list[index].status;

                                      if (CacheHelper.getLanguage() == "ar") {
                                        switch (status) {
                                          case "in_way":
                                          case "في الطريق":
                                            color = const Color(0xffEDF5E6);
                                            statusColor =
                                                Theme.of(context).primaryColor;
                                            status = "في الطريق";
                                            break;
                                          case "pending":
                                          case "بإنتظار الموافقة":
                                            color = const Color(0xffEDF5E6);
                                            statusColor =
                                                Theme.of(context).primaryColor;
                                            status = "في الطريق";
                                            break;
                                        }
                                      }
                                      return GestureDetector(
                                        onTap: () {
                                          navigateTo(OrderDetailsScreen(
                                            id: state.list.list[index].id,
                                            isCancel: true,
                                            status:
                                                state.list.list[index].status,
                                          )).then((value) {
                                            if (value ?? false) {
                                              myCurrentOrdersBloc.add(
                                                  GetMyCurrentOrdersDataEvent());
                                            }
                                          });
                                        },
                                        child: Container(
                                          width: 345.w,
                                          height: 100.h,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(.02),
                                                    offset: const Offset(0, 6))
                                              ]),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${LocaleKeys.orders_order.tr()} #${state.list.list[index].id}",
                                                        style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontSize: 17.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        state.list.list[index]
                                                            .date,
                                                        style: TextStyle(
                                                          color: const Color(
                                                              0xff9C9C9C),
                                                          fontSize: 17.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7.r)),
                                                        child: Center(
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        8.w),
                                                            child: Text(
                                                              status,
                                                              style: TextStyle(
                                                                color:
                                                                    statusColor,
                                                                fontSize: 11.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.h),
                                                child: Divider(
                                                  height: .2.h,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(children: [
                                                          SizedBox(
                                                            width: 85.w,
                                                            height: 25.h,
                                                            child: ListView
                                                                .separated(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              physics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              itemCount: state
                                                                          .list
                                                                          .list[
                                                                              index]
                                                                          .products
                                                                          .length >=
                                                                      3
                                                                  ? 3
                                                                  : state
                                                                      .list
                                                                      .list[
                                                                          index]
                                                                      .products
                                                                      .length,
                                                              separatorBuilder:
                                                                  (context,
                                                                          index) =>
                                                                      SizedBox(
                                                                width: 4.w,
                                                              ),
                                                              itemBuilder: (context,
                                                                      indexImages) =>
                                                                  Container(
                                                                width: 25.w,
                                                                height: 25.h,
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(7.r),
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                          state
                                                                              .list
                                                                              .list[index]
                                                                              .products[indexImages]
                                                                              .url,
                                                                        ),
                                                                        fit: BoxFit.fill)),
                                                              ),
                                                            ),
                                                          ),
                                                        ]),
                                                        SizedBox(
                                                          width: 4.w,
                                                        ),
                                                        if (state
                                                                .list
                                                                .list[index]
                                                                .products
                                                                .length >
                                                            3)
                                                          Container(
                                                            height: 25.h,
                                                            width: 25.w,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: const Color(
                                                                  0xffEDF5E6),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7.r),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                state
                                                                            .list
                                                                            .list[index]
                                                                            .products
                                                                            .length >
                                                                        3
                                                                    ? "${state.list.list[index].products.length - 3}+"
                                                                    : "0+",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      11.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                      ]),
                                                  Text(
                                                    "${state.list.list[index].totalPrice}\t${LocaleKeys.r_s.tr()}",
                                                    style: TextStyle(
                                                        fontSize: 15.sp,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else if (state is MyCurrentOrdersErrorState) {
                                  return Center(
                                      child: Text(state.text ??
                                          LocaleKeys.home_data_not_found.tr()));
                                }
                                return const SizedBox.shrink();
                              }),
                        if (isSelectable == "المنتهية" ||
                            isSelectable == "finished")
                          BlocBuilder(
                            bloc: myFinishedOrdersBloc,
                            builder: (context, state) {
                              if (state is MyFinishedOrdersLoadingState) {
                                return ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 3,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 16.h,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Color color = const Color(0xffEDF5E6);
                                    Color statusColor =
                                        Theme.of(context).primaryColor;
                                    String status = "status";

                                    return Container(
                                      width: 345.w,
                                      height: 100.h,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(.02),
                                                offset: const Offset(0, 6))
                                          ]),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${LocaleKeys.orders_order.tr()} #0000",
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 17.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    "date",
                                                    style: TextStyle(
                                                      color: const Color(
                                                          0xff9C9C9C),
                                                      fontSize: 17.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7.r)),
                                                    child: Center(
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    8.w),
                                                        child: Text(
                                                          status,
                                                          style: TextStyle(
                                                            color: statusColor,
                                                            fontSize: 11.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.h),
                                            child: Divider(
                                              height: .2.h,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(children: [
                                                      Shimmer.fromColors(
                                                          baseColor: Theme.of(
                                                                  context)
                                                              .primaryColor
                                                              .withOpacity(.1),
                                                          highlightColor:
                                                              Theme.of(context)
                                                                  .primaryColor
                                                                  .withOpacity(
                                                                      .03),
                                                          child: SizedBox(
                                                            width: 85.w,
                                                            height: 25.h,
                                                            child: ListView
                                                                .separated(
                                                                    scrollDirection:
                                                                        Axis
                                                                            .horizontal,
                                                                    physics:
                                                                        const NeverScrollableScrollPhysics(),
                                                                    itemCount:
                                                                        3,
                                                                    separatorBuilder:
                                                                        (context,
                                                                                index) =>
                                                                            SizedBox(
                                                                              width: 4.w,
                                                                            ),
                                                                    itemBuilder: (context,
                                                                            indexImages) =>
                                                                        Shimmer
                                                                            .fromColors(
                                                                          baseColor: Theme.of(context)
                                                                              .primaryColor
                                                                              .withOpacity(.1),
                                                                          highlightColor: Theme.of(context)
                                                                              .primaryColor
                                                                              .withOpacity(.03),
                                                                          child:
                                                                              Shimmer.fromColors(
                                                                            baseColor:
                                                                                Theme.of(context).primaryColor.withOpacity(.1),
                                                                            highlightColor:
                                                                                Theme.of(context).primaryColor.withOpacity(.03),
                                                                            child:
                                                                                Container(
                                                                              width: 25.w,
                                                                              height: 25.h,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(7.r),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )),
                                                          )),
                                                    ]),
                                                    SizedBox(
                                                      width: 4.w,
                                                    ),
                                                    Shimmer.fromColors(
                                                      baseColor:
                                                          Theme.of(context)
                                                              .primaryColor
                                                              .withOpacity(.1),
                                                      highlightColor:
                                                          Theme.of(context)
                                                              .primaryColor
                                                              .withOpacity(.03),
                                                      child: Container(
                                                        height: 25.h,
                                                        width: 25.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xffEDF5E6),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      7.r),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "0+",
                                                            style: TextStyle(
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ]),
                                              Shimmer.fromColors(
                                                baseColor: Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(.1),
                                                highlightColor:
                                                    Theme.of(context)
                                                        .primaryColor
                                                        .withOpacity(.03),
                                                child: Text(
                                                  "totalprice ر.س",
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else if (state
                                  is MyFinishedOrdersSuccessState) {
                                return ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.list.list.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 16.h,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Color color = const Color(0xffEDF5E6);
                                    Color statusColor =
                                        Theme.of(context).primaryColor;
                                    String status =
                                        state.list.list[index].status;

                                    if (CacheHelper.getLanguage() == "ar") {
                                      switch (status) {
                                        case "in_way":
                                        case "في الطريق":
                                          color = const Color(0xffEDF5E6);
                                          statusColor =
                                              Theme.of(context).primaryColor;
                                          status = "في الطريق";
                                          break;
                                        case "canceled":
                                        case "طلب ملغي":
                                          color = const Color(0xffFFE4E4);
                                          statusColor = Colors.red;
                                          status = "طلب ملغي";
                                          break;
                                      }
                                    }
                                    return GestureDetector(
                                      onTap: () {
                                        navigateTo(OrderDetailsScreen(
                                          status: state.list.list[index].status,
                                          id: state.list.list[index].id,
                                          isCancel: false,
                                        ));
                                      },
                                      child: Container(
                                        width: 345.w,
                                        height: 100.h,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(.02),
                                                  offset: const Offset(0, 6))
                                            ]),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${LocaleKeys.orders_order.tr()} #${state.list.list[index].id}",
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontSize: 17.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      state.list.list[index]
                                                          .date,
                                                      style: TextStyle(
                                                        color: const Color(
                                                            0xff9C9C9C),
                                                        fontSize: 17.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      7.r)),
                                                      child: Center(
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      8.w),
                                                          child: Text(
                                                            status,
                                                            style: TextStyle(
                                                                color:
                                                                    statusColor,
                                                                fontSize: 11.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.h),
                                              child: Divider(
                                                color: const Color(0xffF3F3F3),
                                                height: .2.h,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(children: [
                                                        SizedBox(
                                                          width: 85.w,
                                                          height: 25.h,
                                                          child: ListView
                                                              .separated(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            itemCount: state
                                                                        .list
                                                                        .list[
                                                                            index]
                                                                        .products
                                                                        .length >=
                                                                    3
                                                                ? 3
                                                                : state
                                                                    .list
                                                                    .list[index]
                                                                    .products
                                                                    .length,
                                                            separatorBuilder:
                                                                (context,
                                                                        index) =>
                                                                    SizedBox(
                                                              width: 4.w,
                                                            ),
                                                            itemBuilder: (context,
                                                                    indexImages) =>
                                                                Container(
                                                              width: 25.w,
                                                              height: 25.h,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              7.r),
                                                                      image: DecorationImage(
                                                                          image: NetworkImage(
                                                                            state.list.list[index].products[indexImages].url,
                                                                          ),
                                                                          fit: BoxFit.fill)),
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                      SizedBox(
                                                        width: 4.w,
                                                      ),
                                                      if (state.list.list[index]
                                                              .products.length >
                                                          3)
                                                        Container(
                                                          height: 25.h,
                                                          width: 25.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                0xffEDF5E6),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7.r),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              state
                                                                          .list
                                                                          .list[
                                                                              index]
                                                                          .products
                                                                          .length >
                                                                      3
                                                                  ? "${state.list.list[index].products.length - 3}+"
                                                                  : "0+",
                                                              style: TextStyle(
                                                                fontSize: 11.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    ]),
                                                Text(
                                                  "${state.list.list[index].totalPrice}\t${LocaleKeys.r_s.tr()}",
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else if (state is MyFinishedOrdersErrorState) {
                                return Center(
                                    child: Text(state.text ??
                                        LocaleKeys.home_data_not_found.tr()));
                              }
                              return const SizedBox.shrink();
                            },
                          )
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
