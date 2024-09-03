class ModelOtp {
  String? message;
  String? token;
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? deviceId;
  String? slug;
  int? regtime;
  String? address;
  String? location;

  ModelOtp(
      {this.message,
        this.token,
        this.id,
        this.name,
        this.email,
        this.mobile,
        this.deviceId,
        this.slug,
        this.regtime,
        this.address,
        this.location});

  ModelOtp.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    deviceId = json['device_id'];
    slug = json['slug'];
    regtime = json['regtime'];
    address = json['address'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['device_id'] = this.deviceId;
    data['slug'] = this.slug;
    data['regtime'] = this.regtime;
    data['address'] = this.address;
    data['location'] = this.location;
    return data;
  }
}
