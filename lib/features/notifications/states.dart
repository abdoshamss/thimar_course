part of'bloc.dart';

class NotificationsStates {}

class NotificationsLoadingState extends NotificationsStates {}

class NotificationsSuccessState extends NotificationsStates {
  final String message;
  NotificationData list;
  NotificationsSuccessState( {required this.message,required this.list});
}

class NotificationsErrorState extends NotificationsStates {}