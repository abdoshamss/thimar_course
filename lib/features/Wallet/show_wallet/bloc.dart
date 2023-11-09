import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';

part 'states.dart';
part 'model.dart';

part 'events.dart';

class WalletBloc extends Bloc<WalletDataEvents, GetWalletDataStates> {
  final DioHelper dioHelper;

  WalletBloc(this.dioHelper) : super(GetWalletDataStates()) {
    on<GetWalletDataEvent>(_getWalletData);
  }

  Future<void> _getWalletData(
      GetWalletDataEvent event, Emitter<GetWalletDataStates> emit) async {
    emit(GetWalletDataLoadingState());
    final response = await dioHelper.get("wallet");
    if (response.isSuccess) {
      final list =WalletData.fromJson(response.response!.data);
      emit(GetWalletDataSuccessState(list: list));
    } else {
      emit(GetWalletDataErrorState());
    }
  }
}
