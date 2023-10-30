part of'bloc.dart';

class MyOrdersDetailsEvents {}

class GetMyOrdersDetailsDataEvent extends MyOrdersDetailsEvents {
  final int id;

  GetMyOrdersDetailsDataEvent({required this.id});
}