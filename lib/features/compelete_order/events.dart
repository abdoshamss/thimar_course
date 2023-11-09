part of'bloc.dart';

class CompleteOrderEvents {}

class PostCompleteOrderDataEvent extends CompleteOrderEvents {
  final TimeOfDay time;
  final DateTime date;
final int? addressId;
final String? coupon;
  PostCompleteOrderDataEvent({required this.time,required this.coupon,required this.addressId,required this.date});
}