part of 'bloc.dart';
class MyOrdersDetailsData {

  late final String status;
  late final String message;
  late final Data data;

  MyOrdersDetailsData.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }


}

class Data {

  late final int id;
  late final String status;
  late final String date;
  late final String time;
  late final double orderPrice;
  late final double deliveryPrice;
  late final double totalPrice;
  late final String clientName;
  late final String phone;
  late final Address address;
  late final List<Products> products;
  late final String payType;
  late final String note;
  late final String deliveryPayer;
  late final int isVip;
  late final double vipDiscount;
  late final int priceBeforeDiscount;
  late final int discount;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    status = json['status'];
    date = json['date'];
    time = json['time'];
    orderPrice = double.parse(json['order_price'].toString());
    deliveryPrice = double.parse(json['delivery_price'].toString());
    totalPrice = double.parse(json['total_price'].toString());
    clientName = json['client_name'];
    phone = json['phone'];
    address = Address.fromJson(json['address']);
    products = List.from(json['products']).map((e)=>Products.fromJson(e)).toList();
    payType = json['pay_type'];
    note = json['note']??"";
    deliveryPayer = json['delivery_payer'];
    isVip = json['is_vip'];
    vipDiscount = double.parse(json['vip_discount'].toString())??0.0;
    priceBeforeDiscount = json['price_before_discount'];
    discount = json['discount'];
  }


}

class Address {

  late final int id;
  late final String type;
  late final double lat;
  late final double lng;
  late final String location;
  late final String description;
  late final bool isDefault;
  late final String phone;

  Address.fromJson(Map<String, dynamic> json){
    id = json['id'];
    type = json['type'];
    lat = json['lat'];
    lng = json['lng'];
    location = json['location'];
    description = json['description'];
    isDefault = json['is_default'];
    phone = json['phone'];
  }


}

class Products {

  late final String name;
  late final String url;

  Products.fromJson(Map<String, dynamic> json){
    name = json['name'];
    url = json['url'];
  }

}