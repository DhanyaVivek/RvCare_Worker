class ModelJobhistory {
  String? message;
  List<Services>? services;

  ModelJobhistory({this.message, this.services});

  ModelJobhistory.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int? id;
  String? assign;
  int? userId;
  String? typeWork;
  String? date;
  String? time;
  String? mobile;
  String? location;
  String? address;
  int? status;
  String? name;

  Services(
      {this.id,
        this.assign,
        this.userId,
        this.typeWork,
        this.date,
        this.time,
        this.mobile,
        this.location,
        this.address,
        this.status,
        this.name});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assign = json['assign'];
    userId = json['user_id'];
    typeWork = json['type_work'];
    date = json['date'];
    time = json['time'];
    mobile = json['mobile'];
    location = json['location'];
    address = json['address'];
    status = json['status'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['assign'] = this.assign;
    data['user_id'] = this.userId;
    data['type_work'] = this.typeWork;
    data['date'] = this.date;
    data['time'] = this.time;
    data['mobile'] = this.mobile;
    data['location'] = this.location;
    data['address'] = this.address;
    data['status'] = this.status;
    data['name'] = this.name;
    return data;
  }
}
