class TransportationDocument {
  int? transportationDocID;
  int? shipmentAdviceID;
  String? bookingNo;
  String? shipmentNo;
  String? customer;
  String? type;
  String? doTo;
  String? loadingDate;
  String? carrier;
  String? returnDateTime;
  String? returnPlace;
  String? cutOffDateTime;
  String? truckPlate;
  String? driverName;
  String? truckType;
  String? trailerPlate;
  String? trailerType;
  String? remark;
  String? shipTo;
  String? province;
  String? district;
  String? containerNo;
  bool? isCompletedPhotoUnload;
  bool? isCompletedPhotoLoad;
  bool? isDeleted;
  String? arrivalGPS;
  String? arrivalGPSTime;
  String? loadingPointGPS;
  String? loadingPointGPSTime;
  String? unLoadingPointGPS;
  String? unLoadingPointGPSTime;
  String? status;
  String? createdBy;
  String? createdTime;
  String? modifiedBy;
  String? modifiedTime;

  TransportationDocument(
      {this.transportationDocID,
      this.shipmentAdviceID,
      this.bookingNo,
      this.shipmentNo,
      this.customer,
      this.type,
      this.doTo,
      this.loadingDate,
      this.carrier,
      this.returnDateTime,
      this.returnPlace,
      this.cutOffDateTime,
      this.truckPlate,
      this.driverName,
      this.truckType,
      this.trailerPlate,
      this.trailerType,
      this.remark,
      this.shipTo,
      this.province,
      this.district,
      this.containerNo,
      this.isCompletedPhotoUnload,
      this.isCompletedPhotoLoad,
      this.isDeleted,
      this.arrivalGPS,
      this.arrivalGPSTime,
      this.loadingPointGPS,
      this.loadingPointGPSTime,
      this.unLoadingPointGPS,
      this.unLoadingPointGPSTime,
      this.status,
      this.createdBy,
      this.createdTime,
      this.modifiedBy,
      this.modifiedTime});

  TransportationDocument.fromJson(Map<String, dynamic> json) {
    transportationDocID = json['transportationDocID'];
    shipmentAdviceID = json['shipmentAdviceID'];
    bookingNo = json['bookingNo'];
    shipmentNo = json['shipmentNo'];
    customer = json['customer'];
    type = json['type'];
    doTo = json['doTo'];
    loadingDate = json['loadingDate'];
    carrier = json['carrier'];
    returnDateTime = json['returnDateTime'];
    returnPlace = json['returnPlace'];
    cutOffDateTime = json['cutOffDateTime'];
    truckPlate = json['truckPlate'];
    driverName = json['driverName'];
    truckType = json['truckType'];
    trailerPlate = json['trailerPlate'];
    trailerType = json['trailerType'];
    remark = json['remark'];
    shipTo = json['shipTo'];
    province = json['province'];
    district = json['district'];
    containerNo = json['containerNo'];
    isCompletedPhotoUnload = json['isCompletedPhotoUnload'];
    isCompletedPhotoLoad = json['isCompletedPhotoLoad'];
    isDeleted = json['isDeleted'];
    arrivalGPS = json['arrivalGPS'];
    arrivalGPSTime = json['arrivalGPSTime'];
    loadingPointGPS = json['loadingPointGPS'];
    loadingPointGPSTime = json['loadingPointGPSTime'];
    unLoadingPointGPS = json['unLoadingPointGPS'];
    unLoadingPointGPSTime = json['unLoadingPointGPSTime'];
    status = json['status'];
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    modifiedBy = json['modifiedBy'];
    modifiedTime = json['modifiedTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transportationDocID'] = this.transportationDocID;
    data['shipmentAdviceID'] = this.shipmentAdviceID;
    data['bookingNo'] = this.bookingNo;
    data['shipmentNo'] = this.shipmentNo;
    data['customer'] = this.customer;
    data['type'] = this.type;
    data['doTo'] = this.doTo;
    data['loadingDate'] = this.loadingDate;
    data['carrier'] = this.carrier;
    data['returnDateTime'] = this.returnDateTime;
    data['returnPlace'] = this.returnPlace;
    data['cutOffDateTime'] = this.cutOffDateTime;
    data['truckPlate'] = this.truckPlate;
    data['driverName'] = this.driverName;
    data['truckType'] = this.truckType;
    data['trailerPlate'] = this.trailerPlate;
    data['trailerType'] = this.trailerType;
    data['remark'] = this.remark;
    data['shipTo'] = this.shipTo;
    data['province'] = this.province;
    data['district'] = this.district;
    data['containerNo'] = this.containerNo;
    data['isCompletedPhotoUnload'] = this.isCompletedPhotoUnload;
    data['isCompletedPhotoLoad'] = this.isCompletedPhotoLoad;
    data['isDeleted'] = this.isDeleted;
    data['arrivalGPS'] = this.arrivalGPS;
    data['arrivalGPSTime'] = this.arrivalGPSTime;
    data['loadingPointGPS'] = this.loadingPointGPS;
    data['loadingPointGPSTime'] = this.loadingPointGPSTime;
    data['unLoadingPointGPS'] = this.unLoadingPointGPS;
    data['unLoadingPointGPSTime'] = this.unLoadingPointGPSTime;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedTime'] = this.modifiedTime;
    return data;
  }
}
