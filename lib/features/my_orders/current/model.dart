part of 'bloc.dart';

class MyCurrentOrdersData {
  late final List<MyCurrentOrderModel> list;

  MyCurrentOrdersData.fromJson(Map<String, dynamic> json) {
    list = List.from(json['data'] ?? [])
        .map((e) => MyCurrentOrderModel.fromJson(e))
        .toList();
  }
}

class MyCurrentOrderModel {
  late final int id;
  late final String status;
  late final String date;
  late final String time;
  late final double? orderPrice;
  late final double deliveryPrice;
  late final double? totalPrice;
  late final String clientName;
  late final String deliveryPayer;
  late final List<Products> products;
  late final String payType;
  late final bool isVip;
  late final double vipDiscountPercentage;

  MyCurrentOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    status = json['status'] ?? "";
    date = json['date'] ?? "";
    time = json['time'] ?? "";
    orderPrice = double.parse(json['order_price'].toString()) ?? 0;
    deliveryPrice = double.parse(json['delivery_price'].toString()) ?? 0;
    totalPrice = double.parse(json['total_price'].toString()) ?? 0;
    clientName = json['client_name'] ?? "";

    deliveryPayer = json['delivery_payer'] ?? "";
    products = List.from(json['products'] ?? [])
        .map((e) => Products.fromJson(e))
        .toList();
    payType = json['pay_type'] ?? "";

    isVip = json['is_vip'] == 1;
    vipDiscountPercentage =
        double.parse(json['vip_discount_percentage'].toString()) ?? 0;
  }
}

class Products {
  late final String name;
  late final String url;

  Products.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    url = json['url'] ?? "";
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
