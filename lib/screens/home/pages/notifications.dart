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
  final bloc = KiwiContainer().resolve<NotificationsBloc>()
    ..add(GetNotificationsDataEvent());
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
            return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.list.length,
                separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                itemBuilder: (context, index) {
                  ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          bottom: 6,
                          start: 10,
                          end: 10,
                          top: 11,
                        ),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 10,
                                offset: Offset(0, 5),
                                color: Color(0x01000000),
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
                                      borderRadius: BorderRadius.circular(9)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Image.network(
                                      state.list[index].image,
                                      width: 25.w,
                                      height: 25.h,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Text("404"),
                                    ),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.list[index].title,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      state.list[index].body,
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: Color(0xff989898)),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      state.list[index].createdAt,
                                      style: const TextStyle(fontSize: 10),
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
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
