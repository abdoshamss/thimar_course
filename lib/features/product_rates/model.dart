part of 'bloc.dart';

class ProductRatesData {
  late final List<ProductRatesModel> list;

  ProductRatesData.fromJson(Map<String, dynamic> json) {
    list = List.from(json['data'] ?? [])
        .map((e) => ProductRatesModel.fromJson(e))
        .toList();
  }
}

class ProductRatesModel {
  late final double value;
  late final String comment;
  late final String clientName;
  late final String clientImage;

  ProductRatesModel.fromJson(Map<String, dynamic> json) {
    value = double.tryParse(json['value'].toString()) ?? 0;
    comment = json['comment'] ?? "";
    clientName = json['client_name'] ?? "";
    clientImage = json['client_image'] ?? "";
  }
}
