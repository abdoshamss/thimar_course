part of 'bloc.dart';

class CartData {
  late final List<Data> data;
  late final int totalPriceBeforeDiscount;
  late final double totalDiscount;
  late final double totalPriceWithVat;
  late final int deliveryCost;
  late final int freeDeliveryPrice;
  late final double vat;
  late final int isVip;
  late final int vipDiscountPercentage;
  late final int minVipPrice;
  late final String vipMessage;
  late final String status;
  late final String message;

  CartData.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    totalPriceBeforeDiscount = json['total_price_before_discount'];
    totalDiscount =double.parse( json['total_discount'].toString());
    totalPriceWithVat = double.parse(json['total_price_with_vat'].toString());
    deliveryCost = json['delivery_cost'];
    freeDeliveryPrice = json['free_delivery_price'];
    vat = json['vat'];
    isVip = json['is_vip'];
    vipDiscountPercentage = json['vip_discount_percentage'];
    minVipPrice = json['min_vip_price'];
    vipMessage = json['vip_message'];
    status = json['status'];
    message = json['message'];
  }
}

class Data {
  late final int id;
  late final String title;
  late final String image;
  late  int amount;
  late final int priceBeforeDiscount;
  late final int discount;
  late final double price;
  late final double remainingAmount;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    amount = json['amount'];
    priceBeforeDiscount = json['price_before_discount'];
    discount = json['discount'];
    price = double.parse(json['price'].toString());
    remainingAmount = json['remaining_amount'];
  }
}
