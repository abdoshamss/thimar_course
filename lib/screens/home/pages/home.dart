import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/design/widgets/input.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/features/cart/add_to_cart/bloc.dart';
import 'package:thimar_course/features/categories/bloc.dart';
import 'package:thimar_course/features/category_product/bloc.dart';
 import 'package:thimar_course/features/slider/bloc.dart';
import 'package:thimar_course/gen/assets.gen.dart';
import 'package:thimar_course/screens/category_products.dart';
import 'package:thimar_course/screens/home/components/item_product.dart';
import 'package:thimar_course/screens/search_home.dart';
import 'package:thimar_course/screens/see_more_home.dart';

import '../../../core/design/widgets/app_image.dart';
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
  final productsDataBloc = KiwiContainer().resolve<ProductsDataBloc>();

  final categoryProductBloc = KiwiContainer().resolve<CategoryProductBloc>();
  // final searchBloc = KiwiContainer().resolve<SearchHomeBloc>();

  final addToCartBloc = KiwiContainer().resolve<AddToCartBloc>();
  @override
  void initState() {
    super.initState();
    productsDataBloc.add(GetProductsDataEvent());
  }

  @override
  void dispose() {
    super.dispose();
    categoriesBloc.close();
    categoryProductBloc.close();
    sliderBloc.close();
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
                  loadingWidget();
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
                  loadingWidget();
                } else if (state is CategoriesSuccessState) {
                  return SizedBox(
                    height: 135.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.list.list.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          navigateTo(CategoryProductsScreen(
                            model: state.list,
                            index: index,
                          ));
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                width: 80.w,
                                height: 80.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  color: const Color(0xffF6F9F3*2),
                                ),
                                clipBehavior: Clip.antiAlias,
                                padding: const EdgeInsets.all(16),
                                child: AppImage(
                                  fit: BoxFit.fill,
                                  width: 40.w,
                                  height: 40.h,
                                  path: state.list.list[index].media,
                                ),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              state.list.list[index].name,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        width: 16.w,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
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
                    loadingWidget();
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
                  }
                  return const SizedBox.shrink();
                }),
          ],
        ),
      ),
    );
  }
}
