part of'bloc.dart';
class ProductDetailsEvents{}
class GetProductDetailsEvent extends ProductDetailsEvents{

final int id;


  GetProductDetailsEvent({required this.id });

}
class ProductUpdateEvent extends ProductDetailsEvents{
  final int amount,id;

  ProductUpdateEvent({required this.amount,required this.id});
}
