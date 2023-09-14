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
  }

  Future<void> _getData(
      GetFAVSDataEvent event, Emitter<FAVSStates> emit) async {
    emit(FAVSLoadingState());
    final response = await dioHelper.get("client/products/favorites");
    if (response.isSuccess) {
      final list = FAVSData.fromJson(response.response!.data);
      emit(FAVSSuccessState(list: list, message: response.message));
    } else {
      emit(FAVSErrorState(
        message: response.message,
        statusCode: response.response!.statusCode ?? 200,
      ));
    }
  }
}
