part of 'bloc.dart';

class CartData {
  late final List<CartModel> list;
  late final double totalPriceBeforeDiscount;
  late final double totalDiscount;
  late final double totalPriceWithVat;
  late final double deliveryCost;
  late final double freeDeliveryPrice;
  late final double vat;
  late final bool isVip;
  late final double vipDiscountPercentage;
  late final double minVipPrice;
  late final String vipMessage;

  CartData.fromJson(Map<String, dynamic> json) {
    list = List.from(json['data'] ?? []).map((e) => CartModel.fromJson(e)).toList();
    totalPriceBeforeDiscount = double.parse(json['total_price_before_discount'].toString());
    totalDiscount = double.parse(json['total_discount'].toString());
    totalPriceWithVat = double.parse(json['total_price_with_vat'].toString());
    deliveryCost = double.parse(json['delivery_cost'].toString());
    freeDeliveryPrice = double.parse(json['free_delivery_price'].toString());
    vat = double.parse(json['vat'].toString());
    isVip = json['is_vip'] == 1;
    vipDiscountPercentage = double.parse(json['vip_discount_percentage'].toString());
    minVipPrice = double.parse(json['min_vip_price'].toString());
    vipMessage = json['vip_message'] ?? "";
  }
}

class CartModel {
  late final int id;
  late final String title;
  late final String image;
  late double amount;
  late final double priceBeforeDiscount;
  late final double discount;
  late final double price;
  late final double remainingAmount;

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    title = json['title'] ?? "";
    image = json['image'] ?? "";
    amount = double.parse(json['amount'].toString());
    priceBeforeDiscount =
        double.parse(json['price_before_discount'].toString());
    discount = double.parse(json['discount'].toString());
    price = double.parse(json['price'].toString());
    remainingAmount = double.parse(json['remaining_amount'].toString());
  }
}
