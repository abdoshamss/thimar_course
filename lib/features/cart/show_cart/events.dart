part of'bloc.dart';

class CartDataEvents {}

class GetCartDataEvent extends CartDataEvents {}
class DeleteFromCartDataEvent extends CartDataEvents {

  final int id,index;

  DeleteFromCartDataEvent( {required this.id,required this.index,});


}
class CartUpdateEvent extends CartDataEvents {
  final int amount ,id;

  CartUpdateEvent({required this.amount, required this.id});
}
class ApplyCouponEvent extends CartDataEvents {}
