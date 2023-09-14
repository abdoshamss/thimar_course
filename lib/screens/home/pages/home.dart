import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/design/widgets/input.dart';
import 'package:thimar_course/features/categories/bloc.dart';
import 'package:thimar_course/features/category_product/bloc.dart';
import 'package:thimar_course/features/slider/bloc.dart';
import 'package:thimar_course/gen/assets.gen.dart';

import '../../../core/widgets/MainAppBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final categoriesBloc = KiwiContainer().resolve<CategoriesBloc>()..add(GetCategoriesDataEvent());
  final categoryProductBloc = KiwiContainer().resolve<CategoryProductBloc>()..add(GetCategoryProductEvent());
  final sliderBloc = KiwiContainer().resolve<SliderDataBloc>()..add(GetSliderEvent());
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    categoriesBloc.close();
    categoryProductBloc.close();
    sliderBloc.close();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Input(
              validator: (value) {
                if (value == null || value.isEmpty) {
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
                return const Center(
                  child: CircularProgressIndicator(

                  ),
                );
              } else if (state is SliderDataSuccessState) {
                return SizedBox(
                  height: 165.h,
                  width: double.infinity,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 165.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        currentIndex = index;
                        setState(() {});
                      },
                    ),
                    items: List.generate(
                        state.list.length,
                        (index) => Image.network(
                              state.list[index].media,
                              height: 164.h,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            )),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                4,
                (index) => Padding(
                      padding: EdgeInsetsDirectional.only(end: 3.w),
                      child: CircleAvatar(
                        radius: 3.5.w,
                        backgroundColor: Theme.of(context)
                            .primaryColor
                            .withOpacity(currentIndex == index ? 1 : .38),
                      ),
                    )),
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
                  onPressed: () {},
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
                    itemCount: state.list.data.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            clipBehavior: Clip.antiAlias,
                            padding: const EdgeInsets.all(16),
                            child: Image.network(
                              state.list.data[index].media,
                              fit: BoxFit.fill,
                              width: 102,
                              height: 105.h,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          state.list.data[index].name,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: Text(
              "الأصناف",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          BlocBuilder(
              bloc: categoryProductBloc,
              builder: (context, state) {
                if (state is CategoryProductLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                } else if (state is CategoryProductSuccessState) {
                  return GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 160 / 250,
                      crossAxisSpacing: 16.h,
                    ),
                    itemCount: state.list.data.length,
                    itemBuilder: (BuildContext context, int index) => Container(
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
                                    state.list.data[index].mainImage,
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
                                      "${(state.list.data[index].discount * 100).toString()}%",
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
                                  state.list.data[index].title,
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
                                "السعر / ${state.list.data[index].unit.name}",
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
                                          "${state.list.data[index].price} ر.س",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          " ${state.list.data[index].priceBeforeDiscount} ر.س",
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
                          AppButton(
                            text: "أضف للسلة",
                            onPress: () {},
                            isBig: false,
                            // type: BtnType.outline,
                          ),
                        ]),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              })
        ],
      ),
    );
  }
}
