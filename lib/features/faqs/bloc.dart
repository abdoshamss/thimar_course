import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logic/dio_helper.dart';

part 'states.dart';
part 'model.dart';
part 'events.dart';
class FAQSBloc extends Bloc<FAQSEvents,FAQSStates> {
  final DioHelper dioHelper;
  FAQSBloc(this.dioHelper) : super(FAQSStates()){
    on<GetFAQSDataEvent>(_getData);
  }
Future<void> _getData(FAQSEvents events,Emitter<FAQSStates> emitter)async{
  emit(FAQSLoadingState());
  final response =await dioHelper.get("faqs");
 final list=FAQSData.fromJson(response.response!.data).data;
  if (response.isSuccess){
  emit(  FAQSSuccessState(list: list));
  }
}
}