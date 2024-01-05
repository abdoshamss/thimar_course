import 'package:flutter/material.dart';
 import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_course/gen/assets.gen.dart';

class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String text;

     bool value;
     CustomAppBar({Key? key, required this.text,  this.value=false} )
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

      leading: Row(

        children: [
          SizedBox(
            width: 16.w,
          ),
          GestureDetector(onTap: (){
            Navigator.pop(context,value);
          },
          child: Container(
            height: 32.h,
            width: 32.w,
            decoration: BoxDecoration(
              color: const Color(0xff4C8613).withOpacity(.13)
                  ,borderRadius: BorderRadius.circular(10.r)
            ),
            child: Center(
              child:   Icon(Icons.arrow_back_ios_outlined,color: Theme.of(context).primaryColor,size: 18,)
            ),
          ),
          ),


        ],
      ),
    );
  }
}
