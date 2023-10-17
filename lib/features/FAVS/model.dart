part of 'bloc.dart';

class FAVSData {
  late final List<FAVSModel> data;
  late final String status;
  late final String message;

  FAVSData.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => FAVSModel.fromJson(e)).toList();
    status = json['status'] ?? "";
    message = json['message'] ?? "";
  }
}

class FAVSModel {
  late final int categoryId;
  late final int id;
  late final String title;
  late final String description;
  late final String code;
  late final int priceBeforeDiscount;
  late final int price;
  late final double discount;
  late final double amount;
  late final int isActive;
  late final bool isFavorite;
  late final Unit unit;
  // late final List<Images> images;
  late final String mainImage;
  late final String createdAt;

  FAVSModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'] ?? 0;
    id = json['id'] ?? 0;
    title = json['title'] ?? "";
    description = json['description'] ?? "";
    code = json['code'] ?? "";
    priceBeforeDiscount = json['price_before_discount'] ?? 0;
    price = int.tryParse(json['price'].toString()) ?? 0;
    discount = json['discount'] ?? 0.0;
    amount = double.parse(json['amount'] .toString())?? 0;
    isActive = json['is_active'] ?? 0;
    isFavorite = json['is_favorite'] ?? false;
    // unit = Unit.fromJson(json['unit']);
    // images = List.from(json['images']).map((e)=>Images.fromJson(e)).toList();
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
//
// class Images {
//   Images({
//     required this.name,
//     required this.url,
//   });
//   late final String name;
//   late final String url;
//
//   Images.fromJson(Map<String, dynamic> json){
//     name = json['name'];
//     url = json['url'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['name'] = name;
//     _data['url'] = url;
//     return _data;
//   }
// }
