part of'bloc.dart';
class AddToCartEvents{

}
class PostAddToCartDataEvent extends AddToCartEvents{
  final double amount;
  final int id;
  final int? counter;
  PostAddToCartDataEvent( {this.counter,required this.id, required this.amount});

}