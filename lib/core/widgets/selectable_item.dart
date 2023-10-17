




import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectableItem  extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  const SelectableItem (this.text, this.isSelected, this.onTap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
      onTap:onTap,
      child: Container(
        height: 40.h,
        width: 70.w,
        decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).primaryColor
                : null,
            borderRadius:
            BorderRadius.circular(11.r)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color:  isSelected
                  ? Colors.white
                  : Theme.of(context).primaryColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
