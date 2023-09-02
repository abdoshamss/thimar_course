import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_course/screens/about_app/cubit.dart';
import 'package:thimar_course/screens/about_app/states.dart';

import '../../core/design/widgets/icon_with_bg.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AboutAppCubit(),
      child: Builder(builder: (context) {
        AboutAppCubit cubit = BlocProvider.of(context);
        cubit.getAboutData();
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
                  width: 160.w,
                  height: 160.h ,
                )),
                BlocBuilder<AboutAppCubit, AboutAppStates>(
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
                  }else if(state is GetAboutDetailsErrorState){
                    return const Center(child: Text("Failed"),);
                  }
                  return Html(
                    data: cubit.data,
                  );
                }),
              ],
            ),
          ),
        );
      }
      ),
    );
  }
}
