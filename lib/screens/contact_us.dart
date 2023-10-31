import 'package:flutter/material.dart';

import '../core/widgets/custom_appbar.dart';
import '../gen/assets.gen.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBarScreen(text: "تواصل معنا", image: Assets.icons.backHome.path),
      body: SafeArea(
        child: ListView(
          children: const [],
        ),
      ),
    );
  }
}
