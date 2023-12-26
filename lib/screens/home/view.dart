import 'package:flutter/material.dart';
import 'package:thimar_course/gen/assets.gen.dart';
import 'package:thimar_course/screens/home/pages/order.dart';

import 'pages/favs.dart';
import 'pages/home.dart';
import 'pages/my_account.dart';
import 'pages/notifications.dart';

class HomeNavScreen extends StatefulWidget {
      int currentPage;
    HomeNavScreen({Key? key,  this.currentPage=0 }) : super(key: key);

  @override
  State<HomeNavScreen> createState() => _HomeNavScreenState();
}

class _HomeNavScreenState extends State<HomeNavScreen> {
  List<String> titles = [
    "الرئيسية",
    "طلباتي",
    "الاشعارات",
    "المفضلة",
    "حسابي",
  ];
  List icons = [
    Assets.icons.home.path,
    Assets.icons.orders.path,
    Assets.icons.notification.path,
    Assets.icons.favsHome.path,
    Assets.icons.user.path,
  ];
  List<Widget> pages = [
    const HomePage(),
    const MyOrdersPage(),
    const NotificationsPage(),
    const FAVSPage(),
    const MyAccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: pages[widget.currentPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex:widget. currentPage,
          onTap: (value) {
            widget.currentPage = value;

            setState(() {});
          },
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 12,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color(0xffAED489),
          items: List.generate(
            titles.length,
            (index) => BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Image.asset(
                  icons[index],
                  color: widget.currentPage == index
                      ? Colors.white
                      : const Color(0xffAED489),
                ),
              ),
              label: titles[index],
            ),
          ),
        ),
      ),
    );
  }
}
