import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/design/widgets/app_image.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/gen/assets.gen.dart';
import 'package:thimar_course/generated/locale_keys.g.dart';
import 'package:thimar_course/screens/cart.dart';

import '../../features/cart/show_cart/bloc.dart';
import '../../features/get_adresses/bloc.dart';
import '../../screens/add_address.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  final bloc = KiwiContainer().resolve<GetAddressesBloc>();
  final cardDataBLoc = KiwiContainer().resolve<CartDataBloc>()
    ..add(GetCartDataEvent());
  double opacityLevel = 1;


@override
  void initState() {

    super.initState();
    determinePosition();
  }
  @override
  void dispose() {
    super.dispose();
    bloc.close();
    cardDataBLoc.close();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: GestureDetector(
        onTap: () {
          bloc.add(GetAddressesDataEvent());
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(38.r),
                    topRight: Radius.circular(38.r))),
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.r),
                      child: Center(
                        child: Text(
                          LocaleKeys.home_addresses.tr(),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    BlocBuilder(
                      bloc: bloc,
                      builder: (BuildContext context, state) {
                        if (bloc.addressesList.isEmpty) {
                          return Padding(
                            padding: EdgeInsets.all(8.0.r),
                            child: const Center(
                              child: Text("لا توجد بيانات"),
                            ),
                          );
                        } else if (bloc.addressesList.isNotEmpty) {
                          return Column(
                            children: [
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: bloc.addressesList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 16.h),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w),
                                        width: 345.w,
                                        height: 100.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                            border: Border.all(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(.02),
                                                  offset: const Offset(0, 6))
                                            ]),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  bloc.addressesList[index]
                                                      .type,
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                                Text(
                                                  "${LocaleKeys.home_address.tr()} : ${bloc.addressesList[index].location}",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  bloc.addressesList[index]
                                                      .description,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .hintColor,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  bloc.addressesList[index]
                                                      .phone,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .hintColor,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 16.h,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      bloc.add(
                                                          RemoveAddressesDataEvent(
                                                              index: index,
                                                              id: bloc
                                                                  .addressesList[
                                                                      index]
                                                                  .id,
                                                              type: bloc
                                                                  .addressesList[
                                                                      index]
                                                                  .type));

                                                      setState(() {});
                                                    },
                                                    child: Image.asset(
                                                      Assets.icons.remove.path,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8.w,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      navigateTo(
                                                          AddAddressesScreen(
                                                        id: bloc
                                                            .addressesList[
                                                                index]
                                                            .id,
                                                        phone: bloc
                                                            .addressesList[
                                                                index]
                                                            .phone,
                                                        describe: bloc
                                                            .addressesList[
                                                                index]
                                                            .description,
                                                        type: bloc
                                                            .addressesList[
                                                                index]
                                                            .type,
                                                        lat: bloc
                                                            .addressesList[
                                                                index]
                                                            .lat,
                                                        lng: bloc
                                                            .addressesList[
                                                                index]
                                                            .lng,
                                                      ));
                                                    },
                                                    child: Image.asset(
                                                      Assets.icons.editAddress
                                                          .path,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          );
                        } else if (state is GetAddressesLoadingState) {
                          return loadingWidget();
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        navigateTo(AddAddressesScreen(
                          phone: '',
                          describe: '',
                          lng: 0,
                          lat: 0,
                          id: 0,
                        ));
                      },
                      child: DottedBorder(
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
                              LocaleKeys.home_add_addresses.tr(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Column(
            children: [
              Text(
                LocaleKeys.home_delivery_to.tr(),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 12.sp,
                ),
              ),
              Text(
              CacheHelper.getCurrentLocationName(),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),

              ),

            ],
          ),
        ),
      ),
      leadingWidth: 90.w,
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            Assets.images.logo.path,
            width: 20.w,
            height: 20.h,
          ),
          SizedBox(width: 4.w),
          Text(
            LocaleKeys.home_thamara_basket.tr(),
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.h,
              ),
              child: Stack(
                alignment: const Alignment(.75, -1.5),
                children: [
                  GestureDetector(
                    onTap: () {
                      if (CacheHelper.getToken()!.isNotEmpty) {
                        navigateTo(const CartScreen());
                      } else {
                        dialog();
                      }
                    },
                    child: Container(
                        padding: EdgeInsets.all(7.r),
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(.13),
                            borderRadius: BorderRadius.circular(9.r)),
                        child: AppImage(
                            path: Assets.icons.cartHome.path,
                            width: 16.w,
                            height: 18.h)),
                  ),
                  BlocBuilder(
                      bloc: cardDataBLoc,
                      builder: (context, state) {
                        return Container(
                            width: 12.w,
                            height: 12.h,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.white, width: 1.w)),
                            child: Center(
                              child: Text(
                                cardDataBLoc.cartData.length.toString(),
                                style: TextStyle(
                                  fontSize: 8.sp,
                                ),
                              ),
                            ));
                      }),
                ],
              ),
            )
          ],
        ),
        SizedBox(width: 16.w),
      ],
    );
  }Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission = await Geolocator.requestPermission();

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showMessage("Location services are disabled.",
          messageType: MessageType.warning);
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var currentLocation = await Geolocator.getCurrentPosition();


    print(currentLocation.latitude);
    print(currentLocation.longitude);


    await CacheHelper.saveCurrentLocation(currentLocation);
    await getLocation(currentLocation.latitude, currentLocation.longitude);


    return currentLocation;
  }
  Future<void> getLocation(double lat, double lng) async {

    List<Placemark> placeMarks = await placemarkFromCoordinates(lat, lng);
    print(placeMarks.toString());
    print("1" * 80);
    print(placeMarks[0].subAdministrativeArea.toString());
    await CacheHelper.setCurrentLocationName(placeMarks[0].locality.toString());
    setState(() {

    });

  }
}
