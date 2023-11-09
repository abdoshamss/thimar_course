part of'bloc.dart';

class FAQSStates {}

class FAQSLoadingState extends FAQSStates {}

class FAQSSuccessState extends FAQSStates {
  List<FAQSModel> list;

  FAQSSuccessState({required this.list});
}

class FAQSErrorState extends FAQSStates {}