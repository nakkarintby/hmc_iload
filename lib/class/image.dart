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

  ImagePic(
      {this.documentId,
      this.sequence,
      this.eventType,
      this.imageValue,
      this.isDeleted,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn});

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
    return data;
  }
}
