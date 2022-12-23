class CreateCheckupHeader {
  int? truckID;
  int? trailerID;
  String? truckPlate;
  String? trailerPlate;
  String? truckType;
  String? trailerType;
  int? driverID;
  dynamic mileage;
  String? createdBy;

  CreateCheckupHeader(
      {this.truckID,
      this.trailerID,
      this.truckPlate,
      this.trailerPlate,
      this.truckType,
      this.trailerType,
      this.driverID,
      this.mileage,
      this.createdBy});

  CreateCheckupHeader.fromJson(Map<String, dynamic> json) {
    truckID = json['truckID'];
    trailerID = json['trailerID'];
    truckPlate = json['truckPlate'];
    trailerPlate = json['trailerPlate'];
    truckType = json['truckType'];
    trailerType = json['trailerType'];
    driverID = json['driverID'];
    mileage = json['mileage'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['truckID'] = this.truckID;
    data['trailerID'] = this.trailerID;
    data['truckPlate'] = this.truckPlate;
    data['trailerPlate'] = this.trailerPlate;
    data['truckType'] = this.truckType;
    data['trailerType'] = this.trailerType;
    data['driverID'] = this.driverID;
    data['mileage'] = this.mileage;
    data['createdBy'] = this.createdBy;
    return data;
  }
}
