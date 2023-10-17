import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_course/gen/assets.gen.dart';

enum InputType { phone, password, email, normal, search }

class Input extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final VoidCallback? enable;
  final GestureTapCallback? onTap;
  final GestureTapCallback? filterIconTap;
  final VoidCallback? onEditingComplete;
  final  ValueChanged<String>? onChanged;
  final TapRegionCallback? onTapOutside;
  final String? iconPath;
  final bool isEnabled;
  final FormFieldValidator<String> validator;
  final InputType inputType;
  final int maxLines;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final int? maxLength;
  final bool saudiIcon;
  final bool filterIcon;

  const Input({
    Key? key,
    this.labelText,
    this.hintText,
    this.iconPath,
    this.inputType = InputType.normal,
    this.textInputAction = TextInputAction.next,
    this.maxLength,
    this.maxLines = 1,
    this.controller,
    this.isEnabled = true,
    this.enable,
    this.onChanged,
    this.onTap,
    this.filterIconTap,
    this.onEditingComplete,
    this.onTapOutside,
    required this.validator,
    this.saudiIcon = true,
    this.filterIcon = false,
  }) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool isPasswordShown = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.r),
      child: GestureDetector(
        onTap: widget.enable,
        child: TextFormField(
onChanged: widget.onChanged,

          onTapOutside: widget.onTapOutside,
          onTap: widget.onTap,
          onEditingComplete:widget.onEditingComplete ,

          validator: widget.validator,
          keyboardType: widget.inputType == InputType.phone
              ? TextInputType.phone
              : TextInputType.text,
          enabled: widget.enable == null,
          controller: widget.controller,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputType == InputType.phone
              ? [FilteringTextInputFormatter.allow(RegExp("[0-9]+"))]
              : [],
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
            suffixIcon:
                widget.filterIcon || widget.inputType == InputType.password
                    ? GestureDetector(
                        onTap: () {
                          isPasswordShown = !isPasswordShown;
                          setState(() {});
                        },
                        child: widget.filterIcon
                            ? GestureDetector(
                                onTap:widget.filterIconTap,
                                child: Image.asset(Assets.icons.filter.path))
                            : Icon(
                                isPasswordShown
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                      )
                    : null,
            prefixIcon: widget.iconPath != null
                ? Padding(
                    padding: EdgeInsets.all(12.r),
                    child: Image.asset(
                      widget.iconPath!,
                      width: 20.w,
                      height: 20.h,
                      fit: BoxFit.scaleDown,
                    ),
                  )
                : null,
            filled: true,
            fillColor: widget.inputType == InputType.search
                ? Theme.of(context).primaryColor.withOpacity(.03)
                : Colors.white,
            icon: widget.saudiIcon && widget.inputType == InputType.phone
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
                          Assets.images.saudi.path,
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
            // enabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(15.r),
            //   borderSide: widget.inputType == InputType.search
            //       ? BorderSide.none
            //       : BorderSide(
            //           color: Theme.of(context).unselectedWidgetColor,
            //         ),
            // ),
          ),
          obscureText:
              widget.inputType == InputType.password && isPasswordShown,
        ),
      ),
    );
  }
}
