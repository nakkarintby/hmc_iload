class CheckRegister {
  String? status;
  String? message;
  Result? result;

  CheckRegister({this.status, this.message, this.result});

  CheckRegister.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  int? id;
  String? idCard;
  String? firstName;
  String? lastName;
  String? mobileNo;
  String? pin;
  String? token;
  String? createdBy;
  String? createdOn;
  String? modifiedBy;
  String? modifiedOn;

  Result(
      {this.id,
      this.idCard,
      this.firstName,
      this.lastName,
      this.mobileNo,
      this.pin,
      this.token,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCard = json['idCard'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobileNo = json['mobileNo'];
    pin = json['pin'];
    token = json['token'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    modifiedBy = json['modifiedBy'];
    modifiedOn = json['modifiedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idCard'] = this.idCard;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobileNo'] = this.mobileNo;
    data['pin'] = this.pin;
    data['token'] = this.token;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedOn'] = this.modifiedOn;
    return data;
  }
}
