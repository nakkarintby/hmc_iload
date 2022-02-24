class DataUser {
  User? user;
  String? errorMsg;

  DataUser({this.user, this.errorMsg});

  DataUser.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    errorMsg = json['ErrorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['ErrorMsg'] = this.errorMsg;
    return data;
  }
}

class User {
  String? id;
  int? userId;
  String? userName;
  String? password;
  String? role;
  bool? isWeb;
  bool? isMobile;
  bool? isDeleted;
  String? createdBy;
  String? createdOn;
  String? modifiedBy;
  String? modifiedOn;
  EntityKey? entityKey;

  User(
      {this.id,
      this.userId,
      this.userName,
      this.password,
      this.role,
      this.isWeb,
      this.isMobile,
      this.isDeleted,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn,
      this.entityKey});

  User.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    userId = json['UserId'];
    userName = json['UserName'];
    password = json['Password'];
    role = json['Role'];
    isWeb = json['IsWeb'];
    isMobile = json['IsMobile'];
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
    data['UserId'] = this.userId;
    data['UserName'] = this.userName;
    data['Password'] = this.password;
    data['Role'] = this.role;
    data['IsWeb'] = this.isWeb;
    data['IsMobile'] = this.isMobile;
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
