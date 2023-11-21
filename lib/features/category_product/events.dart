part of 'bloc.dart';

class CategoryProductEvents {}

class GetCategoryProductEvent extends CategoryProductEvents {
  final int id;


  GetCategoryProductEvent({
    required this.id,

  });
}
