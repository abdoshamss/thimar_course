part of 'bloc.dart';

class AddToCarData {
  late final String status;
  late final String message;
  late final Data data;

  AddToCarData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  late final String title;
  late final String image;
  late final double amount;
  late final int deliveryCost;
  late final double price;

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    amount = double.parse(json['amount'].toString());
    deliveryCost = json['delivery_cost'];
    price = double .parse(json['price'].toString());
  }
}
