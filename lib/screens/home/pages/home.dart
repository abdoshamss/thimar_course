import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
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
import 'package:thimar_course/screens/home/components/category_item.dart';
import 'package:thimar_course/screens/home/components/item_product.dart';
import 'package:thimar_course/screens/home/components/loading_category_item.dart';
import 'package:thimar_course/screens/home/components/loading_products.dart';
import 'package:thimar_course/screens/search_home.dart';
import 'package:thimar_course/screens/see_more_home.dart';

import '../../../core/widgets/HomeAppBar.dart';
import '../../../features/products/bloc.dart';

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
                controller: productsDataBloc.searchController,
                enable: () {
                  navigateTo(const SearchScreen());
                },
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
              bloc: sliderBloc,
              builder: (context, state) {
                if (state is SliderDataLoadingState) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        height: 200.h,
                       child:   Shimmer.fromColors(
                            baseColor:
                            Theme.of(context).primaryColor.withOpacity(.1),
                            highlightColor:
                            Theme.of(context).primaryColor.withOpacity(.3),
                        child: CarouselSlider(
                          items: List.generate(
                            4,
                            (index) => Image.network(
                              "https://www.healthyeating.org/images/default-source/home-0.0/nutrition-topics-2.0/general-nutrition-wellness/2-2-2-3foodgroups_fruits_detailfeature.jpg?sfvrsn=64942d53_4",
                              fit: BoxFit.fill,
                              width: double.infinity,
                            ),
                          ),
                          options: CarouselOptions(
                            height: 200.h,

                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
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
                        ),)
                      ),
                      Shimmer.fromColors(
                        baseColor:
                            Theme.of(context).primaryColor.withOpacity(.03),
                        highlightColor:
                            Theme.of(context).primaryColor.withOpacity(.3),
                        child: Padding(
                          padding: EdgeInsets.all(8.0.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              4,
                              (index) => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.r),
                                child: CircleAvatar(
                                  radius: 7,
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
                                autoPlayInterval: const Duration(seconds: 3),
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
                            padding: EdgeInsets.all(8.0.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                state.list.length,
                                (index) => Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.r),
                                  child: CircleAvatar(
                                    radius: 7,
                                    backgroundColor:
                                        sliderBloc.currentPage == index
                                            ? Colors.white
                                            : Colors.white.withOpacity(.38),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "الأقسام",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      navigateTo(const SeeMoreHomeScreen());
                    },
                    child: Text(
                      "عرض الكل",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w300,
                      ),
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
                      height: 135.h, child: const LoadingCategoryItem());
                } else if (state is CategoriesSuccessState) {
                  return SizedBox(
                      height: 135.h,
                      child: CategoryItem(
                        model: state.list,
                      ));
                } else if (state is CategoriesErrorState) {
                  Text(state.text ?? "لا يوجد بيانات");
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
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Text(
                  "الأصناف",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            BlocBuilder(
                bloc: productsDataBloc,
                builder: (context, state) {
                  if (state is GetProductsDataLoadingState) {
                    return const LoadingProductsItem();
                  } else if (state is GetProductsDataSuccessState) {
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
                      itemCount: state.list.length,
                      itemBuilder: (BuildContext context, int index) =>
                          ItemProduct(model: state.list[index]),
                    );
                  } else if (state is GetProductsDataErrorState) {
                    return Text(state.text ?? "لا يوجد بيانات");
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
