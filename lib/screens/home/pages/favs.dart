import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/generated/locale_keys.g.dart';
import 'package:thimar_course/screens/product_details.dart';

import '../../../core/design/widgets/app_login.dart';
import '../../../core/logic/cache_helper.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../features/FAVS/bloc.dart';
import '../components/loading_products.dart';

class FAVSPage extends StatefulWidget {
  const FAVSPage({Key? key}) : super(key: key);

  @override
  State<FAVSPage> createState() => _FAVSPageState();
}

class _FAVSPageState extends State<FAVSPage> {
  final favBloc = KiwiContainer().resolve<FavsBloc>();

  @override
  void initState() {
    super.initState();
    favBloc.add(GetFAVSDataEvent());
  }

  @override
  void dispose() {
    super.dispose();
    favBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
         LocaleKeys.home_nav_favs.tr(),
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder(
        bloc: favBloc,
        builder: (BuildContext context, state) {
          if (CacheHelper.getToken()!.isEmpty) {
            return const AppLogin();
          } else if (state is FAVSLoadingState) {
            return const LoadingProductsItem();

          } else if (favBloc.favsData.isNotEmpty) {
            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 160 / 215,
                  crossAxisSpacing: 16.h,
                  mainAxisSpacing: 16.w),
              itemCount: favBloc.favsData.length,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  navigateTo(ProductDetailsScreen(
                    isHome: true,
                    model: favBloc.favsData[index],
                  )).then((value) {
                    if (value ?? false) {
                      favBloc.add(GetFAVSDataEvent());
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.02),
                        offset: const Offset(0, 2),
                        blurRadius: 11.r,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:   EdgeInsets.only(bottom: 32.h),
                    child: Column(children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(11.r),
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Image.network(
                                favBloc.favsData[index].mainImage,
                                fit: BoxFit.fill,
                                width: 150.w,
                                height: 100.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadiusDirectional.only(
                                      bottomStart: Radius.circular(11.r)),
                                ),
                                child: Text(
                                  "${favBloc.favsData[index].stringDiscount}%",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Padding(
                      padding:   EdgeInsets.symmetric(horizontal: 4.w),
                      child: Column(
                        children: [  Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: Row(
                            children: [
                              Text(
                                favBloc.favsData[index].title,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                        ),
                          Row(
                            children: [
                              Text(
                                "${LocaleKeys.price.tr()} / ${favBloc.favsData[index].unit.name}",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).hintColor),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            child: Row(
                              children: [
                                Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                      text:
                                      "${favBloc.favsData[index].stringPrice}\t${LocaleKeys.r_s.tr()}",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                      " ${favBloc.favsData[index].stringPriceBeforeDiscount}\t${LocaleKeys.r_s.tr()}",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ]),
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),],
                      ),
                    ),
                    ]),
                  ),
                ),
              ),
            );
          } else if (favBloc.favsData.isEmpty) {
    return   Center(
    child: Text(
    LocaleKeys.please_add_some_producst_to_favs.tr(),
    ),
    );}else if (state is FAVSErrorState) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
