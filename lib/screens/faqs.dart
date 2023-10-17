import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/features/faqs/bloc.dart';

import '../core/design/widgets/icon_with_bg.dart';

class FAQSScreen extends StatefulWidget {
  const FAQSScreen({Key? key}) : super(key: key);

  @override
  State<FAQSScreen> createState() => _FAQSScreenState();
}

class _FAQSScreenState extends State<FAQSScreen> {
    final bloc = KiwiContainer().resolve<FAQSBloc>()..add(GetFAQSDataEvent());
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
          "أسئلة متكررة",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leadingWidth: 60.w,
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
