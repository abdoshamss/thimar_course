import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/core/widgets/custom_appbar.dart';
import 'package:thimar_course/features/faqs/bloc.dart';

import '../gen/assets.gen.dart';

class FAQSScreen extends StatefulWidget {
  const FAQSScreen({Key? key}) : super(key: key);

  @override
  State<FAQSScreen> createState() => _FAQSScreenState();
}

class _FAQSScreenState extends State<FAQSScreen> {
    final bloc = KiwiContainer().resolve<FAQSBloc>()..add(GetFAQSDataEvent());
    @override
  void dispose() {

    super.dispose();
    bloc.close();

    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:CustomAppBarScreen(text: "أسئلة متكررة", image: Assets.icons.backHome.path),
      body: BlocBuilder(
        bloc: bloc,
        builder: (BuildContext context, state) {
          if (state is FAQSLoadingState) {
            loadingWidget();
          } else if (state is FAQSSuccessState) {
            return Padding(
              padding: EdgeInsets.all(16.0.r),
              child: ListView.separated(
                itemCount: state.list.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(),
                itemBuilder: (BuildContext context, int index) => ExpansionTile(
                  title: Text(
                    state.list[index].question,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                  children: [
                    Text(
                      state.list[index].answer,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).hintColor),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
