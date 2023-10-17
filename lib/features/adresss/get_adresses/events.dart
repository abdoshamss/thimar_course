part of 'bloc.dart';

class GetAddressesEvents {}

class GetAddressesDataEvent extends GetAddressesEvents {}

class EditAddressesDataEvent extends GetAddressesEvents {
  final int id;
  final String type;

  EditAddressesDataEvent({required this.id, required this.type});
}

class RemoveAddressesDataEvent extends GetAddressesEvents {
  final int id;
  final int index;
  final String type;

  RemoveAddressesDataEvent( {required this.index,required this.id, required this.type});
}
class AddAddressesDataEvent extends GetAddressesEvents {

  final String type;
  final String phone;
  final String description;

  final double lat;
  final double lng;


  AddAddressesDataEvent({required this.type, required this.phone, required this.description,    required this.lat, required this.lng, });
}
