import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/core/widgets/custom_appbar.dart';
import 'package:thimar_course/gen/assets.gen.dart';

import '../features/about_app/bloc.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  @override
  final bloc = KiwiContainer().resolve<AboutAppBloc>()
    ..add(GetAboutDataEvent());
  @override
  void dispose() {
     super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarScreen(
        image: Assets.icons.backHome.path,
        text: "عن التطبيق",
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
                  return loadingWidget();
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
