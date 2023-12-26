part of'bloc.dart';

class NotificationsStates {}

class NotificationsLoadingState extends NotificationsStates {}

class NotificationsSuccessState extends NotificationsStates {
  final String message;
  List<Notifications> list;
  NotificationsSuccessState( {required this.message,required this.list});
}

class NotificationsErrorState extends NotificationsStates {
  final String? message;

  NotificationsErrorState({required this.message});
}