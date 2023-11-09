part of 'bloc.dart';

class MyFinishedOrdersData {
  late final List<MyFinishedOrdersModel> list;

  MyFinishedOrdersData.fromJson(Map<String, dynamic> json) {
    list = List.from(json['data'] ?? [])
        .map((e) => MyFinishedOrdersModel.fromJson(e))
        .toList();
  }
}

class MyFinishedOrdersModel {
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

  MyFinishedOrdersModel.fromJson(Map<String, dynamic> json) {
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
        double.parse(json['vip_discount_percentage'].toString());
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
