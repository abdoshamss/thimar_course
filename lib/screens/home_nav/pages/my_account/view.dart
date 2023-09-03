import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("hello".tr()),
            IconButton(
                onPressed: () {

                    String code=context.locale.languageCode=="en"?"ar":"en";
                  context.setLocale(Locale(code));

                },
                icon: Icon(Icons.language))
          ],
        ),
      ),
    );
  }
}
