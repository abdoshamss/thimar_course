import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_course/core/design/widgets/icon_with_bg.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';
import 'package:thimar_course/gen/assets.gen.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            GestureDetector(
              onTap: (){
                if(Navigator.canPop(context))
                  {
                    Navigator.pop(context);

                  }
              },
              child: Image.asset(
               Assets.images.logo.path,
                width: 20.w,
                height: 20.h,
              ),
            ),
            SizedBox(
              width: 3.w,
            ),
            Text(
              "سلة ثمار",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "التوصيل الي",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                   CacheHelper.getCityName(),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Badge(
              backgroundColor: Theme.of(context).primaryColor,
              smallSize: 8.w,
              alignment: AlignmentDirectional.topStart,
              label: const Text("3"),
              child: IconWithBg(
                icon: Icons.lock,
                iconPadding: 12.r,
                onPress: () {},
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(45.h);
}
