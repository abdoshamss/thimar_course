import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/widgets/custom_appbar.dart';
import 'package:thimar_course/gen/assets.gen.dart';

class BeVipScreen extends StatelessWidget {
  const BeVipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> vipText=[
"تسوق من المتجر ودفع التكاليف شهريا",
      "خصومات وكوبونات مخصصه لك",
      "دعم فني 24/7",
      "تسوق من المتجر ودفع التكاليف شهريا",

    ];
    return Scaffold(
      appBar: CustomAppBarScreen(
          text: " VIP تحويل لحساب ", image: Assets.icons.backHome.path),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 16.h,
            ),
            Image.asset(Assets.images.vip.path,width: 80.w,height: 100.h,),
            SizedBox(
              height: 16.h,
            ),
            Text(
              "VIP حساب",
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              "150 ر.س/شهريا حساب",
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp),
            ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.",
              style: TextStyle(
                  fontSize: 15.sp,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 24.h,
            ),
           Column(
             children: List.generate(4, (index) =>  Padding(
               padding:   EdgeInsets.only(
                bottom:   16.0.r),
               child: Row(
                 children: [
                   Image.asset(Assets.icons.checkVip.path),
                   SizedBox(
                     width: 8.w,
                   ),
                   Text(
                    vipText[index],
                     style: TextStyle(
                         fontSize: 15.sp,
                         fontWeight: FontWeight.w500,
                         color: Theme.of(context).primaryColor),
                   ),
                 ],
               ),
             ),),
           ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding:   EdgeInsets.all(16.0.r),
        child: AppButton(text: 'طلب تحويل', onPress: () {}),
      ),
    );
  }
}
