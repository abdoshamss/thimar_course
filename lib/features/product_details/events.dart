part of'bloc.dart';
class ProductDetailsEvents{}
class GetProductDetailsEvent extends ProductDetailsEvents{

final int id;
final double price;

  GetProductDetailsEvent({required this.id, required this.price});

}
class ProductUpdateEvent extends ProductDetailsEvents{}
