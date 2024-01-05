import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/core/widgets/custom_appbar.dart';
import 'package:thimar_course/features/faqs/bloc.dart';
import 'package:thimar_course/generated/locale_keys.g.dart';

import '../gen/assets.gen.dart';

class FAQSScreen extends StatefulWidget {
  const FAQSScreen({Key? key}) : super(key: key);

  @override
  State<FAQSScreen> createState() => _FAQSScreenState();
}

class _FAQSScreenState extends State<FAQSScreen> {
  final _bloc = KiwiContainer().resolve<FAQSBloc>()..add(GetFAQSDataEvent());
  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          text: LocaleKeys.my_account_faqs.tr(),  ),
      body: BlocBuilder(
        bloc: _bloc,
        builder: (BuildContext context, state) {
          if (state is FAQSLoadingState) {
            return loadingWidget();
          } else if (state is FAQSSuccessState) {
            return Padding(
              padding: EdgeInsets.all(16.0.r),
              child: ListView.separated(
                itemCount: state.list.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(),
                itemBuilder: (BuildContext context, int index) => ExpansionTile(
                  collapsedIconColor: Theme.of(context).primaryColor,

                  title: Text(
                    state.list[index].question,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                  // collapsedShape: ,
                  childrenPadding: EdgeInsets.symmetric(horizontal: 8.w),
                  collapsedShape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  shape: Border.all(width: 0.w, color: Colors.transparent),

                  children: [
                    Text(
                      state.list[index].answer,
                      style: TextStyle(
                          fontSize: 13,
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
