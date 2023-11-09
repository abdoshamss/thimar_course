part of 'bloc.dart';

class AddToCarData {

  late final Data data;

  AddToCarData.fromJson(Map<String, dynamic> json) {

    data = Data.fromJson(json['data']??[]);
  }
}

class Data {
  late final String title;
  late final String image;
  late final double amount;
  late final double deliveryCost;
  late final double price;

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title']??"";
    image = json['image']??"";
    amount = double.parse(json['amount'].toString())??0;
    deliveryCost =double.parse( json['delivery_cost'].toString())??0;
    price = double .parse(json['price'].toString())??0;
  }
}
