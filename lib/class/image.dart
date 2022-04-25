class ImagePic {
  int? documentId;
  int? sequence;
  String? eventType;
  String? imageValue;
  bool? isDeleted;
  String? createdBy;
  String? createdOn;
  String? modifiedBy;
  String? modifiedOn;
  String? deviceInfo;

  ImagePic(
      {this.documentId,
      this.sequence,
      this.eventType,
      this.imageValue,
      this.isDeleted,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn,
      this.deviceInfo});

  ImagePic.fromJson(Map<String, dynamic> json) {
    documentId = json['DocumentId'];
    sequence = json['Sequence'];
    eventType = json['EventType'];
    imageValue = json['ImageValue'];
    isDeleted = json['IsDeleted'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    modifiedBy = json['ModifiedBy'];
    modifiedOn = json['ModifiedOn'];
    deviceInfo = json['DeviceInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocumentId'] = this.documentId;
    data['Sequence'] = this.sequence;
    data['EventType'] = this.eventType;
    data['ImageValue'] = this.imageValue;
    data['IsDeleted'] = this.isDeleted;
    data['CreatedBy'] = this.createdBy;
    data['CreatedOn'] = this.createdOn;
    data['ModifiedBy'] = this.modifiedBy;
    data['ModifiedOn'] = this.modifiedOn;
    data['DeviceInfo'] = this.deviceInfo;
    return data;
  }
}
