class ModelConfirmPayment {
  String? message;
  int? id;
  String? assign;
  int? userId;
  String? typeWork;
  String? date;
  String? time;
  String? comments;
  String? description;
  int? status;
  String? name;
  String? mobile;
  String? location;
  String? address;
  String? amnt;
  String? paymentDate;
  String? paymentTime;
  String? payementMode;

  ModelConfirmPayment(
      {this.message,
        this.id,
        this.assign,
        this.userId,
        this.typeWork,
        this.date,
        this.time,
        this.comments,
        this.description,
        this.status,
        this.name,
        this.mobile,
        this.location,
        this.address,
        this.amnt,
        this.paymentDate,
        this.paymentTime,
        this.payementMode});

  ModelConfirmPayment.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    id = json['id'];
    assign = json['assign'];
    userId = json['user_id'];
    typeWork = json['type_work'];
    date = json['date'];
    time = json['time'];
    comments = json['comments'];
    description = json['description'];
    status = json['status'];
    name = json['name'];
    mobile = json['mobile'];
    location = json['location'];
    address = json['address'];
    amnt = json['amnt'];
    paymentDate = json['payment_date'];
    paymentTime = json['payment_time'];
    payementMode = json['payement_mode'];
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
    data['comments'] = this.comments;
    data['description'] = this.description;
    data['status'] = this.status;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['location'] = this.location;
    data['address'] = this.address;
    data['amnt'] = this.amnt;
    data['payment_date'] = this.paymentDate;
    data['payment_time'] = this.paymentTime;
    data['payement_mode'] = this.payementMode;
    return data;
  }
}
