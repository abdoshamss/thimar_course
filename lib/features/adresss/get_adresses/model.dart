part of 'bloc.dart';

class GetAddressesData {
  late final List<Data> data;
  late final String status;
  late final String message;

  GetAddressesData.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    status = json['status'] ?? "";
    message = json['message'] ?? "";
  }
}

class Data {
  late final int id;
  late final String type;
  late final double lat;
  late final double lng;
  late final String location;
  late final String description;
  late final bool isDefault;
  late final String phone;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    type = json['type'] ?? "";
    lat = double.tryParse(json['lat'].toString()) ?? 0.0;
    lng = double.tryParse(json['lng'].toString()) ?? 0.0;
    location = json['location'] ?? "";
    description = json['description'] ?? "";
    isDefault = json['is_default'] ?? false;
    phone = json['phone'] ?? 0;
  }
}
