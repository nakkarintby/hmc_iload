class Truck {
  int? truckID;
  String? truckType;
  String? type;
  String? truckPlate;
  int? driverID;
  String? province;
  String? expiredDate;
  bool? isDeleted;
  String? createdBy;
  String? createdTime;
  String? modifiedBy;
  String? modifiedTime;

  Truck(
      {this.truckID,
      this.truckType,
      this.type,
      this.truckPlate,
      this.driverID,
      this.province,
      this.expiredDate,
      this.isDeleted,
      this.createdBy,
      this.createdTime,
      this.modifiedBy,
      this.modifiedTime});

  Truck.fromJson(Map<String, dynamic> json) {
    truckID = json['truckID'];
    truckType = json['truckType'];
    type = json['type'];
    truckPlate = json['truckPlate'];
    driverID = json['driverID'];
    province = json['province'];
    expiredDate = json['expiredDate'];
    isDeleted = json['isDeleted'];
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    modifiedBy = json['modifiedBy'];
    modifiedTime = json['modifiedTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['truckID'] = this.truckID;
    data['truckType'] = this.truckType;
    data['type'] = this.type;
    data['truckPlate'] = this.truckPlate;
    data['driverID'] = this.driverID;
    data['province'] = this.province;
    data['expiredDate'] = this.expiredDate;
    data['isDeleted'] = this.isDeleted;
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedTime'] = this.modifiedTime;
    return data;
  }
}
