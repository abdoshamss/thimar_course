import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thimar_course/features/notifications/bloc.dart';
import 'package:thimar_course/generated/locale_keys.g.dart';

import '../../../core/design/widgets/app_login.dart';
import '../../../core/logic/cache_helper.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final bloc = KiwiContainer().resolve<NotificationsBloc>()
    ..add(GetNotificationsDataEvent());

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:   Text(
          LocaleKeys.home_nav_notifications.tr(),
        ),
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (BuildContext context, state) {
          if (CacheHelper.getToken()!.isEmpty) {
            return const AppLogin();
          }else
          if (state is NotificationsLoadingState) {
            return ListView.separated(
                padding: EdgeInsets.all(16.r),
                itemCount: 6,
                separatorBuilder: (context, index) => SizedBox(
                      height: 20.h,
                    ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsetsDirectional.only(
                      bottom: 6.h,
                      start: 10.h,
                      end: 10.w,
                      top: 11.w,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10.r,
                            offset: const Offset(0, 5),
                            color:   Colors.black.withOpacity(.01),
                          )
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: 35.w,
                              height: 35.h,
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.13),
                                  borderRadius: BorderRadius.circular(9.r)),
                              child: Padding(
                                  padding: EdgeInsets.all(6.0.r),
                                  child: Shimmer.fromColors(
                                    baseColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.1),
                                    highlightColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.03),
                                    child: SizedBox(
                                      width: 25.w,
                                      height: 25.h,
                                    ),
                                  ))),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.1),
                                  highlightColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.03),
                                  child: Text(
                                    "title",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Shimmer.fromColors(
                                  baseColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.1),
                                  highlightColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.03),
                                  child: Text(
                                    "body",
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        color: const Color(0xff989898)),
                                  ),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Shimmer.fromColors(
                                  baseColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.1),
                                  highlightColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.03),
                                  child: Text(
                                    "createdAt",
                                    style: TextStyle(fontSize: 10.sp),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          } else if (state is NotificationsSuccessState) {
            if (state.list.isEmpty) {
              return const Center(child: Text("لا توجد إشعارات"));
            } else {
              return ListView.separated(
                  padding: EdgeInsets.all(16.r),
                  itemCount: state.list.length,
                  separatorBuilder: (context, index) => SizedBox(
                        height: 20.h,
                      ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsetsDirectional.only(
                        bottom: 6.h,
                        start: 10.h,
                        end: 10.w,
                        top: 11.w,
                      ),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10.r,
                              offset: const Offset(0, 5),
                              color: const Color(0x01000000),
                            )
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 35.w,
                                height: 35.h,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.13),
                                    borderRadius: BorderRadius.circular(9.r)),
                                child: Padding(
                                  padding: EdgeInsets.all(6.0.r),
                                  child: Image.network(
                                    state.list[index].image,
                                    width: 25.w,
                                    height: 25.h,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Text("404"),
                                  ),
                                )),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.list[index].title,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Text(
                                    state.list[index].body,
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        color: const Color(0xff989898)),
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Text(
                                    state.list[index].createdAt,
                                    style: TextStyle(fontSize: 10.sp),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
          } else if (state is NotificationsErrorState) {
            return const Center(child: Text("لا توجد إشعارات"));
          }return const SizedBox.shrink();
        },
      ),
    );
  }
}
