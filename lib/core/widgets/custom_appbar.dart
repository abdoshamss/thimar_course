import 'package:flutter/material.dart';
 import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBarScreen extends StatelessWidget
    implements PreferredSizeWidget {
  final String text;
  final String image;
     bool value;
     CustomAppBarScreen({Key? key, required this.text, required this.image,  this.value=false} )
      : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        text,
        style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor),
      ),
      centerTitle: true,
      leading: Row(
        children: [
          SizedBox(
            width: 16.w,
          ),
          GestureDetector(
              onTap: () {
                Navigator.pop(context,value);
              },
              child: Image.asset(
                image,
                width: 32.w,
                height: 32.h,
                fit: BoxFit.fill,
              )),
        ],
      ),
    );
  }
}
