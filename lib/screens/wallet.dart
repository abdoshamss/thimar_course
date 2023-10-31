import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/widgets/custom_appbar.dart';
import '../gen/assets.gen.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarScreen(
          text: "المحفظة", image: Assets.icons.backHome.path),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Column(children: [
            SizedBox(
              height: 48.h,
            ),
            Center(
              child: Text(
                "رصيدك",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: 20.sp),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Center(
              child: Text(
                "255 ر.س",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: 24.sp),
              ),
            ),
            SizedBox(
              height: 75.h,
            ),
            DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(15.r),
              borderPadding: EdgeInsets.all(1.r),
              dashPattern: const [4, 4],
              color: Theme.of(context).primaryColor,
              child: Container(
                width: 345.w,
                height: 55.h,
                decoration: BoxDecoration(
                  color: const Color(0xffF9FCF5),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Center(
                  child: Text(
                    "اشحن الآن",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 64.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "سجل المعاملات",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                Text(
                  "عرض الكل",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).primaryColor),
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                      height: 16.h,
                    ),
                itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(Assets.icons.arrowTan.path),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              "شحن المحفظة",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp),
                            ),
                            const Spacer(),
                            const Text(
                              "يونيو,2021,",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xff9C9C9C)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 24.r),
                          child: Text(
                            "255 ر.س",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.sp,
                                color: Theme.of(context).primaryColor),
                          ),
                        )
                      ],
                    )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(Assets.icons.arrowVarRed.path),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      "دفعت مقابل هذا الطلب",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp),
                    ),
                    const Spacer(),
                    const Text(
                      "يونيو,2021,",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Color(0xff9C9C9C)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24.h,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 24.r),
                  child: Text(
                    "طلب #4587",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 116.w,
                          height: 25.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 4,
                            separatorBuilder: (context, index) => SizedBox(
                              width: 4.w,
                            ),
                            itemBuilder: (context, index) => Container(
                              width: 25.w,
                              height: 25.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.r),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          Assets.images.fruitSmall.path))),
                            ),
                          ),
                        ),
                        Container(
                          width: 25.w,
                          height: 25.h,
                          decoration: BoxDecoration(
                            color: Color(0xffEDF5E6),
                            borderRadius: BorderRadius.circular(7.r),
                          ),
                          child: Center(
                            child: Text(
                              "+2",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "180 ر.س",
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
