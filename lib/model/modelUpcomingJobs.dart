class ModelUpcomingJobs {
  List<Upcomingservices>? upcomingservices;

  ModelUpcomingJobs({this.upcomingservices});

  ModelUpcomingJobs.fromJson(Map<String, dynamic> json) {
    if (json['upcomingservices'] != null) {
      upcomingservices = <Upcomingservices>[];
      json['upcomingservices'].forEach((v) {
        upcomingservices!.add(new Upcomingservices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.upcomingservices != null) {
      data['upcomingservices'] =
          this.upcomingservices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Upcomingservices {
  int? id;
  String? name;
  String? address;
  String? location;
  String? typeWork;
  String? date;
  String? time;
  String? description;

  Upcomingservices(
      {this.id,
        this.name,
        this.address,
        this.location,
        this.typeWork,
        this.date,
        this.time,
        this.description});

  Upcomingservices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    location = json['location'];
    typeWork = json['type_work'];
    date = json['date'];
    time = json['time'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['location'] = this.location;
    data['type_work'] = this.typeWork;
    data['date'] = this.date;
    data['time'] = this.time;
    data['description'] = this.description;
    return data;
  }
}
