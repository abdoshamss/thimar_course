part of 'bloc.dart';

class MyCurrentOrdersData {
  late final List<Data> data;
  // late final Links links;
  // late final Meta meta;
  late final String status;
  late final String message;

  MyCurrentOrdersData.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    // links = Links.fromJson(json['links']);
    // meta = Meta.fromJson(json['meta']);
    status = json['status'];
    message = json['message'];
  }
}

class Data {
  late final int id;
  late final String status;
  late final String date;
  late final String time;
  late final double? orderPrice;
  late final int deliveryPrice;
  late final double? totalPrice;
  late final String clientName;
  late final String? phone;
  late final String? location;
  late final String deliveryPayer;
  late final List<Products> products;
  late final String payType;
  late final String? note;
  late final int isVip;
  late final int vipDiscountPercentage;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    date = json['date'];
    time = json['time'];
    orderPrice = double.parse(json['order_price'].toString());
    deliveryPrice = json['delivery_price'];
    totalPrice = double.parse(json['total_price'].toString());
    clientName = json['client_name'];
    phone = null;
    location = null;
    deliveryPayer = json['delivery_payer'];
    products =
        List.from(json['products']).map((e) => Products.fromJson(e)).toList();
    payType = json['pay_type'];
    note = null;
    isVip = json['is_vip'];
    vipDiscountPercentage = json['vip_discount_percentage'];
  }
}

class Products {
  late final String name;
  late final String url;

  Products.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}

// class Links {
//
//   late final String first;
//   late final String last;
//   late final Null prev;
//   late final Null next;
//
//   Links.fromJson(Map<String, dynamic> json){
//     first = json['first'];
//     last = json['last'];
//     prev = null;
//     next = null;
//   }
//
//
// }
//
// class Meta {
//
//   late final int currentPage;
//   late final int from;
//   late final int lastPage;
//   late final List<Links> links;
//   late final String path;
//   late final int perPage;
//   late final int to;
//   late final int total;
//
//   Meta.fromJson(Map<String, dynamic> json){
//     currentPage = json['current_page'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     links = List.from(json['links']).map((e)=>Links.fromJson(e)).toList();
//     path = json['path'];
//     perPage = json['per_page'];
//     to = json['to'];
//     total = json['total'];
//   }
//
//
// }
