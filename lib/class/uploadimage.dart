class UploadImage {
  String? gps;
  ImageDetail? imageDetail;

  UploadImage({this.gps, this.imageDetail});

  UploadImage.fromJson(Map<String, dynamic> json) {
    gps = json['gps'];
    imageDetail = json['imageDetail'] != null
        ? new ImageDetail.fromJson(json['imageDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gps'] = this.gps;
    if (this.imageDetail != null) {
      data['imageDetail'] = this.imageDetail!.toJson();
    }
    return data;
  }
}

class ImageDetail {
  String? type;
  int? docID;
  int? sequence;
  String? deviceInfo;
  String? osInfo;
  bool? isDeleted;
  String? createdBy;
  String? imageBase64;

  ImageDetail(
      {this.type,
      this.docID,
      this.sequence,
      this.deviceInfo,
      this.osInfo,
      this.isDeleted,
      this.createdBy,
      this.imageBase64});

  ImageDetail.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    docID = json['docID'];
    sequence = json['sequence'];
    deviceInfo = json['deviceInfo'];
    osInfo = json['osInfo'];
    isDeleted = json['isDeleted'];
    createdBy = json['createdBy'];
    imageBase64 = json['imageBase64'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['docID'] = this.docID;
    data['sequence'] = this.sequence;
    data['deviceInfo'] = this.deviceInfo;
    data['osInfo'] = this.osInfo;
    data['isDeleted'] = this.isDeleted;
    data['createdBy'] = this.createdBy;
    data['imageBase64'] = this.imageBase64;
    return data;
  }
}
