class ResValidateImage {
  Document? document;
  bool? canUpload;
  bool? canComplete;
  int? sequence;
  String? errorMsg;

  ResValidateImage(
      {this.document,
      this.canUpload,
      this.canComplete,
      this.sequence,
      this.errorMsg});

  ResValidateImage.fromJson(Map<String, dynamic> json) {
    document = json['document'] != null
        ? new Document.fromJson(json['document'])
        : null;
    canUpload = json['canUpload'];
    canComplete = json['canComplete'];
    sequence = json['Sequence'];
    errorMsg = json['ErrorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.document != null) {
      data['document'] = this.document!.toJson();
    }
    data['canUpload'] = this.canUpload;
    data['canComplete'] = this.canComplete;
    data['Sequence'] = this.sequence;
    data['ErrorMsg'] = this.errorMsg;
    return data;
  }
}

class Document {
  String? id;
  int? documentId;
  int? customerId;
  int? loadingPointId;
  int? binId;
  int? unitId;
  String? planDate;
  bool? silo;
  String? doWo;
  String? documentType;
  String? documentStatus;
  String? licensePlate;
  String? driverName;
  double? netWeight;
  double? truckIn;
  double? truckOut;
  double? totalTruckWeight;
  int? transporter;
  String? remark;
  String? startLoadingTime;
  String? startLoadTime;
  String? completedLoadTime;
  String? takeTime;
  double? totalProductWeight;
  bool? internalRepack;
  String? tISI;
  int? sequence;
  bool? flagOutbound;
  String? outboundTime;
  String? shipTo;
  String? shipNo;
  String? shipType;
  String? transporterEWM;
  bool? flagImgBefore;
  bool? flagImgAfter;
  bool? flagImgSecurity;
  bool? isDeleted;
  String? createdBy;
  String? createdOn;
  String? modifiedBy;
  String? modifiedOn;
  EntityKey? entityKey;

  Document(
      {this.id,
      this.documentId,
      this.customerId,
      this.loadingPointId,
      this.binId,
      this.unitId,
      this.planDate,
      this.silo,
      this.doWo,
      this.documentType,
      this.documentStatus,
      this.licensePlate,
      this.driverName,
      this.netWeight,
      this.truckIn,
      this.truckOut,
      this.totalTruckWeight,
      this.transporter,
      this.remark,
      this.startLoadingTime,
      this.startLoadTime,
      this.completedLoadTime,
      this.takeTime,
      this.totalProductWeight,
      this.internalRepack,
      this.tISI,
      this.sequence,
      this.flagOutbound,
      this.outboundTime,
      this.shipTo,
      this.shipNo,
      this.shipType,
      this.transporterEWM,
      this.flagImgBefore,
      this.flagImgAfter,
      this.flagImgSecurity,
      this.isDeleted,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn,
      this.entityKey});

