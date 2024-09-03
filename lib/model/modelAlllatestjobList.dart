class ModelAssinedjobslist {
  List<Alllatestlist>? alllatestlist;

  ModelAssinedjobslist({this.alllatestlist});

  ModelAssinedjobslist.fromJson(Map<String, dynamic> json) {
    if (json['alllatestlist'] != null) {
      alllatestlist = <Alllatestlist>[];
      json['alllatestlist'].forEach((v) {
        alllatestlist!.add(new Alllatestlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.alllatestlist != null) {
      data['alllatestlist'] =
          this.alllatestlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Alllatestlist {
  int? id;
  String? name;
  String? mobile;
  String? address;
  String? location;
  String? typeWork;
  String? date;
  String? time;
  String? timeSection;
  String? description;
  String? estimateDate;
  String? estTime;
  String? serviceOffered;
  String? servicePrice;
  String? material;
  String? materialPrice;
  int? status;

  Alllatestlist(
      {this.id,
        this.name,
        this.mobile,
        this.address,
        this.location,
        this.typeWork,
        this.date,
        this.time,
        this.timeSection,
        this.description,
        this.estimateDate,
        this.estTime,
        this.serviceOffered,
        this.servicePrice,
        this.material,
        this.materialPrice,
        this.status});

  Alllatestlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    address = json['address'];
    location = json['location'];
    typeWork = json['type_work'];
    date = json['date'];
    time = json['time'];
    timeSection = json['time_section'];
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
    data['time_section'] = this.timeSection;
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
