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
    totalPriceBeforeDiscount = double.tryParse(json['total_price_before_discount'].toString())??0;
    totalDiscount = double.tryParse(json['total_discount'].toString())??0;
    totalPriceWithVat = double.tryParse(json['total_price_with_vat'].toString())??0;
    deliveryCost = double.tryParse(json['delivery_cost'].toString())??0;
    freeDeliveryPrice = double.tryParse(json['free_delivery_price'].toString())??0;
    vat = double.tryParse(json['vat'].toString())??0;
    isVip = json['is_vip'] == 1;
    vipDiscountPercentage = double.tryParse(json['vip_discount_percentage'].toString())??0;
    minVipPrice = double.tryParse(json['min_vip_price'].toString())??0;
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
    amount = double.tryParse(json['amount'].toString())??0;
    priceBeforeDiscount =
        double.tryParse(json['price_before_discount'].toString())??0;
    discount = double.tryParse(json['discount'].toString())??0;
    price = double.tryParse(json['price'].toString())??0;
    remainingAmount = double.tryParse(json['remaining_amount'].toString())??0;
  }
}
