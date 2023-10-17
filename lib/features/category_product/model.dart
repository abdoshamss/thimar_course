part of"bloc.dart";
class CategoryProductModel {
  late final List<Data> data;
  // late final Links links;
  // late final Meta meta;
  late final String status;
  late final String message;

  CategoryProductModel.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    // links = Links.fromJson(json['links']);
    // meta = Meta.fromJson(json['meta']);
    status = json['status']??"";
    message = json['message']??"";
  }
}

class Data {
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
  late final List<Images> images;
  late final String mainImage;
  late final String createdAt;

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id']??0;
    id = json['id']??0;
    title = json['title']??"";
    description = json['description']??"";
    code = json['code']??"";
    priceBeforeDiscount = json['price_before_discount']??0;
    price = double.parse(json['price'].toString());
    discount = json['discount']??0.0;
    amount = double.parse(json['amount'].toString())??0;
    isActive = json['is_active']??0;
    isFavorite = json['is_favorite']??false;
    unit = Unit.fromJson(json['unit']);
    images = List.from(json['images']).map((e) => Images.fromJson(e)).toList();
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

class Images {
  late final String name;
  late final String url;

  Images.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}

class Links {
  late final String first;
  late final String last;
  late final void prev;
  late final void next;

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = null;
    next = null;
  }
}

class Meta {
  late final int currentPage;
  late final int from;
  late final int lastPage;
  late final List<Links> links;
  late final String path;
  late final int perPage;
  late final int to;
  late final int total;

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    links = List.from(json['links']).map((e) => Links.fromJson(e)).toList();
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
}
