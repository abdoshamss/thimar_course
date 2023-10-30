import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_course/core/design/widgets/input.dart';
import 'package:thimar_course/gen/assets.gen.dart';

import '../core/widgets/custom_appbar.dart';

class CompleteOrderScreen extends StatelessWidget {
  const CompleteOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarScreen(
        text: 'إتمام الطلب',
        image: Assets.icons.backHome.path,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          Text(
            "الإسم : محمد",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
                color: Theme.of(context).primaryColor),
          ),
          Text(
            "الجوال : 05068285914",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
                color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 36.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "اختر عنوان التوصيل",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                    color: Theme.of(context).primaryColor),
              ),
              Image.asset(
                Assets.icons.addBackground.path,
                width: 26.w,
                height: 26.h,
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Container(
            height: 35.h,
            width: 340.w,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17.r),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                )),
            child: GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "المنزل : 119 طريق الملك فيصل",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Image.asset(
                    Assets.icons.arrowDown.path,
                    width: 26.w,
                    height: 26.h,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 36.h,
          ),
          Text(
            "تحديد وقت التوصيل",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
                color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 165.w,
                height: 60.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(color: Color(0xffF3F3F3))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "اختر اليوم والتاريخ",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Image.asset(
                      Assets.icons.clock.path,
                      width: 18.w,
                      height: 18.h,
                    ),
                  ],
                ),
              ),
              Container(
                width: 165.w,
                height: 60.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(color: Color(0xffF3F3F3))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "اختر الوقت",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Image.asset(
                      Assets.icons.calender.path,
                      width: 18.w,
                      height: 18.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 24.h,
          ),
          Text(
            "ملاحظات وتعليمات",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
                color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 4.h,
          ),
          Input(
            validator: (value) {},
            inputType: InputType.normal,
            maxLines: 5,
          ),
          SizedBox(
            height: 32.h,
          ),
          Text(
            "اختر طريقة الدفع",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
                color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            children: [
              Container(
                width: 105.w,
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.r),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: .5.h)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      Assets.icons.money.path,
                      height: 25.h,
                      width: 30.w,
                    ),
                    Text(
                      "كاش",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ), SizedBox(
                width: 16.w,
              ),Container(
                width: 105.w,
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.r),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: .5.h)),
                child: Center(
                  child: Image.asset(Assets.icons.visaPay.path),
                ),
              ), SizedBox(
                width: 16.w,
              ),
            ],
          ),

        ],
      ),
    );
  }
}
