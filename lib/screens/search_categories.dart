import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:range_slider_flutter/range_slider_flutter.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/screens/product_details.dart';

import '../core/design/widgets/input.dart';
import '../core/logic/helper_methods.dart';
import '../features/search/search_categories/bloc.dart';
import '../gen/assets.gen.dart';

class SearchCategoriesScreen extends StatefulWidget {
  final int id;

  const SearchCategoriesScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<SearchCategoriesScreen> createState() => _SearchCategoriesStateScreen();
}

class _SearchCategoriesStateScreen extends State<SearchCategoriesScreen> {
  final searchBloc = KiwiContainer().resolve<SearchCategoriesBloc>();
  void _getData(String value) {
    searchBloc.add(GetSearchCategoriesDataEvent(id: widget.id, value: value));
  }

  double _lowerValue = 1200;
  double _upperValue = 1500;
  bool isSelectable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(Assets.icons.backHome.path)),
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "البحث",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                                  "تصفية",
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
                                "السعر",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              RangeSliderFlutter(
                                textColor: Colors.black,
                                rtl: true,
                                // key: Key('3343'),
                                values: [_lowerValue, _upperValue],
                                rangeSlider: true,

                                tooltip: RangeSliderFlutterTooltip(
                                    rightSuffix: const Text("ر.س"),
                                    alwaysShowTooltip: true,
                                    leftSuffix: const Text("ر.س"),
                                    textStyle: TextStyle(fontSize: 12.sp)),
                                max: 2000,

                                textPositionBottom: -130,
                                handlerHeight: 30,
                                trackBar: RangeSliderFlutterTrackBar(
                                  activeTrackBarHeight: 10,
                                  inactiveTrackBarHeight: 10,
                                  activeTrackBar: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  inactiveDisabledTrackBarColor: Colors.white,
                                  activeDisabledTrackBarColor: Colors.white,
                                  inactiveTrackBar: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xffDCE2D5),
                                  ),
                                ),

                                min: 1000,
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
                                "الترتيب",
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
                                      isSelectable = !isSelectable;
                                      setState2(() {});
                                    },
                                    child: Container(
                                        height: 21.h,
                                        width: 23.w,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: const Color(0xffECECEC),),
                                          borderRadius:
                                              BorderRadius.circular(6.r),
                                          color: isSelectable
                                              ? Theme.of(context).primaryColor
                                              : null,
                                        )),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    "من السعر الأقل للأعلي",
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
                                      isSelectable = !isSelectable;
                                      setState2(() {});
                                    },
                                    child: Container(
                                        height: 21.h,
                                        width: 23.w,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: const Color(0xffECECEC),),
                                          borderRadius:
                                              BorderRadius.circular(6.r),
                                          color: isSelectable
                                              ? null
                                              : Theme.of(context).primaryColor,
                                        )),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    "من السعر الأعلى للأقل",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 24.h,),
                              AppButton(text: "تطبيق", onPress: (){}),
                            ],
                          ),
                        );
                      }));
            },
            controller: searchBloc.searchController,
            onChanged: (value) {
              _getData(value);
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'اكتب كلمة للبحث ';
              }
              return null;
            },
            filterIcon: true,
            inputType: InputType.search,
            iconPath: Assets.icons.search.path,
            hintText: "ابحث عما تريد؟",
          ),
          BlocBuilder(
            bloc: searchBloc,
            builder: (BuildContext context, state) {
              if (state is SearchCategoriesLoadingState) {
                loadingWidget();
              } else if (state is SearchCategoriesSuccessState) {
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
                  itemCount: searchBloc.list.length,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                    onTap: () {
                      navigateTo(ProductDetailsScreen(
                        id: searchBloc.list[index].id,
                        price: searchBloc.list[index].price,
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
                        padding: const EdgeInsets.only(bottom: 16),
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
                                      "${searchBloc.list[index].discount * 100}%",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
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
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "السعر / كجم",
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
                          ),
                        ]),
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
