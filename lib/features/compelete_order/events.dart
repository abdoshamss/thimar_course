part of'bloc.dart';

class CompleteOrderEvents {}

class PostCompleteOrderDataEvent extends CompleteOrderEvents {
  final String? time ,date;
 final int? addressId;
final String? coupon;
  PostCompleteOrderDataEvent({required this.time,required this.coupon,required this.addressId,required this.date});
}