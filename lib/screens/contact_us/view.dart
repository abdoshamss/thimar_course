import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../core/design/widgets/icon_with_bg.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAboutData();
  }

  bool isLoading = true;
  var data;
  Future<void> getAboutData() async {

    final response = await Dio().get("https://thimar.amr.aait-d.com/api/about");
    print(response.data);
    data = response.data["data"]["about"];
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "عن التطبيق",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(start: 16),
          child: IconWithBg(
            icon: Icons.arrow_forward_ios_outlined,
            color: Theme.of(context).primaryColor,
            onPress: () {},
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
                child: Image.asset(
              "assets/images/logo.jpg",
              width: 160,
              height: 160,
            )),
            isLoading
                ?
                 Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Center(

                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                ):Html(data: data,),
          ],
        ),
      ),
    );
  }
}
