class ModelNotification {
  List<Notificationlist>? notificationlist;

  ModelNotification({this.notificationlist});

  ModelNotification.fromJson(Map<String, dynamic> json) {
    if (json['notificationlist'] != null) {
      notificationlist = <Notificationlist>[];
      json['notificationlist'].forEach((v) {
        notificationlist!.add(new Notificationlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notificationlist != null) {
      data['notificationlist'] =
          this.notificationlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notificationlist {
  int? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  int? estimateId;
  String? title;
  String? body;
  Null? readAt;
  String? createdAt;
  String? updatedAt;

  Notificationlist(
      {this.id,
        this.type,
        this.notifiableType,
        this.notifiableId,
        this.estimateId,
        this.title,
        this.body,
        this.readAt,
        this.createdAt,
        this.updatedAt});

  Notificationlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    notifiableType = json['notifiable_type'];
    notifiableId = json['notifiable_id'];
    estimateId = json['estimate_id'];
    title = json['title'];
    body = json['body'];
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['notifiable_type'] = this.notifiableType;
    data['notifiable_id'] = this.notifiableId;
    data['estimate_id'] = this.estimateId;
    data['title'] = this.title;
    data['body'] = this.body;
    data['read_at'] = this.readAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
