import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconWithBg extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPress;
  final Color color;
  final double  iconPadding;
  const IconWithBg(
      {Key? key,
      required this.icon,
      required this.onPress,
      required this.color,   this.iconPadding=12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding:   EdgeInsets.all(iconPadding.r),
        decoration: BoxDecoration(
            color: color.withOpacity(.13),
            borderRadius: BorderRadius.circular(9.r)),
        child: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }
}
