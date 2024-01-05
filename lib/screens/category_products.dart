import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:range_slider_flutter/range_slider_flutter.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/core/widgets/custom_appbar.dart';
import 'package:thimar_course/features/categories/bloc.dart';
import 'package:thimar_course/generated/locale_keys.g.dart';
import 'package:thimar_course/screens/product_details.dart';

import '../core/design/widgets/btn.dart';
import '../core/design/widgets/input.dart';
import '../features/category_product/bloc.dart';
import '../features/products/bloc.dart';
import '../gen/assets.gen.dart';

class CategoryProductsScreen extends StatefulWidget {
  CategoriesData model;
  final int index, id;
  double minPrice, maxPrice;
  CategoryProductsScreen(
      {Key? key,
      required this.model,
      required this.index,
      required this.id,
      this.minPrice = 1,
      this.maxPrice = 999})
      : super(key: key);

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  final bloc = KiwiContainer().resolve<CategoryProductBloc>();
  final searchBloc = KiwiContainer().resolve<ProductsDataBloc>();
  Timer? timer;
  double _lowerValue = 1;
  double _upperValue = 200;
  static String filter = "asc";
  static String? value;
  void _getData(String value) {
    searchBloc.add(GetProductsDataEvent(
      id: widget.id,
      value: value,
      minPrice: widget.minPrice,
      maxPrice: widget.maxPrice,
      filter: filter,
    ));
  }

