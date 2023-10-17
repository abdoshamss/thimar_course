import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/features/notifications/bloc.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final bloc = KiwiContainer().resolve<NotificationsBloc>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.add(GetNotificationsDataEvent());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "الاشعارات",
          style: TextStyle(
            fontSize: 20.sp,
          ),
        ),
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (BuildContext context, state) {
          if (state is NotificationsLoadingState) {
            loadingWidget();
          } else if (state is NotificationsSuccessState) {
            if (state.list.isEmpty) {
              Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              );
            } else {
              return ListView.separated(
                  padding: EdgeInsets.all(16.r),
                  itemCount: state.list.length,
                  separatorBuilder: (context, index) => SizedBox(
                        height: 20.h,
                      ),
                  itemBuilder: (context, index) {
                    ListView(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            bottom: 6.r,
                            start: 10.r,
                            end: 10,
                            top: 11.r,
                          ),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0.r),
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
                                        borderRadius:
                                            BorderRadius.circular(9.r)),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                        ),
                      ],
                    );
                    return null;
                  });
            }
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
