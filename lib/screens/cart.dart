import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/screens/compelete_order.dart';
import '../core/widgets/custom_appbar.dart';
import '../features/cart/show_cart/bloc.dart';
import '../gen/assets.gen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
   final cardDataBLoc = KiwiContainer().resolve<CartDataBloc>()..add(GetCartDataEvent());



  @override
  void dispose() {
    super.dispose();
    cardDataBLoc.close();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarScreen(
        image: Assets.icons.backHome.path,
        text: "السلة",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0.r),
        child: BlocBuilder(
          buildWhen: (previous, current) => current is CartDataSuccessState,
          bloc: cardDataBLoc,
          builder: (context, state) {
            if (state is CartDataLoadingState) {
              loadingWidget();
            } else if (state is CartDataSuccessState) {
              return Column(
                children: [
                  SizedBox(
                    height: 390.h,
                    child: ListView.builder(
                     shrinkWrap: true,

                      itemCount: cardDataBLoc.cartData.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(8.r),
                          width: 340.w,
                          height: 95.h,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.02),
                                  offset: const Offset(0, 6),
                                )
                              ]),
                          child: Row(
                            children: [
                              Container(
                                width: 90.w,
                                height: 80.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        cardDataBLoc.cartData[index].image,
                                      ),
                                      fit: BoxFit.fill,
                                    )),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    cardDataBLoc.cartData[index].title,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp),
                                  ),
                                  Text(
                                    "${cardDataBLoc.cartData[index].price} ر.س",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.sp),
                                  ),
                                  Container(
                                    height: 30.h,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(.11),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            cardDataBLoc
                                                .cartData[index].amount++;

                                            cardDataBLoc.add(CartUpdateEvent(
                                                amount: cardDataBLoc
                                                    .cartData[index].amount,
                                                id: cardDataBLoc
                                                    .cartData[index].id));
                                          },
                                          child: Container(
                                            height: 25.h,
                                            width: 25.w,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(.02),
                                                  blurStyle: BlurStyle.inner,
                                                  offset: const Offset(0, 3),
                                                )
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                            child: Image.asset(
                                                Assets.icons.add.path),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0.w),
                                          child: BlocBuilder(
                                              bloc: cardDataBLoc,
                                              builder: (context, states) {
                                                return Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8.0.w),
                                                  child: Text(
                                                    cardDataBLoc
                                                        .cartData[index].amount
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (cardDataBLoc
                                                    .cartData[index].amount >
                                                1) {
                                              cardDataBLoc
                                                  .cartData[index].amount--;
                                              cardDataBLoc.add(CartUpdateEvent(
                                                  amount: cardDataBLoc
                                                      .cartData[index].amount,
                                                  id: cardDataBLoc
                                                      .cartData[index].id));
                                            }
                                          },
                                          child: Container(
                                            height: 25.h,
                                            width: 25.w,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(.02),
                                                  blurStyle: BlurStyle.inner,
                                                  offset: const Offset(0, 3),
                                                )
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                            child: Image.asset(
                                                Assets.icons.minus.path),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  cardDataBLoc.add(DeleteFromCartDataEvent(
                                    id: cardDataBLoc.cartData[index].id,
                                    index: index,
                                  ));
                                  setState(() {});
                                },
                                child: Image.asset(
                                  Assets.icons.remove.path,
                                  width: 27.w,
                                  height: 27.h,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.r),
                    width: 340.w,
                    height: 70.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.02),
                              offset: const Offset(0, 6)),
                        ]),
                    child: TextFormField(
                      controller: cardDataBLoc.couponController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(
                              8.0.w, 24.0.h, 8.0.w, 24.0.h),
                          labelText: "عندك كوبون ؟ ادخل رقم الكوبون",
                          suffixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                            child: ElevatedButton(
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                cardDataBLoc.add(ApplyCouponEvent());
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                fixedSize: Size(80.w, 40.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "تطبيق",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          labelStyle: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w300,
                              color: const Color(0xffB9C9A8))),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      "جميع الأسعار تشمل قيمة الضريبة المضافة 15%",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(8.r),
                    height: 105.h,
                    width: 340.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: const Color(0xffF3F8EE)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "إجمالي المنتجات",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor),
                            ),
                            Text(
                              "${state.list.totalPriceBeforeDiscount}ر.س",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor),
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
                              "الخصم",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor),
                            ),
                            Text(
                              "${state.list.totalDiscount}-ر.س",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0.h),
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
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor),
                            ),
                            Text(
                              "${state.list.totalPriceWithVat}ر.س",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is DeleteFromCartLoadingState) {
              loadingWidget();
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: BlocBuilder(
          bloc: cardDataBLoc,
          buildWhen: (previous, current) => current is CartDataSuccessState,
          builder: (BuildContext context, state) {
            if (state is CartDataSuccessState) {
              return AppButton(
                  text: "الانتقال لإتمام الطلب",
                  onPress: () {
                    navigateTo(CompleteOrderScreen(
                      coupon: cardDataBLoc.couponController.text,
                      discount: state.list.totalDiscount,
                      totalPrice: state.list.totalPriceWithVat,
                    ));
                  });
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
