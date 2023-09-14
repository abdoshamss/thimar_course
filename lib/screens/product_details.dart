import 'package:flutter/material.dart';
import 'package:thimar_course/core/design/widgets/icon_with_bg.dart';
import 'package:thimar_course/gen/assets.gen.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Image.asset(Assets.icons.favs.path),
      ),
    );
  }
}
