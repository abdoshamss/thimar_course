part of'bloc.dart';
class ProductRatesEvents{}
class GetProductRatesEvent extends ProductRatesEvents{}
class PostProductRatesEvent extends ProductRatesEvents{
  final double value;
  final String comment;
  final int id;

  PostProductRatesEvent({required this.value,required this.id, required this.comment});

}