import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/colors.dart';

enum BtnType { elevated, outline, outlineDisabled, cancel, reject }

class Btn extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final BtnType type;
  final bool isBig, isLoading;
  const Btn({
    Key? key,
    required this.text,
    required this.onPress,
    this.type = BtnType.elevated,
    this.isBig = true,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SizedBox(width: 30.w,height: 30.w,
          child: FittedBox(
      fit: BoxFit.scaleDown,
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
        : DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: const Color(0x1361B80C).withOpacity(.19),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                    blurStyle: BlurStyle.outer),
              ],
            ),
            child: type == BtnType.outline || type == BtnType.outlineDisabled
                ? OutlinedButton(
                    onPressed: () {
                      if (type == BtnType.outlineDisabled) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        onPress();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: type != BtnType.outlineDisabled
                          ? null
                          : Theme.of(context).unselectedWidgetColor,
                      side: BorderSide(
                        color: type != BtnType.outlineDisabled
                            ? primaryColor
                            : Theme.of(context).unselectedWidgetColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        text,
                        style: TextStyle(
                          color: type != BtnType.outlineDisabled
                              ? null
                              : Colors.grey,
                        ),
                      ),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      onPress();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: type == BtnType.cancel
                          ? const Color(0xffFFE1E1)
                          : null,
                      elevation: 0,
                      foregroundColor: type == BtnType.cancel
                          ? const Color(0xffFF0000)
                          : null,
                      fixedSize:
                          Size(isBig ? 343.w : 115.w, isBig ? 60.h : 30.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(isBig ? 20 : 4),
                      child: Text(
                        text,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
          );
  }
}