  @override
  void initState() {
    super.initState();
    bloc.add(GetCategoryProductEvent(id: widget.model.list[widget.index].id));
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: widget.model.list[widget.index].name,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          Input(
            filterIconTap: () {
              showModalBottomSheet(
                  useSafeArea: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(38.r),
                          topRight: Radius.circular(38.r))),
                  context: context,
                  builder: (context) => StatefulBuilder(builder:
                          (BuildContext context,
                              void Function(void Function()) setState2) {
                        return Padding(
                          padding: EdgeInsets.all(16.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  LocaleKeys.categories_filter.tr(),
                                  style: TextStyle(
                                      fontSize: 17.sp,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Divider(
                                color: const Color(0xffF3F3F3),
                                thickness: 1,
                                height: 1.h,
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Text(
                                LocaleKeys.price.tr(),
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              RangeSliderFlutter(
                                onDragCompleted: (x, min, max) {
                                  widget.minPrice = min;
                                  widget.maxPrice = max;
                                  debugPrint(widget.minPrice.toString());
                                  debugPrint(widget.maxPrice.toString());
                                },
                                textColor: Colors.black,
                                rtl: true,
                                values: [_lowerValue, _upperValue],
                                rangeSlider: true,
                                tooltip: RangeSliderFlutterTooltip(
                                    rightSuffix: Text(LocaleKeys.r_s.tr()),
                                    alwaysShowTooltip: true,
                                    leftSuffix: Text(LocaleKeys.r_s.tr()),
                                    textStyle: TextStyle(fontSize: 12.sp)),
                                textPositionBottom: -130,
                                handlerHeight: 30.h,
                                trackBar: RangeSliderFlutterTrackBar(
                                  activeTrackBarHeight: 10.h,
                                  inactiveTrackBarHeight: 10.h,
                                  activeTrackBar: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  inactiveDisabledTrackBarColor: Colors.white,
                                  activeDisabledTrackBarColor: Colors.white,
                                  inactiveTrackBar: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: const Color(0xffDCE2D5),
                                  ),
                                ),
                                min: 1,
                                max: 300,
                                fontSize: 12.sp,
                                textBackgroundColor: Colors.white,
                                onDragging:
                                    (handlerIndex, lowerValue, upperValue) {
                                  _lowerValue = lowerValue;
                                  _upperValue = upperValue;
                                  setState2(() {});
                                },
                              ),
                              SizedBox(
                                height: 48.h,
                              ),
                              Divider(
                                color: const Color(0xffF3F3F3),
                                thickness: 1,
                                height: 1.h,
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                LocaleKeys.categories_sort.tr(),
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      filter = "asc";
                                      setState2(() {});
                                    },
                                    child: Container(
                                        height: 21.h,
                                        width: 23.w,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color(0xffECECEC),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6.r),
                                          color: filter == "asc"
                                              ? Theme.of(context).primaryColor
                                              : null,
                                        )),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    LocaleKeys.categories_from_min_to_high.tr(),
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      filter = "desc";
                                      setState2(() {});
                                    },
                                    child: Container(
                                        height: 21.h,
                                        width: 23.w,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color(0xffECECEC),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6.r),
                                          color: filter == "desc"
                                              ? Theme.of(context).primaryColor
                                              : null,
                                        )),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    LocaleKeys.categories_from_high_to_min.tr(),
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 24.h,
                              ),
                              AppButton(
                                  text: LocaleKeys.categories_apply.tr(),
                                  onPress: () {
                                    searchBloc.add(GetProductsDataEvent(
                                        id: widget.id,
                                        minPrice: widget.minPrice,
                                        maxPrice: widget.maxPrice,
                                        value: value,
                                        filter: filter));
                                    Navigator.pop(context);
                                    setState2(() {});
                                  }),
                            ],
                          ),
                        );
                      }));
            },
            controller: searchBloc.searchController,
            onChanged: (value) {
              if (timer?.isActive == true) {
                timer?.cancel();
              }
              timer = Timer(const Duration(seconds: 1), () {
                _getData(value);
              });
              setState(() {});
            },
            validator: (value) {
              if (value!.isEmpty) {
                return LocaleKeys.type_word_to_search.tr();
              }
              return null;
            },
            filterIcon: true,
            inputType: InputType.search,
            iconPath: Assets.icons.search.path,
            hintText: LocaleKeys.search_about_you_want.tr(),
          ),
          if (searchBloc.searchController.text.isEmpty)
            BlocBuilder(
              bloc: bloc,
              builder: (BuildContext context, state) {
                if (state is CategoryProductLoadingState) {
                  return loadingWidget();
                } else if (state is CategoryProductSuccessState) {
                  if (state.list.isNotEmpty) {
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
                      ),
                      itemCount: state.list.length,
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                        onTap: () {
                          navigateTo(ProductDetailsScreen(
                            model: state.list[index],
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
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: Column(children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(11.r),
                                  child: Stack(
                                    alignment: AlignmentDirectional.topEnd,
                                    children: [
                                      Image.network(
                                        state.list[index].mainImage,
                                        fit: BoxFit.fill,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 4.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadiusDirectional.only(
                                                  bottomStart:
                                                      Radius.circular(10.r)),
                                        ),
                                        child: Text(
                                          "${state.list[index].stringDiscount}%",
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
                                      state.list[index].title,
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
                                    "${LocaleKeys.price.tr()} / ${state.list[index].unit.name}",
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
                                              "${state.list[index].stringPrice}\t${LocaleKeys.r_s.tr()}",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              " ${state.list[index].stringPriceBeforeDiscount}\t${LocaleKeys.r_s.tr()}",
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
                            ]),
                          ),
                        ),
                      ),
                    );
                  }
                  return Center(
                      child: Text(LocaleKeys.home_data_not_found.tr()));
                }
                return const SizedBox.shrink();
              },
            ),
          if (searchBloc.searchController.text.isNotEmpty)
            BlocBuilder(
              bloc: searchBloc,
              builder: (BuildContext context, state) {
                if (state is CategoryProductLoadingState) {
                  return loadingWidget();
                } else if (state is CategoryProductSuccessState) {
                  if (state.list.isNotEmpty) {
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
                      ),
                      itemCount: state.list.length,
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                        onTap: () {
                          navigateTo(ProductDetailsScreen(
                            model: state.list[index],
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
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: Column(children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(11.r),
                                  child: Stack(
                                    alignment: AlignmentDirectional.topEnd,
                                    children: [
                                      Image.network(
                                        state.list[index].mainImage,
                                        fit: BoxFit.fill,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 4.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadiusDirectional.only(
                                                  bottomStart:
                                                      Radius.circular(11.r)),
                                        ),
                                        child: Text(
                                          "${state.list[index].stringDiscount}%",
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
                                      state.list[index].title,
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
                                    "${LocaleKeys.price.tr()} / ${state.list[index].unit.name}",
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
                                              "${state.list[index].stringPrice}\t${LocaleKeys.r_s.tr()}",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              " ${state.list[index].stringPriceBeforeDiscount}\t${LocaleKeys.r_s.tr()}",
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
                            ]),
                          ),
                        ),
                      ),
                    );
                  }
                  return Center(
                      child: Text(LocaleKeys.home_data_not_found.tr()));
                }
                return const SizedBox.shrink();
              },
            ),
        ],
      ),
    );
  }
}
