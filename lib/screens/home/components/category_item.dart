import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/design/widgets/app_image.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../features/categories/bloc.dart';
import '../../category_products.dart';

class CategoryItem extends StatelessWidget {
  final CategoriesData model;
  const CategoryItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: model.list.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          navigateTo(CategoryProductsScreen(
            model: model,
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
                  color: const Color(0xffF6F9F3 * 2),
                ),
                clipBehavior: Clip.antiAlias,
                padding:   EdgeInsets.all(16.r),
                child: AppImage(
                  fit: BoxFit.fill,
                  width: 40.w,
                  height: 40.h,
                  path: model.list[index].media,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              model.list[index].name,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      separatorBuilder: (BuildContext context, int index) => SizedBox(
        width: 16.w,
      ),
    );
  }
}
