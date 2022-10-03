class ContainerDocument {
  ContainerDoc? containerDoc;

  ContainerDocument({this.containerDoc});

  ContainerDocument.fromJson(Map<String, dynamic> json) {
    containerDoc = json['containerDoc'] != null
        ? new ContainerDoc.fromJson(json['containerDoc'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.containerDoc != null) {
      data['containerDoc'] = this.containerDoc!.toJson();
    }
    return data;
  }
}

class ContainerDoc {
  int? containerDocID;
  String? bookingNo;
  String? shipmentNo;
  String? customer;
  String? cyDateTime;
  String? cyPlace;
  String? vgmCutOffDateTime;
  String? carrier;
  String? truckPlate;
  String? driverName;
  String? truckType;
  String? trailerPlate;
  String? trialerType;
  String? containerType;
  int? containerQty;
  String? containerNo1;
  String? sealNo1;
  double? weight1;
  String? containerNo2;
  String? sealNo2;
  double? weight2;
  String? remark;
  String? invoiceAddress;
  String? pickUpGPS;
  bool? isCompletedPhoto;
  String? status;
  bool? isDeleted;
  String? createdBy;
  String? createdTime;
  String? modifiedBy;
  String? modifiedTime;

  ContainerDoc(
      {this.containerDocID,
      this.bookingNo,
      this.shipmentNo,
      this.customer,
      this.cyDateTime,
      this.cyPlace,
      this.vgmCutOffDateTime,
      this.carrier,
      this.truckPlate,
      this.driverName,
      this.truckType,
      this.trailerPlate,
      this.trialerType,
      this.containerType,
      this.containerQty,
      this.containerNo1,
      this.sealNo1,
      this.weight1,
      this.containerNo2,
      this.sealNo2,
      this.weight2,
      this.remark,
      this.invoiceAddress,
      this.pickUpGPS,
      this.isCompletedPhoto,
      this.status,
      this.isDeleted,
      this.createdBy,
      this.createdTime,
      this.modifiedBy,
      this.modifiedTime});

  ContainerDoc.fromJson(Map<String, dynamic> json) {
    containerDocID = json['containerDocID'];
    bookingNo = json['bookingNo'];
    shipmentNo = json['shipmentNo'];
    customer = json['customer'];
    cyDateTime = json['cyDateTime'];
    cyPlace = json['cyPlace'];
    vgmCutOffDateTime = json['vgmCutOffDateTime'];
    carrier = json['carrier'];
    truckPlate = json['truckPlate'];
    driverName = json['driverName'];
    truckType = json['truckType'];
    trailerPlate = json['trailerPlate'];
    trialerType = json['trialerType'];
    containerType = json['containerType'];
    containerQty = json['containerQty'];
    containerNo1 = json['containerNo1'];
    sealNo1 = json['sealNo1'];
    weight1 = json['weight1'];
    containerNo2 = json['containerNo2'];
    sealNo2 = json['sealNo2'];
    weight2 = json['weight2'];
    remark = json['remark'];
    invoiceAddress = json['invoiceAddress'];
    pickUpGPS = json['pickUpGPS'];
    isCompletedPhoto = json['isCompletedPhoto'];
    status = json['status'];
    isDeleted = json['isDeleted'];
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    modifiedBy = json['modifiedBy'];
    modifiedTime = json['modifiedTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['containerDocID'] = this.containerDocID;
    data['bookingNo'] = this.bookingNo;
    data['shipmentNo'] = this.shipmentNo;
    data['customer'] = this.customer;
    data['cyDateTime'] = this.cyDateTime;
    data['cyPlace'] = this.cyPlace;
    data['vgmCutOffDateTime'] = this.vgmCutOffDateTime;
    data['carrier'] = this.carrier;
    data['truckPlate'] = this.truckPlate;
    data['driverName'] = this.driverName;
    data['truckType'] = this.truckType;
    data['trailerPlate'] = this.trailerPlate;
    data['trialerType'] = this.trialerType;
    data['containerType'] = this.containerType;
    data['containerQty'] = this.containerQty;
    data['containerNo1'] = this.containerNo1;
    data['sealNo1'] = this.sealNo1;
    data['weight1'] = this.weight1;
    data['containerNo2'] = this.containerNo2;
    data['sealNo2'] = this.sealNo2;
    data['weight2'] = this.weight2;
    data['remark'] = this.remark;
    data['invoiceAddress'] = this.invoiceAddress;
    data['pickUpGPS'] = this.pickUpGPS;
    data['isCompletedPhoto'] = this.isCompletedPhoto;
    data['status'] = this.status;
    data['isDeleted'] = this.isDeleted;
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedTime'] = this.modifiedTime;
    return data;
  }
}
