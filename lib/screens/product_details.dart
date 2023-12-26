import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/features/FAVS/bloc.dart';
import 'package:thimar_course/features/product_details/bloc.dart';
import 'package:thimar_course/features/product_rates/bloc.dart';
import 'package:thimar_course/gen/assets.gen.dart';

import '../core/logic/cache_helper.dart';
import '../features/cart/add_to_cart/bloc.dart';
import '../features/category_product/bloc.dart';
import '../features/products/bloc.dart';
import 'home/components/loading_products.dart';
import 'see_more_product_details.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductItemModel model;
  bool isHome;
  ProductDetailsScreen({
    Key? key,
    required this.model,
    this.isHome = false,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final pageController = PageController(initialPage: 0);

  int currentPage = 0;
  int counter = 1;
  final bloc = KiwiContainer().resolve<ProductDetailsBLoc>();

  final favsBloc = KiwiContainer().resolve<FavsBloc>();
  final addToCartBloc = KiwiContainer().resolve<AddToCartBloc>();
  final categoryProductBloc = KiwiContainer().resolve<CategoryProductBloc>();
  final productRatesBloc = KiwiContainer().resolve<ProductRatesBloc>()
    ..add(GetProductRatesEvent());

  @override
  void initState() {
    super.initState();

    bloc.add(GetProductDetailsEvent(
      id: widget.model.id,
    ));
    categoryProductBloc
        .add(GetCategoryProductEvent(id: widget.model.categoryId));
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
    favsBloc.close();
    addToCartBloc.close();
    categoryProductBloc.close();
    productRatesBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "تفاصيل المنتج",
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
        leading: Row(
          children: [
            SizedBox(
              width: 16.w,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  Assets.icons.backHome.path,
                  width: 32.w,
                  height: 32.h,
                  fit: BoxFit.fill,
                )),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: BlocConsumer(
              listener: (context, state) {
                if (state is RemoveFromFAVSState && widget.isHome) {
                  Navigator.pop(context, true);
                }
              },
              bloc: favsBloc,
              builder: (BuildContext context, state) {
                return GestureDetector(
                  onTap: () {
                    if (CacheHelper.getToken()!.isNotEmpty) {
                      if (widget.model.isFavorite) {

                        favsBloc
                            .add(PostRemoveFAVSDataEvent(id: widget.model.id));
                        widget.model.isFavorite = !widget.model.isFavorite;
                      } else {
                        favsBloc.add(PostAddFAVSDataEvent(id: widget.model.id));
                        widget.model.isFavorite = !widget.model.isFavorite;
                      }
                    } else {
                      dialog();
                    }
                  },
                  child: Container(
                    width: 32.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                        color: widget.model.isFavorite
                            ? Colors.red.withOpacity(.13)
                            : const Color(0xff4C8613).withOpacity(.13),
                        borderRadius: BorderRadius.circular(9.r)),
                    child: Icon(
                      Icons.favorite,
                      size: 24,
                      color: widget.model.isFavorite ? Colors.red : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if (state is ProductDetailsLoadingState) {
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
                                  (index) => const SizedBox(
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
                                  scrollDirection: Axis.horizontal,
                                  onPageChanged: (index, c) {},
                                  viewportFraction: 1,
                                  padEnds: false,
                                ),
                              ),
                            )),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.r),
                                  child: const CircleAvatar(
                                    radius: 7,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state is ProductDetailsSuccessState) {
                    return Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 200.h,
                              child: PageView(
                                onPageChanged: (value) {
                                  currentPage = value;
                                },
                                controller: pageController,
                                physics: const ClampingScrollPhysics(),
                                children: List.generate(
                                  widget.model.images.isNotEmpty
                                      ? widget.model.images.length
                                      : 1,
                                  (index) => Container(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(40.r),
                                          bottomLeft: Radius.circular(
                                            40.r,
                                          )),
                                    ),
                                    child: Image.network(
                                      widget.model.images.isNotEmpty
                                          ? widget.model.images[index].url
                                          : widget.model.mainImage,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (widget.model.images.length > 1)
                              Padding(
                                padding: EdgeInsets.all(8.0.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    widget.model.images.length,
                                    (index) => Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.r),
                                      child: CircleAvatar(
                                        radius: 7,
                                        backgroundColor: currentPage == index
                                            ? Colors.white
                                            : Colors.white.withOpacity(.38),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.r),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.model.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.sp,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              '${widget.model.stringDiscount}% ',
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Colors.red,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '${widget.model.stringPrice}ر.س',
                                          style: TextStyle(
                                            fontSize: 17.sp,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '  ${widget.model.stringPriceBeforeDiscount}ر.س ',
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w400,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "السعر / ${widget.model.unit.name}",
                                    style: TextStyle(
                                        fontSize: 19.sp,
                                        color: Theme.of(context).hintColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Container(
                                    width: 110.w,
                                    height: 35.h,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(.11),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            counter++;
                                            setState(() {});
                                          },
                                          child: Container(
                                            height: 30.h,
                                            width: 30.w,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(.02),
                                                  blurStyle: BlurStyle.inner,
                                                  offset: const Offset(0, 3),
                                                )
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                            child: Image.asset(
                                                Assets.icons.add.path),
                                          ),
                                        ),
                                        BlocBuilder(
                                            bloc: bloc,
                                            builder: (context, state) {
                                              return Text(
                                                counter.toString(),
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              );
                                            }),
                                        GestureDetector(
                                          onTap: () {
                                            if (counter > 1) {
                                              counter--;
                                              setState(() {});
                                            }
                                          },
                                          child: Container(
                                            height: 30.h,
                                            width: 30.w,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(.02),
                                                  blurStyle: BlurStyle.inner,
                                                  offset: const Offset(0, 3),
                                                )
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                            child: Image.asset(
                                                Assets.icons.minus.path),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              const Divider(
                                color: Color(0xffF9F9F9),
                                thickness: 2,
                                height: 1,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                child: Row(
                                  children: [
                                    Text(
                                      "كود المنتج",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.sp,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    Text(
                                      "${widget.model.id}#",
                                      style: TextStyle(
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.w300,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Color(0xffF9F9F9),
                                thickness: 2,
                                height: 1,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "تفاصيل المنتج",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                widget.model.description,
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontWeight: FontWeight.w300,
                                ),
                                maxLines: 4,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "التقييمات",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.sp,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        navigateTo(const SeeMoreRatesScreen());
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
                bloc: productRatesBloc,
                builder: (context, state) {
                  if (state is ProductRatesLoadingState) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r)),
                      height: 90.h,
                      width: 270.w,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.1),
                                    highlightColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.03),
                                    child: SizedBox(
                                      width: 70.w,
                                      child: Text(
                                        "clientName",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Shimmer.fromColors(
                                      baseColor: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(.1),
                                      highlightColor: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(.03),
                                      child: RatingBar.builder(
                                        initialRating: 4,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        ignoreGestures: true,
                                        itemCount: 5,
                                        itemSize: 18,
                                        itemPadding: EdgeInsets.zero,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          debugPrint(rating.toString());
                                        },
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Shimmer.fromColors(
                                  baseColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.1),
                                  highlightColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.03),
                                  child: SizedBox(
                                      height: 40.h,
                                      width: 200.w,
                                      child: Text(
                                        "comment",
                                        style: TextStyle(fontSize: 12.sp),
                                        maxLines: 2,
                                      )))
                            ],
                          ),
                          const Spacer(),
                          Shimmer.fromColors(
                            baseColor:
                                Theme.of(context).primaryColor.withOpacity(.1),
                            highlightColor:
                                Theme.of(context).primaryColor.withOpacity(.03),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 55.h,
                                width: 55.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is ProductRatesSuccessState) {
                    return SizedBox(
                      height: 85.h,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        scrollDirection: Axis.horizontal,
                        itemCount: state.list.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                          width: 16.w,
                        ),
                        itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r)),
                          height: 90.h,
                          width: 270.w,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 70.w,
                                        child: Text(
                                          state.list[index].clientName,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      RatingBar.builder(
                                        initialRating: state.list[index].value,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        ignoreGestures: true,
                                        itemCount: 5,
                                        itemSize: 18,
                                        itemPadding: EdgeInsets.zero,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          debugPrint(rating.toString());
                                        },
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  SizedBox(
                                      height: 40.h,
                                      width: 200.w,
                                      child: Text(
                                        state.list[index].comment,
                                        style: TextStyle(fontSize: 12.sp),
                                        maxLines: 2,
                                      ))
                                ],
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: 55.h,
                                  width: 55.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        state.list[index].clientImage,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 16.r,
                  right: 16.r,
                  left: 16.r,
                ),
                child: Row(
                  children: [
                    Text(
                      "منتجات مشابهة",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.sp,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder(
                bloc: categoryProductBloc,
                builder: (context, state) {
                  if (state is CategoryProductLoadingState) {
                    return const LoadingProductsItem();
                  } else if (state is CategoryProductSuccessState) {
                    return SizedBox(
                      height: 215.h,
                      width: double.infinity,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => SizedBox(
                          width: 16.w,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
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
                              padding: EdgeInsets.only(bottom: 16.r),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                                            bottomStart:
                                                                Radius.circular(
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
                                          "السعر / ${state.list[index].unit.name}",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Theme.of(context).hintColor),
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
                                                    "${state.list[index].stringPrice} ر.س",
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    " ${state.list[index].stringPriceBeforeDiscount} ر.س",
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
                                  ]),
                            ),
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
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        height: 60.h,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          children: [
            BlocBuilder(
                bloc: addToCartBloc,
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      if (CacheHelper.getToken()!.isNotEmpty) {
                        addToCartBloc.add(PostAddToCartDataEvent(
                            id: widget.model.id,
                            counter: counter,
                            amount: double.parse(counter.toString())));
                      } else {
                        dialog();
                      }
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 35.w,
                          height: 35.h,
                          decoration: BoxDecoration(
                            color: const Color(0xff6AA431),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Image.asset(
                            Assets.icons.cart.path,
                            width: 20.w,
                            height: 20.h,
                          ),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Text(
                          "إضافة إلي السلة",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            const Spacer(),
            BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  return Text(
                    "${counter * widget.model.price} ر.س",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
