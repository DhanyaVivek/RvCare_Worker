class ProfileDetails {
  int? id;
  int? userid;
  String? name;
  String? mobile;
  String? landmark;
  String? address;
  int? wpNum;
  String? message;

  ProfileDetails(
      {this.id,
        this.userid,
        this.name,
        this.mobile,
        this.landmark,
        this.address,
        this.wpNum,
        this.message});

  ProfileDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    name = json['name'];
    mobile = json['mobile'];
    landmark = json['landmark'];
    address = json['address'];
    wpNum = json['wp_num'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['landmark'] = this.landmark;
    data['address'] = this.address;
    data['wp_num'] = this.wpNum;
    data['message'] = this.message;
    return data;
  }
}
