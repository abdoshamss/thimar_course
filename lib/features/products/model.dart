part of 'bloc.dart';

class ProductsData {
  late final List<ProductItemModel> list;

  late final int userCartCount;
  late final double maxPrice;
  late final double minPrice;

  ProductsData.fromJson(Map<String, dynamic> json) {
    list = List.from(json['data'] ?? [])
        .map((e) => ProductItemModel.fromJson(e))
        .toList();

    userCartCount = json['user_cart_count'] ?? 0;
    maxPrice = double.parse(json['max_price'].toString()) ?? 0.0;
    minPrice = double.parse(json['min_price'].toString()) ?? 0.0;
  }
}

class ProductItemModel {
  late final int categoryId;
  late final int id;
  late final String title;
  late final String description;
  late final String code;
  late final double priceBeforeDiscount;
  late final double price;
  late final double discount;
  late final double amount;
  late final bool isActive;
  late final bool isFavorite;
  late final Unit unit;
  late final List<Images> images;
  late final String mainImage;
  late final String createdAt;

  ProductItemModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'] ?? 0;
    id = json['id'] ?? 0;
    title = json['title'] ?? "";
    description = json['description'] ?? "";
    code = json['code'] ?? "";
    priceBeforeDiscount =double.parse( json['price_before_discount'] .toString())?? 0;
    price = double.parse(json['price'].toString()) ?? 0;
    discount = double.parse(json['discount'].toString()) ?? 0.0;
    amount = double.parse(json['amount'].toString()) ?? 0;
    isActive = json['is_active'] == 1;
    isFavorite = json['is_favorite'] ?? false;
    unit = Unit.fromJson(json['unit']);
    images =
        List.from(json['images'] ?? []).map((e) => Images.fromJson(e)).toList();
    mainImage = json['main_image'] ?? "";
    createdAt = json['created_at'] ?? "";
  }
}

class Unit {
  late final int id;
  late final String name;
  late final String type;
  late final String createdAt;
  late final String updatedAt;

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    type = json['type'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
  }
}

class Images {
  late final String name;
  late final String url;

  Images.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    url = json['url'] ?? "";
  }
}
