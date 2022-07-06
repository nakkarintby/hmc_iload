class User {
  int? id;
  String? idcard;
  String? firstname;
  String? lastname;
  String? mobileno;
  String? beaconno;
  String? starttime;
  String? finishtime;
  int? status;
  String? createdby;
  String? createdon;

  User(
      {this.id,
      this.idcard,
      this.firstname,
      this.lastname,
      this.mobileno,
      this.beaconno,
      this.starttime,
      this.finishtime,
      this.status,
      this.createdby,
      this.createdon});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idcard = json['idcard'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    mobileno = json['mobileno'];
    beaconno = json['beaconno'];
    starttime = json['starttime'];
    finishtime = json['finishtime'];
    status = json['status'];
    createdby = json['createdby'];
    createdon = json['createdon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idcard'] = this.idcard;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['mobileno'] = this.mobileno;
    data['beaconno'] = this.beaconno;
    data['starttime'] = this.starttime;
    data['finishtime'] = this.finishtime;
    data['status'] = this.status;
    data['createdby'] = this.createdby;
    data['createdon'] = this.createdon;
    return data;
  }
}
