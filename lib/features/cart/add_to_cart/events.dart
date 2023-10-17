part of'bloc.dart';
class AddToCartEvents{

}
class PostAddToCartDataEvent extends AddToCartEvents{
  final double amount;
  final int id;

  PostAddToCartDataEvent({required this.id, required this.amount});

}