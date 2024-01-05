import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/design/widgets/app_image.dart';
import 'package:thimar_course/core/design/widgets/bottom_sheet_home_appbar.dart';
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
  final bloc = KiwiContainer().resolve<AddressesBloc>();
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
        if(CacheHelper.getToken()!.isNotEmpty){
          bloc.add(GetAddressesDataEvent());
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(38.r),
                    topRight: Radius.circular(38.r))),
            context: context,
            builder: (context) =>const BottomSheetInHomeAppBar() ,
          );
        }
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
      leadingWidth: 100.w,
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          Image.asset(
            Assets.images.logo.path,
            width: 20.w,
            height: 20.h,
          ),
          // SizedBox(width: 4.w),
          Text(
            LocaleKeys.home_thamara_basket.tr(),
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          if(CacheHelper.getLanguage()=="ar")
          SizedBox(
            width: 15 .w,
          )
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
  }

  Future<Position> determinePosition() async {
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
    List<Placemark> placeMarks = await placemarkFromCoordinates(lat, lng,localeIdentifier:"EG");
    print(placeMarks.toString());
    print("1" * 80);
    print(placeMarks[0].subAdministrativeArea.toString());
    await CacheHelper.setCurrentLocationName(placeMarks[0].locality.toString());
    setState(() {});
  }
}
