part of 'bloc.dart';

class ProductsDataEvents {}

class GetProductsDataEvent extends ProductsDataEvents {
  final int? id;
  final String? value;
  final String? filter;
  final double? minPrice, maxPrice;
  GetProductsDataEvent({
      this.value,
      this.id,
      this.filter,
      this.minPrice,
      this.maxPrice,
  });
}
