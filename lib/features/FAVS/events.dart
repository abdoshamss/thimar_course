part of 'bloc.dart';

class FAVSEvents {}

class GetFAVSDataEvent extends FAVSEvents {}
class PostAddFAVSDataEvent extends FAVSEvents {
  final int id;

  PostAddFAVSDataEvent({required this.id});
}
class PostRemoveFAVSDataEvent extends FAVSEvents {
  final int id,index;

  PostRemoveFAVSDataEvent({required this.id,required this.index});
}
