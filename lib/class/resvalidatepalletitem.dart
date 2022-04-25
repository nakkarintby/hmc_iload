class ResValidatePalletitem {
  Palletitem? palletitem;
  String? aUnit;
  String? matdescription;
  String? pallettypename;
  double? remainingweight;
  double? remainingdocument;
  String? errorMsg;

  ResValidatePalletitem(
      {this.palletitem,
      this.aUnit,
      this.matdescription,
      this.pallettypename,
      this.remainingweight,
      this.remainingdocument,
      this.errorMsg});

  ResValidatePalletitem.fromJson(Map<String, dynamic> json) {
    palletitem = json['palletitem'] != null
        ? new Palletitem.fromJson(json['palletitem'])
        : null;
    aUnit = json['AUnit'];
    matdescription = json['matdescription'];
    pallettypename = json['pallettypename'];
    remainingweight = json['remainingweight'];
    remainingdocument = json['remainingdocument'];
    errorMsg = json['ErrorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.palletitem != null) {
      data['palletitem'] = this.palletitem!.toJson();
    }
    data['AUnit'] = this.aUnit;
    data['matdescription'] = this.matdescription;
    data['pallettypename'] = this.pallettypename;
    data['remainingweight'] = this.remainingweight;
    data['remainingdocument'] = this.remainingdocument;
    data['ErrorMsg'] = this.errorMsg;
    return data;
  }
}

class Palletitem {
  String? id;
  int? palletItemId;
  String? palletNo;
  int? documentId;
  int? documentItemId;
  int? binId;
  int? materialId;
  String? lot;
  double? weight;
  int? unitId;
  int? movementTypeId;
  String? movementTypeAction;
  bool? isPosted;
  bool? isDeleted;
  String? scanBy;
  String? scanOn;
  String? createdBy;
  String? createdOn;
  String? modifiedBy;
  String? modifiedOn;
  String? gradeLabel;
  dynamic reprintBy;
  dynamic reprintOn;
  dynamic damageBy;
  dynamic entityKey;
  String? deviceInfo;

  Palletitem(
      {this.id,
      this.palletItemId,
      this.palletNo,
      this.documentId,
      this.documentItemId,
      this.binId,
      this.materialId,
      this.lot,
      this.weight,
      this.unitId,
      this.movementTypeId,
      this.movementTypeAction,
      this.isPosted,
      this.isDeleted,
      this.scanBy,
      this.scanOn,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn,
      this.gradeLabel,
      this.reprintBy,
      this.reprintOn,
      this.damageBy,
      this.entityKey,
      this.deviceInfo});

  Palletitem.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    palletItemId = json['PalletItemId'];
    palletNo = json['PalletNo'];
    documentId = json['DocumentId'];
    documentItemId = json['DocumentItemId'];
    binId = json['BinId'];
    materialId = json['MaterialId'];
    lot = json['Lot'];
    weight = json['Weight'];
    unitId = json['UnitId'];
    movementTypeId = json['MovementTypeId'];
    movementTypeAction = json['MovementTypeAction'];
    isPosted = json['IsPosted'];
    isDeleted = json['IsDeleted'];
    scanBy = json['ScanBy'];
    scanOn = json['ScanOn'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    modifiedBy = json['ModifiedBy'];
    modifiedOn = json['ModifiedOn'];
    gradeLabel = json['GradeLabel'];
    reprintBy = json['ReprintBy'];
    reprintOn = json['ReprintOn'];
    damageBy = json['DamageBy'];
    entityKey = json['EntityKey'];
    deviceInfo = json['DeviceInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    data['PalletItemId'] = this.palletItemId;
    data['PalletNo'] = this.palletNo;
    data['DocumentId'] = this.documentId;
    data['DocumentItemId'] = this.documentItemId;
    data['BinId'] = this.binId;
    data['MaterialId'] = this.materialId;
    data['Lot'] = this.lot;
    data['Weight'] = this.weight;
    data['UnitId'] = this.unitId;
    data['MovementTypeId'] = this.movementTypeId;
    data['MovementTypeAction'] = this.movementTypeAction;
    data['IsPosted'] = this.isPosted;
    data['IsDeleted'] = this.isDeleted;
    data['ScanBy'] = this.scanBy;
    data['ScanOn'] = this.scanOn;
    data['CreatedBy'] = this.createdBy;
    data['CreatedOn'] = this.createdOn;
    data['ModifiedBy'] = this.modifiedBy;
    data['ModifiedOn'] = this.modifiedOn;
    data['GradeLabel'] = this.gradeLabel;
    data['ReprintBy'] = this.reprintBy;
    data['ReprintOn'] = this.reprintOn;
    data['DamageBy'] = this.damageBy;
    data['EntityKey'] = this.entityKey;
    data['DeviceInfo'] = this.deviceInfo;
    return data;
  }
}
