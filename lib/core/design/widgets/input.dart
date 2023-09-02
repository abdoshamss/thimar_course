import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum InputType { phone, password, email, normal, search }

class Input extends StatefulWidget {
  final String? labelText;
  final String? hintText;
final VoidCallback? onTap;
  final String? iconPath;
final bool isEnabled;
  final InputType inputType;
  final int minLines;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final int maxLength;
  const Input({
    Key? key,
    this.labelText,
    this.hintText,
    this.iconPath,
    this.inputType = InputType.normal,
    this.textInputAction = TextInputAction.next,
    this.maxLength = 22,
    this.minLines = 1,
    this.controller,  this.isEnabled=true,   this.onTap,
  }) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool isPasswordShown = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: widget.onTap,
        child: TextFormField(
          enabled: widget.onTap==null ,
          controller: widget.controller,
          maxLines: 6,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 15.sp,
              color: widget.inputType == InputType.search
                  ? Theme.of(context).primaryColor
                  : Colors.black,
            ),
            suffixIcon: widget.inputType == InputType.password
                ? GestureDetector(
                    onTap: () {
                      isPasswordShown = !isPasswordShown;
                      setState(() {});
                    },
                    child: Icon(
                      isPasswordShown ? Icons.visibility_off : Icons.visibility,
                    ),
                  )
                : null,
            prefixIcon: widget.iconPath != null
                ? Image.asset(
                    widget.iconPath!,color: Theme.of(context).primaryColor,
                    width: 12.w,
                    height: 12.h,
                    fit: BoxFit.scaleDown,
                  )
                : null,
            filled: true,
            fillColor: widget.inputType == InputType.search
                ? Theme.of(context).primaryColor.withOpacity(.03)
                : Colors.white,
            icon: widget.inputType == InputType.phone
                ? Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    // width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                        color: Theme.of(context).unselectedWidgetColor,
                      ),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/saudi.jpg',
                          width: 32.w,
                          height: 20.h,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          '+966',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ))
                : null,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: widget.inputType == InputType.search
                    ? BorderSide.none
                    : BorderSide(
                        color: Theme.of(context).unselectedWidgetColor,
                      )),
            // disabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(15.r),
            //   borderSide: widget.inputType == InputType.search
            //       ? BorderSide.none
            //       : BorderSide(
            //           color: Theme.of(context).unselectedWidgetColor,
            //         ),
            // ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: widget.inputType == InputType.search
                  ? BorderSide.none
                  : BorderSide(
                      color: Theme.of(context).unselectedWidgetColor,
                    ),
            ),
          ),
          obscureText: widget.inputType == InputType.password && isPasswordShown,
        ),
      ),
    );
  }
}
