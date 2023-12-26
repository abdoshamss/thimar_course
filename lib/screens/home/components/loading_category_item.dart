import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';


class LoadingCategoryItem extends StatelessWidget {
  const LoadingCategoryItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: (context, index) => Column(
        children: [
          Shimmer.fromColors(
            baseColor: Theme.of(context).primaryColor.withOpacity(.03),
            highlightColor: Theme.of(context).primaryColor.withOpacity(.3),
            child: Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: const Color(0xffF6F9F3 * 2),
              ),
              clipBehavior: Clip.antiAlias,
              padding: EdgeInsets.all(16.r),
              child: SizedBox(
                width: 40.w,
                height: 40.h,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Shimmer.fromColors(
              baseColor: Theme.of(context).primaryColor.withOpacity(.03),
              highlightColor: Theme.of(context).primaryColor.withOpacity(.3),
              child: SizedBox(
                height: 25.h,
                width: 40.w,
              )),
        ],
      ),
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(width: 16.w),
    );
  }
}
