import 'package:flutter/material.dart';

import '../core/widgets/custom_appbar.dart';
import '../gen/assets.gen.dart';
class AddressesScreen extends StatelessWidget {
const AddressesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: CustomAppBarScreen(
        image: Assets.icons.backHome.path,
        text: "العناوين",
      ),
    );
  }
}

