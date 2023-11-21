import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/widgets/custom_appbar.dart';
import 'package:thimar_course/gen/assets.gen.dart';

import '../core/logic/helper_methods.dart';
import '../features/Wallet/show_wallet/bloc.dart';

class SeeMoreWalletScreen extends StatefulWidget {
  const SeeMoreWalletScreen({Key? key}) : super(key: key);

  @override
  State<SeeMoreWalletScreen> createState() => _SeeMoreWalletScreenState();
}

class _SeeMoreWalletScreenState extends State<SeeMoreWalletScreen> {
  final bloc = KiwiContainer().resolve<WalletBloc>()..add(GetWalletDataEvent());


  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: CustomAppBarScreen(text: "سجل المعاملات", image: Assets.icons.backHome.path),
      body: Padding(
        padding:   EdgeInsets.all(16.0.r),
        child: BlocBuilder(bloc: bloc,builder: (BuildContext context, state) {
    if (state is GetWalletDataLoadingState) {
    loadingWidget();
    } else if (state is GetWalletDataSuccessState) {
return  ListView.separated(

  separatorBuilder: (context, index) => SizedBox(
    height: 16.h,
  ),
  itemCount: state.list.list.length,
  itemBuilder: (context, index) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        Row(
        children: [
          Image.asset(Assets.icons.arrowVarRed.path),
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
          "طلب #${state.list.list[index].id}",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
              color: Theme.of(context).primaryColor),
        ),
        ),
        SizedBox(
        height: 8.h,
        ),
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 116.w,
                height: 25.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics:
                  const NeverScrollableScrollPhysics(),
                  itemCount: state.list.list[index].images
                      .length >=
                      4
                      ? 4
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
              if (state.list.list[index].images.length > 4)
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
                      state.list.list[index].images.length >
                          4
                          ? "${state.list.list[index].images.length - 4}+"
                          : "0+",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11.sp,
                        color:
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Text(
            "${state.list.list[index].afterCharge} ر.س",
            style: TextStyle(
                fontSize: 13.sp,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w900),
          ),
        ],
        ),
    ],
  ),
);
    }return const SizedBox.shrink();

        },),
      ),
    );
  }
}
