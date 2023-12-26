import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/design/widgets/input.dart';
import 'package:thimar_course/core/widgets/custom_appbar.dart';
import 'package:thimar_course/features/charge/bloc.dart';
import 'package:thimar_course/gen/assets.gen.dart';

class ChargeNowScreen extends StatefulWidget {
  const ChargeNowScreen({Key? key}) : super(key: key);

  @override
  State<ChargeNowScreen> createState() => _ChargeNowScreenState();
}

class _ChargeNowScreenState extends State<ChargeNowScreen> {
  final bloc =KiwiContainer().resolve<ChargeBloc>();
  @override
  void dispose() {
     super.dispose();
    bloc.close();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarScreen(
        text: 'اشحن الان',
        image: Assets.icons.backHome.path,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 64.h,
              ),
              Text(
                "معلومات المبلغ",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16.h,
              ),
              Input(backgroundColor: true,
                controller: bloc.amountController,
                validator: (value) {
                  return null;
                },
                inputType: InputType.normal,
                labelText: "المبلغ الخاص بك",
              ),
              SizedBox(
                height: 48.h,
              ),
              Text(
                "معلومات البطاقة",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16.h,
              ),
              Input(backgroundColor: true,
                validator: (value) {
                  return null;
                },
                inputType: InputType.normal,
                labelText: "الاسم",
              ),
              Input(backgroundColor: true,
                validator: (value) {
                  return null;
                },
                inputType: InputType.normal,
                labelText: "رقم البطاقة الائتمانية",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 160.w,
                    child: Input(backgroundColor: true,
                      validator: (value) {
                        return null;
                      },
                      labelText: "تاريخ الانتهاء",
                    ),
                  ),
                  SizedBox(
                    width: 160.w,
                    child: Input(backgroundColor: true,
                      validator: (value) {
                        return null;
                      },
                      labelText: "الرقم المتسلسل",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: AppButton(text: "دفع", onPress: () {
          bloc.add(PostChargeDataEvent());
        }),
      ),
    );
  }
}
