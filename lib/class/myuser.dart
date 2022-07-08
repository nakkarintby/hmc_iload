class MyUser {
  int? id;
  String? uid;
  String? userName;
  String? password;
  String? firstName;
  String? lastName;
  String? mobileNo;
  String? deviceID;
  int? status;
  String? createdBy;
  String? createdOn;

  MyUser(
      {this.id,
      this.uid,
      this.userName,
      this.password,
      this.firstName,
      this.lastName,
      this.mobileNo,
      this.deviceID,
      this.status,
      this.createdBy,
      this.createdOn});

  MyUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    userName = json['userName'];
    password = json['password'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobileNo = json['mobileNo'];
    deviceID = json['deviceID'];
    status = json['status'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobileNo'] = this.mobileNo;
    data['deviceID'] = this.deviceID;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    return data;
  }
}
