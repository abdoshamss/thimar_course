part of 'bloc.dart';


class Notifications {
  late final String id, title, body, notifyType, createdAt, readAt, image;

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    title = json['title'] ?? "";
    body = json['body'] ?? "";
    notifyType = json['notify_type'] ?? "";
    createdAt = json['created_at'] ?? "";
    readAt = json['read_at'] ?? "";
    image = json['image'] ?? "";
  }
}
