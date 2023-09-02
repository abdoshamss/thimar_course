import 'package:flutter/material.dart';
import 'package:thimar_course/screens/home_nav/pages/favs/view.dart';
import 'package:thimar_course/screens/home_nav/pages/home/view.dart';
import 'package:thimar_course/screens/home_nav/pages/my_account/view.dart';
import 'package:thimar_course/screens/home_nav/pages/notifications/view.dart';
import 'package:thimar_course/screens/home_nav/pages/orders/view.dart';


class HomeNavScreen extends StatefulWidget {
  const HomeNavScreen({Key? key}) : super(key: key);

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
    Icons.home_outlined,
    Icons.outlined_flag_rounded,
    Icons.notifications_active_outlined,
    Icons.favorite_border_outlined,
    Icons.account_circle_outlined,

  ];
  List<Widget> pages = [
       const HomePage(),
    const OrdersPage(),
    NotificationsPage(),
    const FAVPage(),
    const MyAccountPage(),
  ];
    int currentPage=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (value){
          currentPage=value ;

          setState(() {

          });
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
              child:Icon( icons[index],color: currentPage==index?Colors.white:const Color(0xffAED489),),
            ),
            label: titles[index],
          ),
        ),
      ),
    );
  }
}
