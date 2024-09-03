class ModelGenerateEstimate {
  String? message;
  int? id;
  String? assign;
  int? userId;
  String? typeWork;
  String? date;
  String? time;
  String? description;
  int? status;
  String? name;
  String? mobile;
  String? location;
  String? address;
  String? estimateDate;
  String? serviceOffered;
  String? servicePrice;
  String? material;
  String? materialPrice;
  String? estTime;

  ModelGenerateEstimate(
      {this.message,
        this.id,
        this.assign,
        this.userId,
        this.typeWork,
        this.date,
        this.time,
        this.description,
        this.status,
        this.name,
        this.mobile,
        this.location,
        this.address,
        this.estimateDate,
        this.serviceOffered,
        this.servicePrice,
        this.material,
        this.materialPrice,
        this.estTime});

  ModelGenerateEstimate.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    id = json['id'];
    assign = json['assign'];
    userId = json['user_id'];
    typeWork = json['type_work'];
    date = json['date'];
    time = json['time'];
    description = json['description'];
    status = json['status'];
    name = json['name'];
    mobile = json['mobile'];
    location = json['location'];
    address = json['address'];
    estimateDate = json['estimate_date'];
    serviceOffered = json['service_offered'];
    servicePrice = json['service_price'];
    material = json['material'];
    materialPrice = json['material_price'];
    estTime = json['est_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['id'] = this.id;
    data['assign'] = this.assign;
    data['user_id'] = this.userId;
    data['type_work'] = this.typeWork;
    data['date'] = this.date;
    data['time'] = this.time;
    data['description'] = this.description;
    data['status'] = this.status;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['location'] = this.location;
    data['address'] = this.address;
    data['estimate_date'] = this.estimateDate;
    data['service_offered'] = this.serviceOffered;
    data['service_price'] = this.servicePrice;
    data['material'] = this.material;
    data['material_price'] = this.materialPrice;
    data['est_time'] = this.estTime;
    return data;
  }
}
