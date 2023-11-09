part of'bloc.dart';

class CurrentLocationEvents {}

class PostCurrentLocationDataEvent extends CurrentLocationEvents {
  final double lat,lng;

  PostCurrentLocationDataEvent({required this.lat, required this.lng});
}