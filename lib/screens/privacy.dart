import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/features/privacy/bloc.dart';





import '../core/design/widgets/icon_with_bg.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  final bloc = KiwiContainer().resolve<PrivacyBloc>()..add(GetPrivacyDataEvent(id: 10));

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.close();

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "سياسة الخصوصية",
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
            onPress: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding:  const EdgeInsets.all(16.0),
            child: BlocBuilder(
              bloc: bloc,
              builder: (BuildContext context, state) {
                if (state is PrivacyLoadingState ||bloc .data==null) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ));
                }
                return Html(data: bloc.data);
              },
            ),
          ),
        ],
      ),
    );
  }
}
