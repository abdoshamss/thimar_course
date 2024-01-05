import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/core/widgets/custom_appbar.dart';
import 'package:thimar_course/features/privacy/bloc.dart';
import 'package:thimar_course/gen/assets.gen.dart';
import 'package:thimar_course/generated/locale_keys.g.dart';


class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  final bloc = KiwiContainer().resolve<PrivacyBloc>()
    ..add(GetPrivacyDataEvent(id: 10));

  @override
  void dispose() {
     super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          text: LocaleKeys.my_account_policy.tr(), ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: BlocBuilder(
              bloc: bloc,
              builder: (BuildContext context, state) {
                if (state is PrivacyLoadingState || bloc.data == null) {
                  return loadingWidget();
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
