import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

class PrivacyCubit extends Cubit<PrivacyStates> {
  PrivacyCubit() : super(PrivacyStates());
  var data;

  Future<void> getPrivacyData() async {
    emit(PrivacyLoadingState());
    final response =
        await Dio().get("https://thimar.amr.aait-d.com/api/policy");

    data = response.data["data"]["policy"];
    emit(PrivacySuccessState());
  }
}
