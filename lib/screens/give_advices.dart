import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/design/widgets/icon_with_bg.dart';
import 'package:thimar_course/core/design/widgets/input.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/features/give_advices/bloc.dart';

class GiveAdvicesScreen extends StatefulWidget {
  const GiveAdvicesScreen({Key? key}) : super(key: key);

  @override
  State<GiveAdvicesScreen> createState() => _GiveAdvicesScreenState();
}

class _GiveAdvicesScreenState extends State<GiveAdvicesScreen> {
    final bloc = KiwiContainer().resolve<GiveAdviceBloc>();
    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.close();

    }
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "الاقتراحات والشكاوي",
          style: TextStyle(

            color: Theme.of(context).primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leadingWidth: 60,
        leading: Padding(
          padding: EdgeInsetsDirectional.only(start: 16.w),
          child: IconWithBg(
            icon: Icons.arrow_forward_ios_outlined,
            color: Theme.of(context).primaryColor,
            onPress: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
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
                    return 'بالرجاء ادخال اسمك بالكامل';
                  }
                  return null;
                },
                labelText: "الاسم",
                controller: bloc.nameController,
              ),
              Input(
                validator: (value) {
                  if (value!.isEmpty || value.length < 9) {
                    return 'بالرجاء ادخال رقم الجوال';
                  }
                  return null;
                },
                controller: bloc.phoneController,
                labelText: "رقم الجوال",
                inputType: InputType.phone,
              ),
              Input(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'بالرجاء ادخال عنوان للموضوع';
                  }
                  return null;
                },
                controller: bloc.titleController,
                labelText: "عنوان الموضوع",
              ),
              Input(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'بالرجاء ادخال الموضوع';
                  }
                  return null;
                },
                controller: bloc.contentController,
                labelText: "الموضوع",
                maxLines: 4,
              ),
              BlocBuilder(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is GiveAdviceLoadingState) {
                      loadingWidget();
                    }
                    return AppButton(
                      onPress: () {
                        if (formKey.currentState!.validate()) {
                          bloc.add(PostGiveAdviceDataEvent());
                        }
                      },
                      text: "الارسال",
                    );
                  }),
            ],
          )),
    );
  }
}
