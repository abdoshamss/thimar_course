part of 'bloc.dart';

class FAVSData {
  late final List<FAVSModel> list;


  FAVSData.fromJson(Map<String, dynamic> json) {
    list = List.from(json['data']??[]).map((e) => FAVSModel.fromJson(e)).toList();

  }
}

class FAVSModel {
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
  late final String mainImage;
  late final String createdAt;

  FAVSModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'] ?? 0;
    id = json['id'] ?? 0;
    title = json['title'] ?? "";
    description = json['description'] ?? "";
    code = json['code'] ?? "";
    priceBeforeDiscount = double.parse(json['price_before_discount'].toString()) ;
    price = double.parse(json['price'].toString()) ;
    discount = double.parse(json['discount'].toString()) ?? 0.0;
    amount = double.parse(json['amount'] .toString());
    isActive = json['is_active'] ==1;
    isFavorite = json['is_favorite'] ?? false;
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

  Unit.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    name = json['name']??"";
    type = json['type']??"";
    createdAt = json['created_at']??"";
    updatedAt = json['updated_at']??"";
  }


}
