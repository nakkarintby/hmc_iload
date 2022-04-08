class ResInfoApp {
  String? id;
  int? configurationId;
  String? key;
  int? value;
  String? description;
  EntityKey? entityKey;

  ResInfoApp(
      {this.id,
      this.configurationId,
      this.key,
      this.value,
      this.description,
      this.entityKey});

  ResInfoApp.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    configurationId = json['ConfigurationId'];
    key = json['Key'];
    value = json['Value'];
    description = json['Description'];
    entityKey = json['EntityKey'] != null
        ? new EntityKey.fromJson(json['EntityKey'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    data['ConfigurationId'] = this.configurationId;
    data['Key'] = this.key;
    data['Value'] = this.value;
    data['Description'] = this.description;
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
