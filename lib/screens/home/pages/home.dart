import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thimar_course/core/design/widgets/input.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/features/cart/add_to_cart/bloc.dart';
import 'package:thimar_course/features/categories/bloc.dart';
import 'package:thimar_course/features/category_product/bloc.dart';
import 'package:thimar_course/features/slider/bloc.dart';
import 'package:thimar_course/gen/assets.gen.dart';
import 'package:thimar_course/generated/locale_keys.g.dart';
import 'package:thimar_course/screens/home/components/category_item.dart';
import 'package:thimar_course/screens/home/components/item_product.dart';
import 'package:thimar_course/screens/home/components/loading_category_item.dart';
import 'package:thimar_course/screens/home/components/loading_products.dart';
import '../../../core/design/widgets/btn.dart';
import '../../../core/widgets/HomeAppBar.dart';
import '../../../features/products/bloc.dart';
import '../../product_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final sliderBloc = KiwiContainer().resolve<SliderDataBloc>()
    ..add(GetSliderEvent());
  final categoriesBloc = KiwiContainer().resolve<CategoriesBloc>()
    ..add(GetCategoriesDataEvent());
  final productsDataBloc = KiwiContainer().resolve<ProductsDataBloc>()
    ..add(GetProductsDataEvent());

  final categoryProductBloc = KiwiContainer().resolve<CategoryProductBloc>();

  final addToCartBloc = KiwiContainer().resolve<AddToCartBloc>();
  Timer? timer;
  void _getData(String value) {
    productsDataBloc.add(GetProductsDataEvent(value: value, id: null));
  }
  @override
  void dispose() {
    super.dispose();
    categoriesBloc.close();
    categoryProductBloc.close();
    sliderBloc.close();
    addToCartBloc.close();
    productsDataBloc.close();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Input(
                onChanged: (value) {
                  if (timer?.isActive==true ) {
                    timer?.cancel();
                  }
                  timer = Timer(const Duration(seconds: 1), () {
                    _getData(value);
                  });
                  setState(() {});
                },
                controller: productsDataBloc.searchController,
                textInputAction: TextInputAction.search,
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.type_word_to_search.tr();
                  }
                  return null;
                },
                inputType: InputType.search,
                iconPath: Assets.icons.search.path,
                hintText: LocaleKeys.search_about_you_want.tr(),
              ),
            ),
            if (productsDataBloc.searchController.text.isEmpty)
              Column(
                children: [
                  BlocBuilder(
                    bloc: sliderBloc,
                    builder: (context, state) {
                      if (state is SliderDataLoadingState) {
                        return Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            SizedBox(
                                height: 200.h,
                                child: Shimmer.fromColors(
                                  baseColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.1),
                                  highlightColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.3),
                                  child: CarouselSlider(
                                    items: List.generate(
                                      4,
                                      (index) => SizedBox(
                                        height: 200.h,
                                      ),
                                    ),
                                    options: CarouselOptions(
                                      height: 200.h,
                                      autoPlay: true,
                                      autoPlayInterval:
                                          const Duration(seconds: 3),
                                      autoPlayAnimationDuration:
                                          const Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      // enlargeCenterPage: true,
                                      scrollDirection: Axis.horizontal,
                                      onPageChanged: (index, c) {
                                        sliderBloc.currentPage = index;
                                      },

                                      viewportFraction: 1,
                                      padEnds: false,
                                    ),
                                  ),
                                )),
                            Shimmer.fromColors(
                              baseColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.03),
                              highlightColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.3),
                              child: Padding(
                                padding: EdgeInsets.all(8.0.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    4,
                                    (index) => Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.r),
                                      child: CircleAvatar(
                                        radius: 7.r,
                                        backgroundColor:
                                            sliderBloc.currentPage == index
                                                ? Colors.white
                                                : Colors.white.withOpacity(.38),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (state is SliderDataSuccessState) {
                        return StatefulBuilder(
                          builder: (context, setState2) {
                            return Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                SizedBox(
                                  height: 200.h,
                                  child: CarouselSlider(
                                    items: List.generate(
                                      state.list.length,
                                      (index) => Image.network(
                                        state.list[index].media,
                                        fit: BoxFit.fill,
                                        width: double.infinity,
                                      ),
                                    ),
                                    options: CarouselOptions(
                                      height: 200.h,

                                      autoPlay: true,
                                      autoPlayInterval:
                                          const Duration(seconds: 3),
                                      autoPlayAnimationDuration:
                                          const Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      // enlargeCenterPage: true,
                                      scrollDirection: Axis.horizontal,
                                      onPageChanged: (index, c) {
                                        sliderBloc.currentPage = index;
                                        setState2(() {});
                                      },

                                      viewportFraction: 1,
                                      padEnds: false,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.r),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      state.list.length,
                                      (index) => Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w),
                                        child: CircleAvatar(
                                          radius: 3.5.r,
                                          backgroundColor:
                                              sliderBloc.currentPage == index
                                                  ? Colors.white
                                                  : Colors.white
                                                      .withOpacity(.38),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else if (state is SliderDataErrorState) {
                        return Center(
                            child: Text(state.text ??
                                LocaleKeys.home_data_not_found.tr()));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys.home_categories.tr(),
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder(
                    bloc: categoriesBloc,
                    builder: (context, state) {
                      if (state is CategoriesLoadingState) {
                        return SizedBox(
                            height: 120.h, child: const LoadingCategoryItem());
                      } else if (state is CategoriesSuccessState) {
                        return SizedBox(
                            height: 120.h,
                            child: CategoryItem(
                              model: state.list,
                            ));
                      } else if (state is CategoriesErrorState) {
                        return Center(
                            child: Text(state.text ??
                                LocaleKeys.home_data_not_found.tr()));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      child: Text(
                        LocaleKeys.home_items.tr(),
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),

                ],
              ),

              BlocBuilder(
                  bloc: productsDataBloc,
                  builder: (context, state) {
                    if (state is GetProductsDataLoadingState) {
                      return LoadingProductsItem();
                    } else if (state is GetProductsDataSuccessState) {
                      if (state.list.isNotEmpty) {
                        return GridView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 160 / 215,
                              crossAxisSpacing: 16.h,
                              mainAxisSpacing: 16.w,
                            ),
                            itemCount: state.list.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
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
                                    padding: EdgeInsets.only(bottom: 16.r),
                                    child: Column(children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(11.r),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional.topEnd,
                                            children: [
                                              Image.network(
                                                state.list[index].mainImage,
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
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .only(
                                                              bottomStart: Radius
                                                                  .circular(
                                                                      11.r)),
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
                                        padding:
                                            EdgeInsets.symmetric(vertical: 4.h),
                                        child: Row(
                                          children: [
                                            Text(
                                              state.list[index].title,
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .primaryColor),
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
                                                color: Theme.of(context)
                                                    .hintColor),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 4.h),
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
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                              ]),
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (state.list[index].amount != 0)
                                        AppButton(
                                          text: LocaleKeys.add_to_cart.tr(),
                                          onPress: () {
                                            addToCartBloc.add(
                                                PostAddToCartDataEvent(
                                                    id: state.list[index].id,
                                                    amount: state
                                                        .list[index].amount));
                                          },
                                          isBig: false,
                                        ),
                                      if (state.list[index].amount == 0)
                                        Text(
                                          LocaleKeys.out_of_stock.tr(),
                                          style: const TextStyle(
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
                    }
                    return const SizedBox.shrink();
                  }),
          ],
        ),
      ),
    );
  }
}
