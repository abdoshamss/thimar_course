import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_course/core/design/widgets/app_image.dart';
import 'package:thimar_course/generated/locale_keys.g.dart';

class AppEmpty extends StatelessWidget {
  final String text = LocaleKeys.home_data_not_found.tr();
  AppEmpty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppImage(
          path:
              "https://notjustalabel-prod.s3-accelerate.amazonaws.com/s3fs-public/images/designers/209585/avatar/content_not_found_notjustalabel_127658440.jpg",
          width: 100.w,
          height: 100.h,
        ),
        Text(text),
      ],
    );
  }
}
