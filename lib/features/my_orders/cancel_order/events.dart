part of'bloc.dart';

class CancelOrderEvents {}

class PostCancelOrderDataEvent extends CancelOrderEvents {
  final int id;

  PostCancelOrderDataEvent({required this.id});
}