import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/gen/assets.gen.dart';

import '../features/my_orders/current/bloc.dart';
import '../features/my_orders/finished/bloc.dart';
import 'order_details.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  final myCurrentOrdersBloc = KiwiContainer().resolve<MyCurrentOrdersBloc>();
  final myFinishedOrdersBloc = KiwiContainer().resolve<MyFinishedOrdersBloc>();
  String isSelectable = "الحالية";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myCurrentOrdersBloc.add(GetMyCurrentOrdersDataEvent());
    myFinishedOrdersBloc.add(GetMyFinishedOrdersDataEvent());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myCurrentOrdersBloc.close();
    myFinishedOrdersBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("طلباتي",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: SingleChildScrollView(
          child: Column(
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
                        isSelectable = "الحالية";
                        setState(() {});
                      },
                      child: Container(
                        width: 160.w,
                        height: 42.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: isSelectable == "الحالية"
                              ? Theme.of(context).primaryColor
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            "الحالية",
                            style: TextStyle(
                              color: isSelectable == "الحالية"
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
                        isSelectable = "المنتهية";
                        setState(() {});
                      },
                      child: Container(
                        width: 160.w,
                        height: 42.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: isSelectable == "المنتهية"
                              ? Theme.of(context).primaryColor
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            "المنتهية",
                            style: TextStyle(
                              color: isSelectable == "المنتهية"
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
              if (isSelectable == "الحالية")
                BlocBuilder(
                    bloc: myCurrentOrdersBloc,
                    builder: (context, state) {
                      if (state is MyCurrentOrdersLoadingState) {
                        loadingWidget();
                      } else if (state is MyCurrentOrdersSuccessState) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.list.list.length,
                          separatorBuilder: (context, index) => SizedBox(
                            height: 16.h,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                navigateTo(OrderDetailsScreen(
                                  id: state.list.list[index].id,
                                  typeButton: true,
                                ));
                              },
                              child: Container(
                                width: 345.w,
                                height: 100.h,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "طلب #${state.list.list[index].id}",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              state.list.list[index].date,
                                              style: TextStyle(
                                                color: const Color(0xff9C9C9C),
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              height: 25.h,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffEDF5E6),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.r)),
                                              child: Center(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8.w),
                                                  child: Text(
                                                    state.list.list[index]
                                                        .status,
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.h),
                                      child: Divider(
                                        color: const Color(0xffF3F3F3),
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
                                                SizedBox(
                                                  width: 116.w,
                                                  height: 25.h,
                                                  child: ListView.separated(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount: state
                                                                .list
                                                                .list[index]
                                                                .products
                                                                .length >=
                                                            4
                                                        ? 4
                                                        : state.list.list[index]
                                                            .products.length,
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            SizedBox(
                                                      width: 4.w,
                                                    ),
                                                    itemBuilder: (context,
                                                            indexImages) =>
                                                        Container(
                                                      clipBehavior: Clip
                                                          .antiAliasWithSaveLayer,
                                                      width: 25.w,
                                                      height: 25.h,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      7.r),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                            state
                                                                .list
                                                                .list[index]
                                                                .products[
                                                                    indexImages]
                                                                .url,
                                                          ))),
                                                    ),
                                                  ),
                                                ),

                                                // List.generate(
                                                //   state.list.data[index].products
                                                //       .length>=4?  4:  state.list.data[index].products
                                                //       .length,
                                                //       (indexImages) => Container(
                                                //     width: 25.w,
                                                //     height: 25.h,
                                                //
                                                //     decoration: BoxDecoration(
                                                //         borderRadius: BorderRadius.circular(7.r),
                                                //         image: DecorationImage(
                                                //             image: NetworkImage(
                                                //               state
                                                //                   .list
                                                //                   .data[index]
                                                //                   .products[indexImages]
                                                //                   .url,
                                                //             ))),
                                                //   ),
                                                // ),
                                              ]),
                                              SizedBox(
                                                width: 4.w,
                                              ),
                                              if (state.list.list[index]
                                                      .products.length >
                                                  4)
                                                Container(
                                                  height: 25.h,
                                                  width: 25.w,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffEDF5E6),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.r),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      state
                                                                  .list
                                                                  .list[index]
                                                                  .products
                                                                  .length >
                                                              4
                                                          ? "${state.list.list[index].products.length - 4}+"
                                                          : "0+",
                                                      style: TextStyle(
                                                        fontSize: 11.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ]),
                                        Text(
                                          "${state.list.list[index].orderPrice}ر.س",
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    }),
              if (isSelectable == "المنتهية")
                BlocBuilder(
                  bloc: myFinishedOrdersBloc,
                  builder: (context, state) {
                    if (state is MyFinishedOrdersLoadingState) {
                      loadingWidget();
                    } else if (state is MyFinishedOrdersSuccessState) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.list.list.length,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 16.h,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              navigateTo(OrderDetailsScreen(
                                id: state.list.list[index].id,
                                typeButton: false,
                              ));
                            },
                            child: Container(
                              width: 345.w,
                              height: 100.h,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "طلب #${state.list.list[index].id}",
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "${state.list.list[index].time},",
                                            style: TextStyle(
                                              color: const Color(0xff9C9C9C),
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            height: 25.h,
                                            decoration: BoxDecoration(
                                                color: const Color(0xffF3F3F3),
                                                borderRadius:
                                                    BorderRadius.circular(7.r)),
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.w),
                                                child: Text(
                                                  state.list.list[index].status,
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xffA1A1A1),
                                                    fontSize: 11.sp,
                                                    fontWeight: FontWeight.bold,
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
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.h),
                                    child: Divider(
                                      color: const Color(0xffF3F3F3),
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
                                              SizedBox(
                                                width: 116.w,
                                                height: 25.h,
                                                child: ListView.separated(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: state
                                                              .list
                                                              .list[index]
                                                              .products
                                                              .length >=
                                                          4
                                                      ? 4
                                                      : state.list.list[index]
                                                          .products.length,
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          SizedBox(
                                                    width: 4.w,
                                                  ),
                                                  itemBuilder:
                                                      (context, indexImages) =>
                                                          Container(
                                                    width: 25.w,
                                                    height: 25.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7.r),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                          state
                                                              .list
                                                              .list[index]
                                                              .products[
                                                                  indexImages]
                                                              .url,
                                                        ))),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            if (state.list.list[index].products
                                                    .length >
                                                4)
                                              Container(
                                                height: 25.h,
                                                width: 25.w,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffEDF5E6),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.r),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    state
                                                                .list
                                                                .list[index]
                                                                .products
                                                                .length >
                                                            4
                                                        ? "${state.list.list[index].products.length - 4}+"
                                                        : "0+",
                                                    style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ]),
                                      Text(
                                        "${state.list.list[index].totalPrice}ر.س",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}
