import 'package:flutter/material.dart';

import '../res/colors.dart';

enum BtnType { elevated, outlined, cancel, reject }

class Btn extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final BtnType type;
  const Btn(
      {Key? key,
      required this.text,
      required this.onPress,
      this.type = BtnType.elevated})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: const Color(0x1361B80C).withOpacity(.19),
              blurRadius: 6,
              offset: const Offset(0, 3),
              blurStyle: BlurStyle.outer),
        ],
      ),
      child: type == BtnType.outlined
          ? OutlinedButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                onPress();
              },
              style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: primaryColor)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                   text,
                ),
              ),
            )
          : ElevatedButton(
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          onPress();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: type==BtnType.cancel?const Color(0xffFFE1E1):null,
            elevation: 0,
             foregroundColor: type==BtnType.cancel?const Color(0xffFF0000):null,
             fixedSize: const Size(343, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
             ),
          ),
        ),
      ),
    );
  }
}
 