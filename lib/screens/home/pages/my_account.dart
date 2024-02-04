import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/features/auth/log_out/bloc.dart';
import 'package:thimar_course/gen/assets.gen.dart';
import 'package:thimar_course/generated/locale_keys.g.dart';
import 'package:thimar_course/screens/about_app.dart';
import 'package:thimar_course/screens/auth/login.dart';
import 'package:thimar_course/screens/contact_us.dart';
import 'package:thimar_course/screens/faqs.dart';
import 'package:thimar_course/screens/give_advices.dart';
import 'package:thimar_course/screens/privacy.dart';
import 'package:thimar_course/screens/profile.dart';
import 'package:thimar_course/screens/terms.dart';
import 'package:thimar_course/screens/wallet.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../features/get_profile/bloc.dart';
import '../../addrsses.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  final logoutBloc = KiwiContainer().resolve<LogOutBLoc>();
  final bloc = KiwiContainer().resolve<GetProfileDataBloc>()
    ..add(GetProfileDataEvent());
  @override
  void dispose() {
    super.dispose();
    logoutBloc.close();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 220.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.r),
                bottomRight: Radius.circular(40.r)),
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
                LocaleKeys.my_account_my_account.tr(),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              BlocBuilder(
                bloc: bloc,
                builder: (context,state) {
                  if(state is GetProfileDataSuccessState) {
                    return Container(
                    clipBehavior: Clip.antiAlias,
                    height: 75.h,
                    width: 75.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.r),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(state.list.data.image))),
                  );
                  }
                  return Container(
                    clipBehavior: Clip.antiAlias,
                    height: 75.h,
                    width: 75.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.r),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(CacheHelper.getImage()))),
                  );

                }
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    CacheHelper.getFullName().isEmpty
                        ? LocaleKeys.my_account_user_name.tr()
                        : CacheHelper.getFullName(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  if(CacheHelper.getIsVip()==1)
                  Image.asset(
                    Assets.icons.vip.path,
                    width: 30.w,
                    height: 30.h,
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                CacheHelper.getPhone().isNotEmpty ? "${CacheHelper.getPhone()}+" : "",
                style: TextStyle(
                    color: Colors.white.withOpacity(.7), fontSize: 16.sp),
              ),
            ],
          ),
        ),
        if (CacheHelper.getToken()!.isNotEmpty)
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
                      navigateTo(const EditProfileDetailsScreen(

                      )).then((value) {
                        if(value??false){
                          bloc.add(GetProfileDataEvent());
                        }
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(16.0.r),
                      child: Row(
                        children: [
                          Image.asset(
                            Assets.icons.userHome.path,
                            width: 18.w,
                            height: 18.h,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            LocaleKeys.my_account_personal_data.tr(),
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
                            LocaleKeys.my_account_wallet.tr(),
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
                            LocaleKeys.my_account_addresses.tr(),
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
                          LocaleKeys.my_account_faqs.tr(),
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
                          LocaleKeys.my_account_policy.tr(),
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
                          LocaleKeys.my_account_call_us.tr(),
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
                          LocaleKeys.my_account_complaints.tr(),
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
                ),
                GestureDetector(
                  onTap: () {
                    _launchUrl(Uri.parse(
                        "https://play.google.com/store/apps/details?id=com.alalmiya.thamra"));
                  },
                  child: Padding(
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
                          LocaleKeys.my_account_share_app.tr(),
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
                      // navigateTo(const AboutAppScreen());
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
                          LocaleKeys.my_account_about_app.tr(),
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
                ),
                GestureDetector(
                  onTap: () {
                    String code =
                        context.locale.languageCode == "en" ? "ar" : "en";
                    context.setLocale(Locale(code));
                    CacheHelper.setLanguage(context.locale.languageCode);
                    print(CacheHelper.getLanguage());
                  },
                  child: Padding(
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
                          LocaleKeys.my_account_change_language.tr(),
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
                ),
                GestureDetector(
                  onTap: () {
                    _launchUrl(Uri.parse(
                        "https://play.google.com/store/apps/details?id=com.alalmiya.thamra"));
                  },
                  child: Padding(
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
                          LocaleKeys.my_account_rate_app.tr(),
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
              if (CacheHelper.getToken()!.isEmpty) {
                navigateTo(const LoginScreen());
              } else {
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
                  padding: EdgeInsets.all(16.r),
                  child: Row(
                    children: [
                      Text(
                        CacheHelper.getToken()!.isEmpty
                            ? LocaleKeys.my_account_log_in.tr()
                            : LocaleKeys.my_account_log_out.tr(),
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Spacer(),
                      const Spacer(),
                      if (CacheHelper.getToken()!.isNotEmpty)
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

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
