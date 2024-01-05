import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_course/core/design/widgets/btn.dart';
import 'package:thimar_course/core/design/widgets/input.dart';
import 'package:thimar_course/core/widgets/custom_appbar.dart';
import 'package:thimar_course/features/charge/bloc.dart';
import 'package:thimar_course/generated/locale_keys.g.dart';

class ChargeNowScreen extends StatefulWidget {
  const ChargeNowScreen({Key? key}) : super(key: key);
  @override
  State<ChargeNowScreen> createState() => _ChargeNowScreenState();
}
class _ChargeNowScreenState extends State<ChargeNowScreen> {
  final bloc = KiwiContainer().resolve<ChargeBloc>();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: LocaleKeys.wallet_charge_now.tr(),
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
                LocaleKeys.charge_now_amount_information.tr(),
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16.h,
              ),
              Input(
                backgroundColor: true,
                controller: bloc.amountController,
                validator: (value) {
                  return null;
                },
                inputType: InputType.normal,
                labelText:LocaleKeys.charge_now_your_amount.tr(),
              ),
              SizedBox(
                height: 48.h,
              ),
              Text(
                LocaleKeys.charge_now_card_information.tr(),
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16.h,
              ),
              Input(
                backgroundColor: true,
                validator: (value) {
                  return null;
                },
                inputType: InputType.normal,
                labelText:LocaleKeys.charge_now_name.tr(),
              ),
              Input(
                backgroundColor: true,
                validator: (value) {
                  return null;
                },
                inputType: InputType.normal,
                labelText: LocaleKeys.charge_now_card_credit_number.tr(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 160.w,
                    child: Input(
                      backgroundColor: true,
                      validator: (value) {
                        return null;
                      },
                      labelText: LocaleKeys.charge_now_expiry_date.tr(),
                    ),
                  ),
                  SizedBox(
                    width: 160.w,
                    child: Input(
                      backgroundColor: true,
                      validator: (value) {
                        return null;
                      },
                      labelText: LocaleKeys.charge_now_serial_number.tr(),
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
        child: AppButton(
            text: LocaleKeys.charge_now_pay.tr(),
            onPress: () {
              bloc.add(PostChargeDataEvent());
            }),
      ),
    );
  }
}
