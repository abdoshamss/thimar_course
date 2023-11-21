part of 'bloc.dart';

class NotificationData {
  late final NotificationModel list;

  NotificationData.fromJson(Map<String, dynamic> json) {
    list = NotificationModel.fromJson(json['data']);
  }
}

class NotificationModel {
  late final int unreadnotificationsCount;
  late final List<Notifications> list;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    unreadnotificationsCount = json['unreadnotifications_count'];
    list = List.from(json['notifications'] ?? [])
        .map((e) => Notifications.fromJson(e))
        .toList();
  }
}

class Notifications {
  late final String id, title, body, notifyType, createdAt, readAt, image;

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    title = json['title']??"";
    body = json['body']??"";
    notifyType = json['notify_type']??"";
    createdAt = json['created_at']??"";
    readAt = json['read_at']??"";
    image = json['image']??"";
  }
}
