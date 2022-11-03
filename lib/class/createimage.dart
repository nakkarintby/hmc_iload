class CreateImage {
  String? documentType;
  String? eventType;
  int? documentID;
  int? sequence;
  String? deviceInfo;
  String? osInfo;
  String? gps;
  bool? isDeleted;
  String? createdBy;
  String? imageBase64;

  CreateImage(
      {this.documentType,
      this.eventType,
      this.documentID,
      this.sequence,
      this.deviceInfo,
      this.osInfo,
      this.gps,
      this.isDeleted,
      this.createdBy,
      this.imageBase64});

  CreateImage.fromJson(Map<String, dynamic> json) {
    documentType = json['documentType'];
    eventType = json['eventType'];
    documentID = json['documentID'];
    sequence = json['sequence'];
    deviceInfo = json['deviceInfo'];
    osInfo = json['osInfo'];
    gps = json['gps'];
    isDeleted = json['isDeleted'];
    createdBy = json['createdBy'];
    imageBase64 = json['imageBase64'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentType'] = this.documentType;
    data['eventType'] = this.eventType;
    data['documentID'] = this.documentID;
    data['sequence'] = this.sequence;
    data['deviceInfo'] = this.deviceInfo;
    data['osInfo'] = this.osInfo;
    data['gps'] = this.gps;
    data['isDeleted'] = this.isDeleted;
    data['createdBy'] = this.createdBy;
    data['imageBase64'] = this.imageBase64;
    return data;
  }
}
