part of 'bloc.dart';

class SearchCategoriesData {
  late final String status;
  late final String message;
  late final Data data;

  SearchCategoriesData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  late final List<SearchResult> searchResult;

  Data.fromJson(Map<String, dynamic> json) {
    searchResult = List.from(json['search_result'])
        .map((e) => SearchResult.fromJson(e))
        .toList();
  }
}

class SearchResult {
  late final int categoryId;
  late final int id;
  late final String title;
  late final String description;
  late final String code;
  late final int priceBeforeDiscount;
  late final double price;
  late final double discount;
  late final double amount;
  late final int isActive;
  late final bool isFavorite;
  late final Unit unit;
  late final List<dynamic> images;
  late final String mainImage;
  late final String createdAt;

  SearchResult.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    id = json['id'];
    title = json['title'];
    description = json['description'];
    code = json['code'];
    priceBeforeDiscount = json['price_before_discount'];
    price = double.parse(json['price'].toString());
    discount = json['discount'];
    amount = double.parse(json['amount'].toString());
    isActive = json['is_active'];
    isFavorite = json['is_favorite'];
    unit = Unit.fromJson(json['unit']);
    images = List.castFrom<dynamic, dynamic>(json['images']);
    mainImage = json['main_image'];
    createdAt = json['created_at'];
  }
}

class Unit {
  late final int id;
  late final String name;
  late final String type;
  late final String createdAt;
  late final String updatedAt;

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
