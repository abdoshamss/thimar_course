import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_course/core/design/widgets/app_image.dart';

class AppEmpty extends StatelessWidget {
  final String text;
  const AppEmpty({Key? key, this.text = "لا يوحد بيانات"}) : super(key: key);

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
