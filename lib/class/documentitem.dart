class DocumentItem {
  String? id;
  int? documentItemId;
  int? documentId;
  int? palletTypeId;
  int? materialId;
  String? materialDescription;
  String? package;
  String? lot;
  double? totalWeight;
  double? amount;
  int? unitId;
  Null? remark;
  int? productionLineId;
  int? qty;
  bool? tracking;
  int? movementTypeId;
  bool? isDeleted;
  String? createdBy;
  String? createdOn;
  String? modifiedBy;
  String? modifiedOn;
  EntityKey? entityKey;

  DocumentItem(
      {this.id,
      this.documentItemId,
      this.documentId,
      this.palletTypeId,
      this.materialId,
      this.materialDescription,
      this.package,
      this.lot,
      this.totalWeight,
      this.amount,
      this.unitId,
      this.remark,
      this.productionLineId,
      this.qty,
      this.tracking,
      this.movementTypeId,
      this.isDeleted,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn,
      this.entityKey});

  DocumentItem.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    documentItemId = json['DocumentItemId'];
    documentId = json['DocumentId'];
    palletTypeId = json['PalletTypeId'];
    materialId = json['MaterialId'];
    materialDescription = json['MaterialDescription'];
    package = json['Package'];
    lot = json['Lot'];
    totalWeight = json['TotalWeight'];
    amount = json['Amount'];
    unitId = json['UnitId'];
    remark = json['Remark'];
    productionLineId = json['ProductionLineId'];
    qty = json['Qty'];
    tracking = json['Tracking'];
    movementTypeId = json['MovementTypeId'];
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
    data['DocumentItemId'] = this.documentItemId;
    data['DocumentId'] = this.documentId;
    data['PalletTypeId'] = this.palletTypeId;
    data['MaterialId'] = this.materialId;
    data['MaterialDescription'] = this.materialDescription;
    data['Package'] = this.package;
    data['Lot'] = this.lot;
    data['TotalWeight'] = this.totalWeight;
    data['Amount'] = this.amount;
    data['UnitId'] = this.unitId;
    data['Remark'] = this.remark;
    data['ProductionLineId'] = this.productionLineId;
    data['Qty'] = this.qty;
    data['Tracking'] = this.tracking;
    data['MovementTypeId'] = this.movementTypeId;
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
