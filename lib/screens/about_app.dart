import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/gen/assets.gen.dart';

import '../core/design/widgets/icon_with_bg.dart';
import '../features/about_app/bloc.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  @override
    final bloc = KiwiContainer().resolve<AboutAppBloc>()..add(GetAboutDataEvent());
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
            onPress: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
                child: Image.asset(
              Assets.images.logo.path,
              width: 160.w,
              height: 160.h,
            )),
            BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if (state is GetAboutDetailsLoadingState) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  } else if (state is GetAboutDetailsErrorState) {
                    return const Center(
                      child: Text("Failed"),
                    );
                  } else if (state is GetAboutDetailsSuccessState) {
                    return Html(
                      data: bloc.data,
                    );
                  }
                  return const SizedBox.shrink();
                }),
          ],
        ),
      ),
    );
  }
}
