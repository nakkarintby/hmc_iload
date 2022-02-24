class ResValidateLocation {
  Location? location;
  String? errorMsg;

  ResValidateLocation({this.location, this.errorMsg});

  ResValidateLocation.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    errorMsg = json['ErrorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['ErrorMsg'] = this.errorMsg;
    return data;
  }
}

class Location {
  String? id;
  int? binId;
  String? binName;
  String? binDescription;
  bool? damageBin;
  bool? isDeleted;
  bool? isSilo;
  String? createdBy;
  String? createdOn;
  String? modifiedBy;
  String? modifiedOn;
  EntityKey? entityKey;

  Location(
      {this.id,
      this.binId,
      this.binName,
      this.binDescription,
      this.damageBin,
      this.isDeleted,
      this.isSilo,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn,
      this.entityKey});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    binId = json['BinId'];
    binName = json['BinName'];
    binDescription = json['BinDescription'];
    damageBin = json['DamageBin'];
    isDeleted = json['IsDeleted'];
    isSilo = json['IsSilo'];
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
    data['BinId'] = this.binId;
    data['BinName'] = this.binName;
    data['BinDescription'] = this.binDescription;
    data['DamageBin'] = this.damageBin;
    data['IsDeleted'] = this.isDeleted;
    data['IsSilo'] = this.isSilo;
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
