import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/features/Wallet/show_wallet/bloc.dart';
import 'package:thimar_course/generated/locale_keys.g.dart';
import 'package:thimar_course/screens/charge_now.dart';
import 'package:thimar_course/screens/history_transactions.dart';

import '../core/widgets/custom_appbar.dart';
import '../gen/assets.gen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final bloc = KiwiContainer().resolve<WalletBloc>()..add(GetWalletDataEvent());

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: LocaleKeys.my_account_wallet.tr(),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if (state is GetWalletDataLoadingState) {
                return loadingWidget();
              } else if (state is GetWalletDataSuccessState) {
                return Column(
                    children: [
                  SizedBox(
                    height: 48.h,
                  ),
                  Center(
                    child: Text(
                      LocaleKeys.wallet_charge_now.tr(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 20.sp),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Center(
                    child: Text(
                      "${state.list.wallet} ${LocaleKeys.r_s.tr()}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 24.sp),
                    ),
                  ),
                  SizedBox(
                    height: 75.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateTo(const ChargeNowScreen());
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
                            LocaleKeys.wallet_charge_now.tr(),
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
                  SizedBox(
                    height: 64.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                      LocaleKeys.wallet_history_transactions.tr(),
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                      GestureDetector(
                        onTap: () {
                          navigateTo(const HistoryTransactionsScreen());
                        },
                        child: Text(
                          LocaleKeys.wallet_see_more.tr(),
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 335.h,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 16.h,
                      ),
                      itemCount: state.list.list.length,
                      itemBuilder: (context, index) => Container(
                        height:  state.list.list[index].images.isEmpty ? 100.h : 130.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 16.h),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 11.r,
                                  blurStyle: BlurStyle.outer,
                                  color: Colors.black.withOpacity(.02),
                                  offset: const Offset(0, 2))
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(Assets.icons.arrowTan.path),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  state.list.list[index].statusTrans,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp),
                                ),
                                const Spacer(),
                                Text(
                                  state.list.list[index].date,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xff9C9C9C)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 24.r),
                              child: Text(
                                "${state.list.list[index].afterCharge} ${LocaleKeys.r_s.tr()}",
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            if (state.list.list[index].images.isNotEmpty)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 85.w,
                                      height: 25.h,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: state.list.list[index].images
                                                    .length >=
                                                3
                                            ? 3
                                            : state
                                                .list.list[index].images.length,
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                          width: 4.w,
                                        ),
                                        itemBuilder: (context, imagesIndex) =>
                                            Container(
                                          width: 25.w,
                                          height: 25.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7.r),
                                              image: DecorationImage(
                                                  image: NetworkImage(state
                                                      .list
                                                      .list[index]
                                                      .images[imagesIndex]
                                                      .url))),
                                        ),
                                      ),
                                    ),
                                    if (state.list.list[index].images.length >
                                        3)
                                      Container(
                                        width: 25.w,
                                        height: 25.h,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffEDF5E6),
                                          borderRadius:
                                              BorderRadius.circular(7.r),
                                        ),
                                        child: Center(
                                          child: Text(
                                            state.list.list[index].images
                                                        .length >
                                                    3
                                                ? "${state.list.list[index].images.length - 3}+"
                                                : "0+",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11.sp,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ]);
              }
              return const SizedBox.shrink();
            }),
      ),
    );
  }
}
