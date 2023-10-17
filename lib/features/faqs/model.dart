part of 'bloc.dart';
class FAQSData {
  late final List<Data> data;
  late final String status;
  late final String message;

  FAQSData.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    status = json['status'];
    message = json['message'];
  }
}

class Data {
  late final int id;
  late final String question;
  late final String answer;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }
}
