class StockOView {
  String? id;
  int? stockOverviewId;
  int? materialId;
  String? materialName;
  String? materialDescription;
  String? lot;
  String? package;
  double? weight;
  int? palletTypeId;
  String? palletTypeName;
  String? baseUnit;
  bool? tracking;
  String? aUnit;
  int? productionLineId;
  String? binName;
  int? binId;
  bool? damageBin;
  int? customerId;
  String? customerName;
  int? qty;
  EntityKey? entityKey;

  StockOView(
      {this.id,
      this.stockOverviewId,
      this.materialId,
      this.materialName,
      this.materialDescription,
      this.lot,
      this.package,
      this.weight,
      this.palletTypeId,
      this.palletTypeName,
      this.baseUnit,
      this.tracking,
      this.aUnit,
      this.productionLineId,
      this.binName,
      this.binId,
      this.damageBin,
      this.customerId,
      this.customerName,
      this.qty,
      this.entityKey});

  StockOView.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    stockOverviewId = json['StockOverviewId'];
    materialId = json['MaterialId'];
    materialName = json['MaterialName'];
    materialDescription = json['MaterialDescription'];
    lot = json['Lot'];
    package = json['Package'];
    weight = json['Weight'];
    palletTypeId = json['PalletTypeId'];
    palletTypeName = json['PalletTypeName'];
    baseUnit = json['BaseUnit'];
    tracking = json['Tracking'];
    aUnit = json['AUnit'];
    productionLineId = json['ProductionLineId'];
    binName = json['BinName'];
    binId = json['BinId'];
    damageBin = json['DamageBin'];
    customerId = json['CustomerId'];
    customerName = json['CustomerName'];
    qty = json['Qty'];
    entityKey = json['EntityKey'] != null
        ? new EntityKey.fromJson(json['EntityKey'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    data['StockOverviewId'] = this.stockOverviewId;
    data['MaterialId'] = this.materialId;
    data['MaterialName'] = this.materialName;
    data['MaterialDescription'] = this.materialDescription;
    data['Lot'] = this.lot;
    data['Package'] = this.package;
    data['Weight'] = this.weight;
    data['PalletTypeId'] = this.palletTypeId;
    data['PalletTypeName'] = this.palletTypeName;
    data['BaseUnit'] = this.baseUnit;
    data['Tracking'] = this.tracking;
    data['AUnit'] = this.aUnit;
    data['ProductionLineId'] = this.productionLineId;
    data['BinName'] = this.binName;
    data['BinId'] = this.binId;
    data['DamageBin'] = this.damageBin;
    data['CustomerId'] = this.customerId;
    data['CustomerName'] = this.customerName;
    data['Qty'] = this.qty;
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
