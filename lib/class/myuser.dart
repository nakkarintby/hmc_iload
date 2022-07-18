class MyUser {
  int? id;
  String? uid;
  String? idCard;
  String? userName;
  String? password;
  String? firstName;
  String? lastName;
  String? mobileNo;
  String? token;
  String? deviceMAC;
  int? status;
  String? createdBy;
  String? createdOn;
  String? modifiedBy;
  String? modifiedOn;

  MyUser(
      {this.id,
      this.uid,
      this.idCard,
      this.userName,
      this.password,
      this.firstName,
      this.lastName,
      this.mobileNo,
      this.token,
      this.deviceMAC,
      this.status,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn});

  MyUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    idCard = json['idCard'];
    userName = json['userName'];
    password = json['password'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobileNo = json['mobileNo'];
    token = json['token'];
    deviceMAC = json['deviceMAC'];
    status = json['status'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    modifiedBy = json['modifiedBy'];
    modifiedOn = json['modifiedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['idCard'] = this.idCard;
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobileNo'] = this.mobileNo;
    data['token'] = this.token;
    data['deviceMAC'] = this.deviceMAC;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedOn'] = this.modifiedOn;
    return data;
  }
}
