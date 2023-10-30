import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import '../core/design/widgets/btn.dart';
import '../core/design/widgets/icon_with_bg.dart';
import '../core/design/widgets/input.dart';
import '../core/logic/helper_methods.dart';
import '../features/cart/add_to_cart/bloc.dart';
import '../features/search/search_home/bloc.dart';
import '../gen/assets.gen.dart';
import 'product_details.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchStateScreen();
}

class _SearchStateScreen extends State<SearchScreen> {
  final searchBloc = KiwiContainer().resolve<SearchHomeBloc>();

  final addToCartBloc = KiwiContainer().resolve<AddToCartBloc>();
Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // productsDataBloc.add(GetProductsDataEvent());
  }

  void _getData(String value) {
    searchBloc.add(GetSearchHomeDataEvent(value: value));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // productsDataBloc.close();
    searchBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "البحث",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leadingWidth: 60.w,
        leading: Padding(
          padding: EdgeInsetsDirectional.only(start: 16.r, top: 10.r),
          child: IconWithBg(
            icon: Icons.arrow_back_ios_outlined,
            color: Theme.of(context).primaryColor,
            onPress: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 16.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Input(
              onChanged: (value)  {
                if (timer?.isActive==true) {
                  timer?.cancel();
                }
                timer = Timer(const Duration(seconds: 1), () {
                  _getData(value);
                });

              },

              controller: searchBloc.searchController,
              textInputAction: TextInputAction.search,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'اكتب كلمة للبحث ';
                }
                return null;
              },
              inputType: InputType.search,
              iconPath: Assets.icons.search.path,
              hintText: "ابحث عما تريد؟",
            ),
          ),
          BlocBuilder(
              bloc: searchBloc,
              builder: (context, state) {
                if (state is SearchHomeLoadingState) {
                  loadingWidget();
                } else if (state is SearchHomeSuccessState) {
                  return GridView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 160 / 215,
                        crossAxisSpacing: 16.h,
                        mainAxisSpacing: 16.w,
                      ),
                      itemCount: searchBloc.list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            navigateTo(ProductDetailsScreen(
                              id: searchBloc.list[index].id,
                              price: double.parse(
                                  searchBloc.list[index].price.toString()),
                              isFavorite: searchBloc.list[index].isFavorite,
                              amount: searchBloc.list[index].amount,
                            ));
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
                              padding: EdgeInsets.only(bottom: 16.r),
                              child: Column(children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(11.r),
                                    child: Stack(
                                      alignment: AlignmentDirectional.topEnd,
                                      children: [
                                        Image.network(
                                          searchBloc.list[index].mainImage,
                                          fit: BoxFit.fill,
                                          width: 145.w,
                                          height: 120.h,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.w,
                                            vertical: 4.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadiusDirectional.only(
                                                    bottomStart:
                                                        Radius.circular(11.r)),
                                          ),
                                          child: Text(
                                            "${searchBloc.list[index].discount * 100}%",
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
                                  padding: EdgeInsets.symmetric(vertical: 4.h),
                                  child: Row(
                                    children: [
                                      Text(
                                        searchBloc.list[index].title,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "السعر / ${searchBloc.list[index].unit.name}",
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
                                                "${searchBloc.list[index].price} ر.س",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                " ${searchBloc.list[index].priceBeforeDiscount} ر.س",
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w400,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                        ]),
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (searchBloc.list[index].amount != 0)
                                  AppButton(
                                    text: "أضف للسلة",
                                    onPress: () {
                                      addToCartBloc.add(PostAddToCartDataEvent(
                                          id: searchBloc.list[index].id,
                                          amount:
                                              searchBloc.list[index].amount));
                                    },
                                    isBig: false,
                                  ),
                                if (searchBloc.list[index].amount == 0)
                                  const Text(
                                    "تم نفاذ الكمية",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                              ]),
                            ),
                          ),
                        );
                      });
                }
                return const SizedBox.shrink();
              }),
        ],
      ),
    );
  }
}
