part of 'bloc.dart';

class SearchCategoriesData {

  late final SearchCategoriesModel list;

  SearchCategoriesData.fromJson(Map<String, dynamic> json) {

    list = SearchCategoriesModel.fromJson(json['data']??[]);
  }
}

class SearchCategoriesModel {
  late final List<SearchResult> searchResult;

  SearchCategoriesModel.fromJson(Map<String, dynamic> json) {
    searchResult = List.from(json['search_result']??[])
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
  late final double priceBeforeDiscount;
  late final double price;
  late final double discount;
  late final double amount;
  late final bool isActive;
  late final bool isFavorite;
  late final Unit unit;
  late final List<dynamic> images;
  late final String mainImage;
  late final String createdAt;

  SearchResult.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id']??0;
    id = json['id']??0;
    title = json['title']??"";
    description = json['description']??"";
    code = json['code']??"";
    priceBeforeDiscount = double.parse(json['price_before_discount'].toString())??0;
    price = double.parse(json['price'].toString())??0;
    discount = double.parse(json['discount'].toString())??0;
    amount = double.parse(json['amount'].toString())??0;
    isActive = json['is_active']==1;
    isFavorite = json['is_favorite']??false;
    unit = Unit.fromJson(json['unit']);
    images = List.castFrom<dynamic, dynamic>(json['images']??[]);
    mainImage = json['main_image']??"";
    createdAt = json['created_at']??"";
  }
}

class Unit {
  late final int id;
  late final String name;
  late final String type;
  late final String createdAt;
  late final String updatedAt;

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    name = json['name']??"";
    type = json['type']??"";
    createdAt = json['created_at']??"";
    updatedAt = json['updated_at']??"";
  }
}
