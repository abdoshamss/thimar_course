import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import '../../core/logic/dio_helper.dart';

part 'states.dart';
part 'model.dart';
part 'events.dart';

class FavsBloc extends Bloc<FAVSEvents, FAVSStates> {
  final DioHelper dioHelper;

  FavsBloc(this.dioHelper) : super(FAVSStates()) {
    on<GetFAVSDataEvent>(_getData);
    on<PostAddFAVSDataEvent>(_addFAVS);
    on<PostRemoveFAVSDataEvent>(_removeFAVS);
  }
  List<FAVSModel> favsData = [];
  Future<void> _getData(
      GetFAVSDataEvent event, Emitter<FAVSStates> emit) async {
    emit(FAVSLoadingState());
    final response = await dioHelper.get("client/products/favorites");
    if (response.isSuccess) {
      final list = FAVSData.fromJson(response.response!.data);
      favsData = FAVSData.fromJson(response.response!.data).list;

      // emit(FAVSSuccessState(list: list, message: response.message));
      emit(FAVSSuccessState(message: response.message));
    } else {
      emit(FAVSErrorState(
        message: response.message,
        statusCode: response.response!.statusCode ?? 200,
      ));
    }
  }

  Future<void> _addFAVS(
      PostAddFAVSDataEvent event, Emitter<FAVSStates> emit) async {
    final response =
        await dioHelper.post("client/products/${event.id}/add_to_favorite");

    emit(AddToFAVSState(message: response.message));
  }

  Future<void> _removeFAVS(
      PostRemoveFAVSDataEvent event, Emitter<FAVSStates> emit) async {
    final response = await dioHelper
        .post("client/products/${event.id}/remove_from_favorite");

    emit(RemoveFromFAVSState(
        message: response.message,
        statusCode: response.response!.statusCode ?? 200));
    print("event.index.toString()" * 8);
    print(event.index);
    favsData.removeAt(event.index);
  }
}
