class ModelAssinedjobstwolist {
  List<Latestschedules>? latestschedules;

  ModelAssinedjobstwolist({this.latestschedules});

  ModelAssinedjobstwolist.fromJson(Map<String, dynamic> json) {
    if (json['latestschedules'] != null) {
      latestschedules = <Latestschedules>[];
      json['latestschedules'].forEach((v) {
        latestschedules!.add(new Latestschedules.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.latestschedules != null) {
      data['latestschedules'] =
          this.latestschedules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Latestschedules {
  int? id;
  String? name;
  String? mobile;
  String? address;
  String? location;
  String? typeWork;
  String? date;
  String? time;
  String? description;
  String? estimateDate;
  String? estTime;
  String? serviceOffered;
  String? servicePrice;
  String? material;
  String? materialPrice;
  int? status;

  Latestschedules(
      {this.id,
        this.name,
        this.mobile,
        this.address,
        this.location,
        this.typeWork,
        this.date,
        this.time,
        this.description,
        this.estimateDate,
        this.estTime,
        this.serviceOffered,
        this.servicePrice,
        this.material,
        this.materialPrice,
        this.status});

  Latestschedules.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    address = json['address'];
    location = json['location'];
    typeWork = json['type_work'];
    date = json['date'];
    time = json['time'];
    description = json['description'];
    estimateDate = json['estimate_date'];
    estTime = json['est_time'];
    serviceOffered = json['service_offered'];
    servicePrice = json['service_price'];
    material = json['material'];
    materialPrice = json['material_price'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['location'] = this.location;
    data['type_work'] = this.typeWork;
    data['date'] = this.date;
    data['time'] = this.time;
    data['description'] = this.description;
    data['estimate_date'] = this.estimateDate;
    data['est_time'] = this.estTime;
    data['service_offered'] = this.serviceOffered;
    data['service_price'] = this.servicePrice;
    data['material'] = this.material;
    data['material_price'] = this.materialPrice;
    data['status'] = this.status;
    return data;
  }
}
