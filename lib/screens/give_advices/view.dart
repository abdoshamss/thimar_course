import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/design/widgets/icon_with_bg.dart';
import 'package:thimar_course/core/design/widgets/input.dart';
import 'package:thimar_course/screens/give_advices/cubit.dart';
import 'package:thimar_course/screens/give_advices/states.dart';

class GiveAdvicesScreen extends StatelessWidget {
  const GiveAdvicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => GiveAdviceCubit(),
      child: Builder(builder: (context) {
        GiveAdviceCubit cubit = BlocProvider.of(context);

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
                padding:   EdgeInsetsDirectional.only(start: 16.w),
                child: IconWithBg(
                  icon: Icons.arrow_forward_ios_outlined,
                  color: Theme.of(context).primaryColor,
                  onPress: () {},
                ),
              ),
            ),
            body: ListView(
              padding:   EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 40.h,
              ),
              children: [
                Input(
                  labelText: "الاسم",
                  controller: cubit.nameController,
                ),
                Input(
                  controller: cubit.phoneController,
                  labelText: "رقم الموبايل",
                  inputType: InputType.phone,
                ),
                Input(
                  controller: cubit.titleController,
                  labelText: "عنوان الموضوع",
                ),
                Input(
                  controller: cubit.contentController,
                  labelText: "الموضوع",
                  maxLines: 4,
                ),
                BlocBuilder(
                    bloc: cubit,
                    builder: (context, state) {
                  if (state is GiveAdviceLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  }
                  return Btn(
                    onPress: () {
                      cubit.sendData( );
                    },
                    text: "الارسال",
                  );
                }),
              ],
            ));
      }),
    );
  }
}
