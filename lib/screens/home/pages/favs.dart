import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

import '../../../core/logic/helper_methods.dart';
import '../../../features/FAVS/bloc.dart';

class FAVSPage extends StatefulWidget {
  const FAVSPage({Key? key}) : super(key: key);

  @override
  State<FAVSPage> createState() => _FAVSPageState();
}

class _FAVSPageState extends State<FAVSPage> {
  final favBloc = KiwiContainer().resolve<FavsBloc>();
  @override
  void initState() {
    favBloc.add(GetFAVSDataEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    favBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final bool isFav;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "المفضلة",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          BlocBuilder(
            bloc: favBloc,
            builder: (BuildContext context, state) {
              if (state is FAVSLoadingState) {
                loadingWidget();
              } else if (state is FAVSSuccessState) {
                return GridView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 160 / 215,
                    crossAxisSpacing: 16.h,
                  ),
                  itemCount: state.list.data.length,
                  itemBuilder: (BuildContext context, int index) => Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.02),
                          offset: const Offset(0, 2),
                          blurRadius: 11.r,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(11.r),
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Image.network(
                                  state.list.data[index].mainImage,
                                  fit: BoxFit.fill,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadiusDirectional.only(
                                        bottomStart: Radius.circular(11.r)),
                                  ),
                                  child: Text(
                                    "${state.list.data[index].discount * 100}%",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: Row(
                            children: [
                              Text(
                                state.list.data[index].title,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "السعر / كجم",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).hintColor),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: Row(
                            children: [
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                    text: "${state.list.data[index].price} ر.س",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        " ${state.list.data[index].priceBeforeDiscount} ر.س",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ]),
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
