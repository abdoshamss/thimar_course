import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/design/widgets/input.dart';
import 'package:thimar_course/gen/assets.gen.dart';

import '../core/logic/helper_methods.dart';
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
                    border: Border.all(color: const Color(0xffF3F3F3))),
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
                    border: Border.all(color: const Color(0xffF3F3F3))),
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
            validator: (value) {
              return null;
            },
            inputType: InputType.normal,
            maxLines: 5,
          ),
          SizedBox(
            height: 24.h,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 98.w,
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.r),
                    border: Border.all(color: Theme.of(context).primaryColor)),
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
              ),
              SizedBox(
                width: 16.w,
              ),
              Container(
                width: 98.w,
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.r),
                    border: Border.all(
                      color: const Color(0xffE9E9E9),
                    )),
                child: Center(
                  child: Image.asset(Assets.icons.visaPay.path),
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              Container(
                width: 98.w,
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.r),
                    border: Border.all(
                      color: const Color(0xffE9E9E9),
                    )),
                child: Center(
                  child: Image.asset(Assets.icons.mastercard.path),
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            "ملخص الطلب",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
                color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 8.h,
          ),
          Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                height: 145.h,
                decoration: BoxDecoration(
                  color: const Color(0xffF3F8EE),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 76.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "الخصم",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "-40ر.س",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Divider(
                        height: .5.h,
                        color: const Color(0xffE2E2E2),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "المجموع",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "180ر.س",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppButton(
                  text: "إنهاء الطلب",
                  onPress: () {
                    showModalBottomSheet(
                        context: navigatorKey.currentContext!,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(38.r),
                                topRight: Radius.circular(38.r))),
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Padding(
                              padding: EdgeInsets.all(16.0.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                      child: Image.asset(
                                          Assets.images.orderFinished.path,width: 250.w,height: 225.h,)),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  Text(
                                    "شكرا لك لقد تم تنفيذ طلبك بنجاح",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Text(
                                    "يمكنك متابعة حالة الطلب او الرجوع للرئيسية",
                                    style: TextStyle(
                                      color: const Color(0xffACACAC),
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 32.h,
                                  ), Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          // navigateTo(  CartScreen());
                                          FocusManager.instance.primaryFocus?.unfocus();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          fixedSize: Size(165.w, 60.h),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15.r),
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                           "طلباتي",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: Size(165.w, 60.h),
                                          side: BorderSide(
                                            color: Theme.of(context).primaryColor,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15.r),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                           "الرئيسية",
                                            style: TextStyle(
                                                color: Theme.of(context).primaryColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
