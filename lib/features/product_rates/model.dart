part of 'bloc.dart';

class ProductRatesData {
  late final List<Data> data;
  late final Links links;
  late final Meta meta;
  late final String status;
  late final String message;

  ProductRatesData.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    links = Links.fromJson(json['links']);
    meta = Meta.fromJson(json['meta']);
    status = json['status'] ?? "";
    message = json['message'] ?? "";
  }
}

class Data {
  late final double value;
  late final String comment;
  late final String clientName;
  late final String clientImage;

  Data.fromJson(Map<String, dynamic> json) {
    value = double.tryParse(json['value'].toString()) ?? 0;
    comment = json['comment'] ?? "";
    clientName = json['client_name'] ?? "";
    clientImage = json['client_image'] ?? "";
  }
}

class Links {
  late final String first;
  late final String last;
  late final String next;

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'] ?? "";
    last = json['last'] ?? "";

    next = json['next'] ?? "";
  }
}

class Meta {
  late final int currentPage;
  late final int from;
  late final int lastPage;
  late final List<Links> links;
  late final String path;
  late final int perPage;
  late final int to;
  late final int total;

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'] ?? 0;
    from = json['from'] ?? 0;
    lastPage = json['last_page'] ?? 0;
    links = List.from(json['links']).map((e) => Links.fromJson(e)).toList();
    path = json['path'] ?? "";
    perPage = json['per_page'] ?? 0;
    to = json['to'] ?? 0;
    total = json['total'] ?? 0;
  }
}
