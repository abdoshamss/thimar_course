import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

import '../core/design/widgets/icon_with_bg.dart';
import '../core/logic/helper_methods.dart';
import '../features/product_rates/bloc.dart';

class SeeMoreRatesScreen extends StatefulWidget {
  const SeeMoreRatesScreen({Key? key}) : super(key: key);

  @override
  State<SeeMoreRatesScreen> createState() => _SeeMoreRatesStateScreen();
}

class _SeeMoreRatesStateScreen extends State<SeeMoreRatesScreen> {
  final bloc = KiwiContainer().resolve<ProductRatesBloc>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.add(GetProductRatesEvent());
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
        title: Text(
          "التقييمات",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leadingWidth: 70.w,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          child: IconWithBg(
            icon: Icons.arrow_back_ios_outlined,
            color: Theme.of(context).primaryColor,
            onPress: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is ProductRatesLoadingState) {
            loadingWidget();
          } else if (state is ProductRatesSuccessState) {
            return GridView.builder(

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 270/90
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              scrollDirection: Axis.vertical,
              itemCount: state.list.length,
              itemBuilder: (context, index) => Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
                height: 100.h,
                child: Row(
                  children: [
                    Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              state.list[index].clientName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.sp,
                              ),
                            ),
                            SizedBox(
                              width: 6.w,
                            ),
                            RatingBar.builder(
                              initialRating: state.list[index].value,
                              minRating: 1,
                              direction: Axis.horizontal,
                              ignoreGestures: true,
                              itemCount: 5,
                              itemSize: 18,
                              itemPadding: EdgeInsets.zero,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                debugPrint(rating.toString());
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        SizedBox(
                            height: 60.h,
                            width: 120.w,
                            child: Text(
                              state.list[index].comment,

                              maxLines: 2,
                            ))
                      ],
                    ),
                   const Spacer(),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          image: DecorationImage(
                            image: NetworkImage(
                              state.list[index].clientImage,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