  Document.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    documentId = json['DocumentId'];
    customerId = json['CustomerId'];
    loadingPointId = json['LoadingPointId'];
    binId = json['BinId'];
    unitId = json['UnitId'];
    planDate = json['PlanDate'];
    silo = json['Silo'];
    doWo = json['DoWo'];
    documentType = json['DocumentType'];
    documentStatus = json['DocumentStatus'];
    licensePlate = json['LicensePlate'];
    driverName = json['DriverName'];
    netWeight = json['NetWeight'];
    truckIn = json['TruckIn'];
    truckOut = json['TruckOut'];
    totalTruckWeight = json['TotalTruckWeight'];
    transporter = json['Transporter'];
    remark = json['Remark'];
    startLoadingTime = json['StartLoadingTime'];
    startLoadTime = json['StartLoadTime'];
    completedLoadTime = json['CompletedLoadTime'];
    takeTime = json['TakeTime'];
    totalProductWeight = json['TotalProductWeight'];
    internalRepack = json['InternalRepack'];
    tISI = json['TISI'];
    sequence = json['Sequence'];
    flagOutbound = json['FlagOutbound'];
    outboundTime = json['OutboundTime'];
    shipTo = json['ShipTo'];
    shipNo = json['ShipNo'];
    shipType = json['ShipType'];
    transporterEWM = json['TransporterEWM'];
    flagImgBefore = json['FlagImgBefore'];
    flagImgAfter = json['FlagImgAfter'];
    flagImgSecurity = json['FlagImgSecurity'];
    isDeleted = json['IsDeleted'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    modifiedBy = json['ModifiedBy'];
    modifiedOn = json['ModifiedOn'];
    entityKey = json['EntityKey'] != null
        ? new EntityKey.fromJson(json['EntityKey'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    data['DocumentId'] = this.documentId;
    data['CustomerId'] = this.customerId;
    data['LoadingPointId'] = this.loadingPointId;
    data['BinId'] = this.binId;
    data['UnitId'] = this.unitId;
    data['PlanDate'] = this.planDate;
    data['Silo'] = this.silo;
    data['DoWo'] = this.doWo;
    data['DocumentType'] = this.documentType;
    data['DocumentStatus'] = this.documentStatus;
    data['LicensePlate'] = this.licensePlate;
    data['DriverName'] = this.driverName;
    data['NetWeight'] = this.netWeight;
    data['TruckIn'] = this.truckIn;
    data['TruckOut'] = this.truckOut;
    data['TotalTruckWeight'] = this.totalTruckWeight;
    data['Transporter'] = this.transporter;
    data['Remark'] = this.remark;
    data['StartLoadingTime'] = this.startLoadingTime;
    data['StartLoadTime'] = this.startLoadTime;
    data['CompletedLoadTime'] = this.completedLoadTime;
    data['TakeTime'] = this.takeTime;
    data['TotalProductWeight'] = this.totalProductWeight;
    data['InternalRepack'] = this.internalRepack;
    data['TISI'] = this.tISI;
    data['Sequence'] = this.sequence;
    data['FlagOutbound'] = this.flagOutbound;
    data['OutboundTime'] = this.outboundTime;
    data['ShipTo'] = this.shipTo;
    data['ShipNo'] = this.shipNo;
    data['ShipType'] = this.shipType;
    data['TransporterEWM'] = this.transporterEWM;
    data['FlagImgBefore'] = this.flagImgBefore;
    data['FlagImgAfter'] = this.flagImgAfter;
    data['FlagImgSecurity'] = this.flagImgSecurity;
    data['IsDeleted'] = this.isDeleted;
    data['CreatedBy'] = this.createdBy;
    data['CreatedOn'] = this.createdOn;
    data['ModifiedBy'] = this.modifiedBy;
    data['ModifiedOn'] = this.modifiedOn;
    if (this.entityKey != null) {
      data['EntityKey'] = this.entityKey!.toJson();
    }
    return data;
  }
}

class EntityKey {
  String? id;
  String? entitySetName;
  String? entityContainerName;
  List<EntityKeyValues>? entityKeyValues;

  EntityKey(
      {this.id,
      this.entitySetName,
      this.entityContainerName,
      this.entityKeyValues});

  EntityKey.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    entitySetName = json['EntitySetName'];
    entityContainerName = json['EntityContainerName'];
    if (json['EntityKeyValues'] != null) {
      entityKeyValues = <EntityKeyValues>[];
      json['EntityKeyValues'].forEach((v) {
        entityKeyValues!.add(new EntityKeyValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    data['EntitySetName'] = this.entitySetName;
    data['EntityContainerName'] = this.entityContainerName;
    if (this.entityKeyValues != null) {
      data['EntityKeyValues'] =
          this.entityKeyValues!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EntityKeyValues {
  String? key;
  String? type;
  String? value;

  EntityKeyValues({this.key, this.type, this.value});

  EntityKeyValues.fromJson(Map<String, dynamic> json) {
    key = json['Key'];
    type = json['Type'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Key'] = this.key;
    data['Type'] = this.type;
    data['Value'] = this.value;
    return data;
  }
}
