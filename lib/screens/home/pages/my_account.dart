import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/features/auth/log_out/bloc.dart';
import 'package:thimar_course/gen/assets.gen.dart';
import 'package:thimar_course/screens/about_app.dart';
import 'package:thimar_course/screens/auth/login.dart';
import 'package:thimar_course/screens/contact_us.dart';
import 'package:thimar_course/screens/faqs.dart';
import 'package:thimar_course/screens/give_advices.dart';
import 'package:thimar_course/screens/privacy.dart';
import 'package:thimar_course/screens/profile.dart';
import 'package:thimar_course/screens/wallet.dart';

import '../../addrsses.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
    final logoutBloc = KiwiContainer().resolve<LogOutBLoc>();

    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    logoutBloc.close();
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          height: 220.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.r),
            image: DecorationImage(
                image: AssetImage(
                  Assets.images.drawerBackground.path,
                ),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "حسابي",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                clipBehavior: Clip.antiAlias,
                height: 75.h,
                width: 75.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80"))),
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                "اسم المستخدم",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        if (CacheHelper.getToken()!=null)
        Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17.r),
              border: Border.all(color: const Color(0xffF6F6F6)),
            ),
            child: Column(
              children: [

                GestureDetector(
                  onTap: () {
                    navigateTo(const EditProfileDetailsScreen());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0.r),
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.icons.user.path,
                          width: 18.w,
                          height: 18.h,

                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          "البيانات الشخصية",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Image.asset(
                          Assets.icons.back.path,
                          width: 18.w,
                          height: 18.h,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: .3.h,
                  color: const Color(0xffF6F6F6),
                ),
                GestureDetector(
                  onTap: () {
                    navigateTo(const WalletScreen());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0.r),
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.icons.wallet.path,
                          width: 18.w,
                          height: 18.h,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          "المحفظة",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Image.asset(
                          Assets.icons.back.path,
                          width: 18.w,
                          height: 18.h,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: .3.h,
                  color: const Color(0xffF6F6F6),
                ),
                GestureDetector(
                  onTap: () {
                    navigateTo(const AddressesScreen());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0.r),
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.icons.address.path,
                          width: 18.w,
                          height: 18.h,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                         "العناوين",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Spacer(),
                        const Spacer(),
                        Image.asset(
                          Assets.icons.back.path,
                          width: 18.w,
                          height: 18.h,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: .3.h,
                  color: const Color(0xffF6F6F6),
                ),
                GestureDetector(
                  onTap: () {

                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0.r),
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.icons.dollar.path,
                          width: 18.w,
                          height: 18.h,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          "الدفع",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Image.asset(
                          Assets.icons.back.path,
                          width: 18.w,
                          height: 18.h,
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),


        Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17.r),
              border: Border.all(color: const Color(0xffF6F6F6)),
            ),
            child: Column(
              children: [

                GestureDetector(
                  onTap: () {
                    navigateTo(const FAQSScreen());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0.r),
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.icons.question.path,
                          width: 18.w,
                          height: 18.h,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          "أسئلة متكررة",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Image.asset(
                          Assets.icons.back.path,
                          width: 18.w,
                          height: 18.h,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: .3.h,
                  color: const Color(0xffF6F6F6),
                ),
                GestureDetector(
                  onTap: () {
                    navigateTo(const PrivacyScreen());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0.r),
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.icons.check.path,
                          width: 18.w,
                          height: 18.h,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          "سياسة الخصوصية",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Image.asset(
                          Assets.icons.back.path,
                          width: 18.w,
                          height: 18.h,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: .3.h,
                  color: const Color(0xffF6F6F6),
                ),
                GestureDetector(
                  onTap: () {
                    navigateTo(const ContactUsScreen());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0.r),
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.icons.call.path,
                          width: 18.w,
                          height: 18.h,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          "تواصل معنا",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Spacer(),
                        const Spacer(),
                        Image.asset(
                          Assets.icons.back.path,
                          width: 18.w,
                          height: 18.h,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: .3.h,
                  color: const Color(0xffF6F6F6),
                ),
                GestureDetector(
                  onTap: () {
                    navigateTo(const GiveAdvicesScreen());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0.r),
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.icons.edit.path,
                          width: 18.w,
                          height: 18.h,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          "الشكاوي والاقتراحات",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Image.asset(
                          Assets.icons.back.path,
                          width: 18.w,
                          height: 18.h,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: .3.h,
                  color: const Color(0xffF6F6F6),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0.r),
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.icons.share.path,
                        width: 18.w,
                        height: 18.h,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        "مشاركة التطبيق",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Spacer(),
                      const Spacer(),
                      Image.asset(
                        Assets.icons.back.path,
                        width: 18.w,
                        height: 18.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17.r),
              border: Border.all(color: const Color(0xffF6F6F6)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0.r),
                  child: GestureDetector(
                    onTap: () {
                      navigateTo(const AboutAppScreen());
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.icons.info.path,
                          width: 18.w,
                          height: 18.h,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          "عن التطبيق",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Spacer(),
                        const Spacer(),
                        Image.asset(
                          Assets.icons.back.path,
                          width: 18.w,
                          height: 18.h,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: .3.h,
                  color: const Color(0xffF6F6F6),
                ),

                Padding(
                  padding: EdgeInsets.all(16.0.r),
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.icons.note.path,
                        width: 18.w,
                        height: 18.h,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        "الشروط والاحكام",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Spacer(),
                      const Spacer(),
                      Image.asset(
                        Assets.icons.back.path,
                        width: 18.w,
                        height: 18.h,
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: .3.h,
                  color: const Color(0xffF6F6F6),
                ),       Padding(
                  padding: EdgeInsets.all(16.0.r),
                  child: Row(
                    children: [
                      Icon(
                        Icons.language,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        "تغيير اللغة",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Image.asset(
                        Assets.icons.back.path,
                        width: 18.w,
                        height: 18.h,
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: .3.h,
                  color: const Color(0xffF6F6F6),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0.r),
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.icons.star.path,
                        width: 18.w,
                        height: 18.h,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        "تقييم التطبيق",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Spacer(),
                      const Spacer(),
                      Image.asset(
                        Assets.icons.back.path,
                        width: 18.w,
                        height: 18.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        BlocConsumer(
          bloc: logoutBloc,
          listener: (BuildContext context, Object? state) {
            if (state is LogOutSuccessState) {
              CacheHelper.clearLoginData();
              navigateTo(const LoginScreen());
            }
          },
          builder: (BuildContext context, state) => GestureDetector(
            onTap: () {
              if (CacheHelper.getToken()==null){
                navigateTo(const LoginScreen());
              }else{

              logoutBloc.add(PostLogOutDataEvent());
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17.r),
                  border: Border.all(color: const Color(0xffF6F6F6)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0.r),
                  child: Row(
                    children: [
                      Text(
                       CacheHelper.getToken()==null?"تسجيل الدخول": "تسجيل الخروج",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Spacer(),
                      const Spacer(),
                      Image.asset(
                        Assets.icons.logOut.path,
                        width: 18.w,
                        height: 18.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
