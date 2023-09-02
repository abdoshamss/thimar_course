import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:thimar_course/screens/privacy/cubit.dart';
import 'package:thimar_course/screens/privacy/states.dart';

import '../../core/design/widgets/icon_with_bg.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PrivacyCubit(),
      child: Builder(builder: (context) {
        PrivacyCubit cubit = BlocProvider.of(context);
        cubit.getPrivacyData();
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
                onPress: () {},
              ),
            ),
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder(
                  bloc: cubit,
                  builder: (BuildContext context, state) {
                    if (state is PrivacyLoadingState) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ));
                    }
                    return Html(data: cubit.data);
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
