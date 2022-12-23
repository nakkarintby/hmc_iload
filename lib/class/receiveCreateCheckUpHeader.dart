class RecieveCreateCheckupHeader {
  int? checkUpHeaderID;
  int? truckID;
  int? trailerID;
  String? truckPlate;
  String? trailerPlate;
  String? truckType;
  String? trailerType;
  int? driverID;
  dynamic mileage;
  String? checkInTime;
  String? result;
  String? status;
  bool? isDeleted;
  String? createdBy;
  String? createdTime;
  String? modifiedBy;
  String? modifiedTime;

  RecieveCreateCheckupHeader(
      {this.checkUpHeaderID,
      this.truckID,
      this.trailerID,
      this.truckPlate,
      this.trailerPlate,
      this.truckType,
      this.trailerType,
      this.driverID,
      this.mileage,
      this.checkInTime,
      this.result,
      this.status,
      this.isDeleted,
      this.createdBy,
      this.createdTime,
      this.modifiedBy,
      this.modifiedTime});

  RecieveCreateCheckupHeader.fromJson(Map<String, dynamic> json) {
    checkUpHeaderID = json['checkUpHeaderID'];
    truckID = json['truckID'];
    trailerID = json['trailerID'];
    truckPlate = json['truckPlate'];
    trailerPlate = json['trailerPlate'];
    truckType = json['truckType'];
    trailerType = json['trailerType'];
    driverID = json['driverID'];
    mileage = json['mileage'];
    checkInTime = json['checkInTime'];
    result = json['result'];
    status = json['status'];
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
    data['trailerID'] = this.trailerID;
    data['truckPlate'] = this.truckPlate;
    data['trailerPlate'] = this.trailerPlate;
    data['truckType'] = this.truckType;
    data['trailerType'] = this.trailerType;
    data['driverID'] = this.driverID;
    data['mileage'] = this.mileage;
    data['checkInTime'] = this.checkInTime;
    data['result'] = this.result;
    data['status'] = this.status;
    data['isDeleted'] = this.isDeleted;
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedTime'] = this.modifiedTime;
    return data;
  }
}
