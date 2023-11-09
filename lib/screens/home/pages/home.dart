import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/design/widgets/input.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/features/cart/add_to_cart/bloc.dart';
import 'package:thimar_course/features/categories/bloc.dart';
import 'package:thimar_course/features/category_product/bloc.dart';
import 'package:thimar_course/features/search/search_home/bloc.dart';
import 'package:thimar_course/features/slider/bloc.dart';
import 'package:thimar_course/gen/assets.gen.dart';
import 'package:thimar_course/screens/category_products.dart';
import 'package:thimar_course/screens/product_details.dart';
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
  final sliderBloc = KiwiContainer().resolve<SliderDataBloc>();
  final categoriesBloc = KiwiContainer().resolve<CategoriesBloc>();
  final categoryProductBloc = KiwiContainer().resolve<CategoryProductBloc>();
  final productsDataBloc = KiwiContainer().resolve<ProductsDataBloc>();
  final addToCartBloc = KiwiContainer().resolve<AddToCartBloc>();
  final searchBloc = KiwiContainer().resolve<SearchHomeBloc>();

  @override
  void initState() {
    super.initState();
    // Timer.periodic(const Duration(seconds: 5), (Timer timer) {
    //   if (currentPage < 2) {
    //     currentPage++;
    //   } else {
    //     currentPage = 0;
    //   }
    //   pageController.animateToPage(
    //     currentPage,
    //     duration: const Duration(seconds: 5),
    //     curve: Curves.easeIn,
    //   );
    // });
    sliderBloc.add(GetSliderEvent());
    categoriesBloc.add(GetCategoriesDataEvent());
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
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Input(
                  controller: searchBloc.searchController,
                  enable: () {
                    navigateTo( const SearchScreen());
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
                builder: (BuildContext context, state) {
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
                builder: (BuildContext context, state) {
                  if (state is CategoriesLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  } else if (state is CategoriesSuccessState) {
                    return SizedBox(
                      height: 135.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.list.list.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            navigateTo(CategoryProductsScreen(
                              title: state.list.list[index].name,
                              id: state.list.list[index].id,
                            ));
                          },
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  padding: const EdgeInsets.all(16),
                                  child: Image.network(
                                    state.list.list[index].media,
                                    fit: BoxFit.fill,
                                    width: 102.w,
                                    height: 105.h,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
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
                            GestureDetector(
                          onTap: () {
                            navigateTo(ProductDetailsScreen(
                              id: state.list[index].id,
                              price: state.list[index].price,
                              isFavorite: state.list[index].isFavorite,
                              amount: state.list[index].amount, index: null,
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
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadiusDirectional.only(
                                                    bottomStart:
                                                        Radius.circular(11.r)),
                                          ),
                                          child: Text(
                                            "${state.list[index].discount * 100}%",
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
                                      "السعر / ${state.list[index].unit.name}",
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
                                                "${state.list[index].price} ر.س",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                " ${state.list[index].priceBeforeDiscount} ر.س",
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
                                if (state.list[index].amount != 0)
                                  AppButton(
                                    text: "أضف للسلة",
                                    onPress: () {
                                      addToCartBloc.add(PostAddToCartDataEvent(
                                          id: state.list[index].id,
                                          amount: 1));
                                    },
                                    isBig: false,
                                  ),
                                if (state.list[index].amount == 0)
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
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
