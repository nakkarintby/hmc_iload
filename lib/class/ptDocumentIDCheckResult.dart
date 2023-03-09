class PTDocumentIDCheckResult {
  String? message;
  List<ImageSubWorkTypeMenu>? data;
  int? documentId;
  String? workTypeName;
  int? workTypeId;

  PTDocumentIDCheckResult(
      {this.message,
      this.data,
      this.documentId,
      this.workTypeName,
      this.workTypeId});

  PTDocumentIDCheckResult.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <ImageSubWorkTypeMenu>[];
      json['data'].forEach((v) {
        data!.add(new ImageSubWorkTypeMenu.fromJson(v));
      });
    }
    documentId = json['documentId'];
    workTypeName = json['workTypeName'];
    workTypeId = json['workTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['documentId'] = this.documentId;
    data['workTypeName'] = this.workTypeName;
    data['workTypeId'] = this.workTypeId;
    return data;
  }
}

class ImageSubWorkTypeMenu {
  int? imageSubWorkTypeId;
  int? workTypeId;
  String? menuWorkTypeNameWeb;
  String? menuWorkTypeNameMobile;
  String? createdBy;
  String? createdOn;
  bool? isDeleted;
  String? modifiedBy;
  String? modifiedOn;

  ImageSubWorkTypeMenu(
      {this.imageSubWorkTypeId,
      this.workTypeId,
      this.menuWorkTypeNameWeb,
      this.menuWorkTypeNameMobile,
      this.createdBy,
      this.createdOn,
      this.isDeleted,
      this.modifiedBy,
      this.modifiedOn});

  ImageSubWorkTypeMenu.fromJson(Map<String, dynamic> json) {
    imageSubWorkTypeId = json['imageSubWorkTypeId'];
    workTypeId = json['workTypeId'];
    menuWorkTypeNameWeb = json['menuWorkTypeNameWeb'];
    menuWorkTypeNameMobile = json['menuWorkTypeNameMobile'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    isDeleted = json['isDeleted'];
    modifiedBy = json['modifiedBy'];
    modifiedOn = json['modifiedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageSubWorkTypeId'] = this.imageSubWorkTypeId;
    data['workTypeId'] = this.workTypeId;
    data['menuWorkTypeNameWeb'] = this.menuWorkTypeNameWeb;
    data['menuWorkTypeNameMobile'] = this.menuWorkTypeNameMobile;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    data['isDeleted'] = this.isDeleted;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedOn'] = this.modifiedOn;
    return data;
  }
}
