import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/generated/locale_keys.g.dart';

import '../core/widgets/custom_appbar.dart';
import '../features/terms/bloc.dart';
import '../gen/assets.gen.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  final bloc = KiwiContainer().resolve<TermsBloc>()..add(GetTermsDataEvent());
  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: LocaleKeys.my_account_terms.tr(),
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
                  if (state is TermsDataLoadingState) {
                    return Padding(
                      padding: EdgeInsets.only(top: 32.r),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  } else if (state is TermsDataErrorState) {
                    return const Center(
                      child: Text("Failed"),
                    );
                  } else if (state is TermsDataSuccessState) {
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
