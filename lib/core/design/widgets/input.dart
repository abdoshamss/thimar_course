import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String labelText;
  final bool isPhone;
  final String iconPath;
  const Input(
      {Key? key,
      required this.labelText,
      this.isPhone = false,
      required this.iconPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Image.asset(
            iconPath,
            width: 60,
          ),
          filled: true,
          fillColor: Colors.white,
          icon: isPhone
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  // width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Theme.of(context).unselectedWidgetColor,
                    ),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/saudi.jpg',
                        width: 32,
                        height: 20,
                      ),
                      Text(
                        '+966',
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ))
              : null,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Theme.of(context).unselectedWidgetColor,
              )),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).unselectedWidgetColor,
            ),
          ),
        ),
      ),
    );
  }
}
