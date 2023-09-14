part of'bloc.dart';

class NotificationsStates {}

class NotificationsLoadingState extends NotificationsStates {}

class NotificationsSuccessState extends NotificationsStates {
  List<Notifications> list;
  NotificationsSuccessState({required this.list});
}

class NotificationsErrorState extends NotificationsStates {}