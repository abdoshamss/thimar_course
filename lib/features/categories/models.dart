part of'bloc.dart';

class CategoriesModels {

  late final List<CategoryData> data;
  // late final Links links;
  // late final Meta meta;
  // late final String status;
  // late final String message;

  CategoriesModels.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>CategoryData.fromJson(e)).toList()??[];
    // links = Links.fromJson(json['links']);
    // meta = Meta.fromJson(json['meta']);
    // status = json['status'];
    // message = json['message'];
  }


}

class CategoryData {

  late final int id;
  late final String name;
  late final String description;
  late final String media;

  CategoryData.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    name = json['name']??"";
    description = json['description']??"";
    media = json['media']??"";
  }


}

// class Links {
//
//   late final String first;
//   late final String last;
//   late final Null prev;
//   late final Null next;
//
//   Links.fromJson(Map<String, dynamic> json){
//     first = json['first'];
//     last = json['last'];
//     prev = null;
//     next = null;
//   }
//
// }
//
// class Meta {
//
//   late final int currentPage;
//   late final int from;
//   late final int lastPage;
//   late final List<Links> links;
//   late final String path;
//   late final int perPage;
//   late final int to;
//   late final int total;
//
//   Meta.fromJson(Map<String, dynamic> json){
//     currentPage = json['current_page'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     links = List.from(json['links']).map((e)=>Links.fromJson(e)).toList();
//     path = json['path'];
//     perPage = json['per_page'];
//     to = json['to'];
//     total = json['total'];
//   }
//
//
