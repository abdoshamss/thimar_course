import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/design/widgets/input.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/features/give_advices/bloc.dart';
import 'package:thimar_course/gen/assets.gen.dart';
import 'package:thimar_course/generated/locale_keys.g.dart';

import '../core/widgets/custom_appbar.dart';

class GiveAdvicesScreen extends StatefulWidget {
  const GiveAdvicesScreen({Key? key}) : super(key: key);

  @override
  State<GiveAdvicesScreen> createState() => _GiveAdvicesScreenState();
}

class _GiveAdvicesScreenState extends State<GiveAdvicesScreen> {
    final bloc = KiwiContainer().resolve<GiveAdviceBloc>();
    @override
  void dispose() {
     super.dispose();
    bloc.close();

    }
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: CustomAppBar(
          text: LocaleKeys.my_account_complaints.tr(),  ),
      body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 40.h,
            ),
            children: [
              Input(
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.register_please_enter_full_name.tr();
                  }
                  return null;
                },
                labelText: LocaleKeys.charge_now_name.tr(),
                controller: bloc.nameController,
              ),
              Input(
                validator: (value) {
                  if (value!.isEmpty  ) {
                    return LocaleKeys.log_in_please_enter_your_mobile_number.tr();
                  }else if(value.length < 9){
                    return LocaleKeys.log_in_please_enter_nine_number.tr();
                  }
                  return null;
                },
                controller: bloc.phoneController,
                labelText: LocaleKeys.log_in_phone_number.tr(),
                inputType: InputType.phone,saudiIcon: false,
              ),
              Input(
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.give_advice_please_enter_content_title.tr();
                  }
                  return null;
                },
                controller: bloc.titleController,
                labelText:  LocaleKeys.give_advice_content_title.tr(),
              ),
              Input(
                validator: (value) {
                  if (value!.isEmpty) {
                    return  LocaleKeys.contact_us_please_enter_content.tr();
                  }
                  return null;
                },
                controller: bloc.contentController,
                labelText:  LocaleKeys.contact_us_subject.tr(),
                maxLines: 4,
              ),
              BlocBuilder(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is GiveAdviceLoadingState) {
                     return loadingWidget();
                    }
                    return AppButton(
                      onPress: () {
                        if (formKey.currentState!.validate()) {
                          bloc.add(PostGiveAdviceDataEvent());
                        }
                      },
                      text: LocaleKeys.contact_us_send.tr(),
                    );
                  }),
            ],
          )),
    );
  }
}
