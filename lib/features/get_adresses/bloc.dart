import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';

import '../../../core/logic/dio_helper.dart';

part 'states.dart';
part 'model.dart';
part 'events.dart';

class GetAddressesBloc extends Bloc<GetAddressesEvents, GetAddressesStates> {
  final DioHelper dioHelper;
  GetAddressesBloc(this.dioHelper) : super(GetAddressesStates()) {
    on<GetAddressesDataEvent>(_getAddresses);
    on<EditAddressesDataEvent>(_editAddresses);
    on<RemoveAddressesDataEvent>(_removeAddresses);
    on<AddAddressesDataEvent>(_addAddresses);
  }
  late int index;
  final noteController = TextEditingController();
  List<AddressModel> addressesList = [];
  String message = "";
  Future<void> _getAddresses(
      GetAddressesEvents event, Emitter<GetAddressesStates> emit) async {
    emit(GetAddressesLoadingState());
    final response = await dioHelper.get("client/addresses");
    if (response.isSuccess) {
      addressesList = GetAddressesData.fromJson(response.response!.data).list;
      emit(GetAddressesSuccessState(list: addressesList));
      message = GetAddressesData.fromJson(response.response!.data).message;
    } else {
      emit(GetAddressesErrorState());
    }
  }

  Future<void> _editAddresses(
      EditAddressesDataEvent event, Emitter<GetAddressesStates> emit) async {
    emit(EditAddressesLoadingState());
    final map = {
      "_method": "PUT",
      "type": event.type,
    };
    final response =
        await dioHelper.post("client/addresses/${event.id}", data: map);
    if (response.isSuccess) {
      emit(EditAddressesSuccessState(message: response.message));
    } else {
      emit(EditAddressesErrorState(
          message: response.message,
          statusCode: response.response!.statusCode ?? 200));
    }
  }

  Future<void> _removeAddresses(
      RemoveAddressesDataEvent event, Emitter<GetAddressesStates> emit) async {
    emit(RemoveAddressesLoadingState());
    final response = await dioHelper.post("client/addresses/${event.id}",
        data: {"type": event.type, "_method": "DELETE"});
    if (response.isSuccess) {
      addressesList.removeAt(event.index);
      emit(RemoveAddressesSuccessState(message: response.message));
    } else {
      emit(RemoveAddressesErrorState(
          message: response.message,
          statusCode: response.response!.statusCode ?? 200));
    }
  }

  Future<void> _addAddresses(
      AddAddressesDataEvent event, Emitter<GetAddressesStates> emit) async {
    emit(AddAddressesLoadingState());

    final map = {
      "type": event.type,
      "phone": event.phone,
      'description': event.description,
      'location':CacheHelper.getCurrentLocationWithName(),
      'lat': event.lat,
      'lng': event.lng,
      'is_default': "1",
    };
    final response = await dioHelper.post("client/addresses", data: map);
    if (response.isSuccess) {
      emit(AddAddressesSuccessState(message: response.message));
    } else {
      emit(AddAddressesErrorState(
          message: response.message,
          statusCode: response.response!.statusCode ?? 200));
    }
  }
}
