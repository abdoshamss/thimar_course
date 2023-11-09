part of'bloc.dart';

class GetWalletDataStates {}

class GetWalletDataLoadingState extends GetWalletDataStates {}

class GetWalletDataSuccessState extends GetWalletDataStates {
  WalletData list;
  GetWalletDataSuccessState({required this.list});
}

class GetWalletDataErrorState extends GetWalletDataStates {}