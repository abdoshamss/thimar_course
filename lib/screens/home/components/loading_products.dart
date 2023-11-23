import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/design/widgets/btn.dart';

class LoadingProductsItem extends StatelessWidget {
  const LoadingProductsItem ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    GridView.builder(
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
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(11.r),
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Theme.of(context)
                            .primaryColor
                            .withOpacity(.1),
                        highlightColor: Theme.of(context)
                            .primaryColor
                            .withOpacity(.03),
                        child: Image.network(
                          "https://www.healthyeating.org/images/default-source/home-0.0/nutrition-topics-2.0/general-nutrition-wellness/2-2-2-3foodgroups_fruits_detailfeature.jpg?sfvrsn=64942d53_4",
                          fit: BoxFit.fill,
                          width: 145.w,
                          height: 120.h,
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: Theme.of(context)
                            .primaryColor
                            .withOpacity(.1),
                        highlightColor: Theme.of(context)
                            .primaryColor
                            .withOpacity(.03),
                        child: Container(
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
                          child: const Text("      "),
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
                    SizedBox(
                      width: 40.w,
                      height: 20.h,
                      child: Shimmer.fromColors(
                        baseColor: Theme.of(context)
                            .primaryColor
                            .withOpacity(.1),
                        highlightColor: Theme.of(context)
                            .primaryColor
                            .withOpacity(.03),
                        child: Container(
                          color: Theme.of(context)
                              .primaryColor
                              .withOpacity(.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: Theme.of(context)
                        .primaryColor
                        .withOpacity(.1),
                    highlightColor: Theme.of(context)
                        .primaryColor
                        .withOpacity(.03),
                    child: Container(
                      color: Theme.of(context)
                          .primaryColor
                          .withOpacity(.8),
                      width: 60.w,
                      height: 20.h,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Row(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Theme.of(context)
                          .primaryColor
                          .withOpacity(.1),
                      highlightColor: Theme.of(context)
                          .primaryColor
                          .withOpacity(.03),
                      child: Container(
                        width: 100.w,
                        height: 20.h,
                        color: Theme.of(context)
                            .primaryColor
                            .withOpacity(.8),
                      ),
                    ),
                  ],
                ),
              ),
              Shimmer.fromColors(
                  baseColor: Theme.of(context)
                      .primaryColor
                      .withOpacity(.03),
                  highlightColor: Theme.of(context)
                      .primaryColor
                      .withOpacity(.3),
                  child: AppButton(
                    text: "تم نفاذ الكمية",
                    type: BtnType.cancel,
                    isBig: false,
                    onPress: () {},
                  ))
            ]),
          );
        });
  }
}
