class CheckUpHeaderClass {
  int? checkUpHeaderID;
  int? truckID;
  String? licensePlateH;
  String? licensePlateT;
  String? truckType;
  String? driverName;
  String? mileage;
  String? checkInTime;
  bool? isDeleted;
  String? createdBy;
  String? createdTime;
  String? modifiedBy;
  String? modifiedTime;

  CheckUpHeaderClass(
      {this.checkUpHeaderID,
      this.truckID,
      this.licensePlateH,
      this.licensePlateT,
      this.truckType,
      this.driverName,
      this.mileage,
      this.checkInTime,
      this.isDeleted,
      this.createdBy,
      this.createdTime,
      this.modifiedBy,
      this.modifiedTime});

  CheckUpHeaderClass.fromJson(Map<String, dynamic> json) {
    checkUpHeaderID = json['checkUpHeaderID'];
    truckID = json['truckID'];
    licensePlateH = json['licensePlateH'];
    licensePlateT = json['licensePlateT'];
    truckType = json['truckType'];
    driverName = json['driverName'];
    mileage = json['mileage'];
    checkInTime = json['checkInTime'];
    isDeleted = json['isDeleted'];
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    modifiedBy = json['modifiedBy'];
    modifiedTime = json['modifiedTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['checkUpHeaderID'] = this.checkUpHeaderID;
    data['truckID'] = this.truckID;
    data['licensePlateH'] = this.licensePlateH;
    data['licensePlateT'] = this.licensePlateT;
    data['truckType'] = this.truckType;
    data['driverName'] = this.driverName;
    data['mileage'] = this.mileage;
    data['checkInTime'] = this.checkInTime;
    data['isDeleted'] = this.isDeleted;
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedTime'] = this.modifiedTime;
    return data;
  }
}
