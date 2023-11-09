import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/screens/product_details.dart';

import '../core/design/widgets/input.dart';
import '../features/category_product/bloc.dart';
import '../gen/assets.gen.dart';
import 'search_categories.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String title;
  final int id;
  const CategoryProductsScreen(
      {Key? key, required this.title, required this.id})
      : super(key: key);

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  final bloc = KiwiContainer().resolve<CategoryProductBloc>();
  @override
  void initState() {
    super.initState();
    bloc.add(GetCategoryProductEvent(id: widget.id));
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

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
          widget.title,
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
            enable: () {
              navigateTo(SearchCategoriesScreen(
                id: widget.id, minPrice: 1,
                maxPrice:999 ,
              ));
            },
            isEnabled: false,
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
            bloc: bloc,
            builder: (BuildContext context, state) {
              if (state is CategoryProductLoadingState) {
                loadingWidget();
              } else if (state is CategoryProductSuccessState) {
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
                  itemCount: state.list.list.length,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                    onTap: () {
                      navigateTo(ProductDetailsScreen(

                        id: state.list.list[index].id,
                        price: state.list.list[index].price,
                        isFavorite: state.list.list[index].isFavorite,
                        amount: state.list.list[index].amount, index: null,
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
                                    state.list.list[index].mainImage,
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
                                      "${state.list.list[index].discount * 100}%",
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
                                  state.list.list[index].title,
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
                                          "${state.list.list[index].price} ر.س",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          " ${state.list.list[index].priceBeforeDiscount} ر.س",
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
