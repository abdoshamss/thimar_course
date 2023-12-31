import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';
import 'package:thimar_course/generated/locale_keys.g.dart';

import '../../../core/design/widgets/btn.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../features/cart/add_to_cart/bloc.dart';
import '../../../features/products/bloc.dart';
import '../../product_details.dart';

class ItemProduct extends StatefulWidget {
  final ProductItemModel model;
  const ItemProduct({Key? key, required this.model}) : super(key: key);

  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  final addToCartBloc = KiwiContainer().resolve<AddToCartBloc>();
  @override
  void dispose() {
    super.dispose();
    addToCartBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(ProductDetailsScreen(
          model: widget.model,
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
                      widget.model.mainImage,
                      fit: BoxFit.fill,
                      width: 150.w,
                      height: 100.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadiusDirectional.only(
                            bottomStart: Radius.circular(11.r)),
                      ),
                      child: Text(
                        "${widget.model.stringDiscount}%",
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
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Row(
                      children: [
                        Text(
                          widget.model.title,
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
                        "${LocaleKeys.price.tr()} / ${widget.model.unit.name}",
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
                                  "${widget.model.stringPrice} ${LocaleKeys.r_s.tr()}",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text:
                                  " ${widget.model.stringPriceBeforeDiscount} ${LocaleKeys.r_s.tr()}",
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
                  if (widget.model.amount != 0)
                    BlocBuilder(
                      bloc: addToCartBloc,
                      builder: (BuildContext context, state) {
                        return AppButton(
                          isLoading: state is AddToCartLoadingState,
                          text: LocaleKeys.add_to_cart.tr(),
                          onPress: () {
                            if (CacheHelper.getToken()!.isNotEmpty) {
                              addToCartBloc.add(PostAddToCartDataEvent(
                                  id: widget.model.id, amount: 1));
                            } else {
                              dialog();
                            }
                          },
                          isBig: false,
                        );
                      },
                    ),
                  if (widget.model.amount == 0)
                    AppButton(
                      text: LocaleKeys.out_of_stock.tr(),
                      type: BtnType.cancel,
                      isBig: false,
                      onPress: null,
                    )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
