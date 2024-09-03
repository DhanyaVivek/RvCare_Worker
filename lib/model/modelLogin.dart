class ModelLogin {
  String? status;
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? deviceId;
  String? slug;
  int? regtime;
  String? address;
  String? location;
  int? otp;
  String? token;
  String? message;

  ModelLogin(
      {this.status,
        this.id,
        this.name,
        this.email,
        this.mobile,
        this.deviceId,
        this.slug,
        this.regtime,
        this.address,
        this.location,
        this.otp,
        this.token,
        this.message});

  ModelLogin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    deviceId = json['device_id'];
    slug = json['slug'];
    regtime = json['regtime'];
    address = json['address'];
    location = json['location'];
    otp = json['otp'];
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['device_id'] = this.deviceId;
    data['slug'] = this.slug;
    data['regtime'] = this.regtime;
    data['address'] = this.address;
    data['location'] = this.location;
    data['otp'] = this.otp;
    data['token'] = this.token;
    data['message'] = this.message;
    return data;
  }
}
