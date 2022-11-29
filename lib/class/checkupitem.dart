class CheckupItem {
  int? checkUpItemID;
  int? checkUpHeaderID;
  String? truckType;
  String? subTruckType;
  int? detailNo;
  String? detailName;
  bool? isChecked;
  bool? isHeader;
  String? remark;
  String? dueDate;
  String? createdBy;
  String? createdTime;
  String? modifiedBy;
  String? modifiedTime;

  CheckupItem(
      {this.checkUpItemID,
      this.checkUpHeaderID,
      this.truckType,
      this.subTruckType,
      this.detailNo,
      this.detailName,
      this.isChecked,
      this.isHeader,
      this.remark,
      this.dueDate,
      this.createdBy,
      this.createdTime,
      this.modifiedBy,
      this.modifiedTime});

  CheckupItem.fromJson(Map<String, dynamic> json) {
    checkUpItemID = json['checkUpItemID'];
    checkUpHeaderID = json['checkUpHeaderID'];
    truckType = json['truckType'];
    subTruckType = json['subTruckType'];
    detailNo = json['detailNo'];
    detailName = json['detailName'];
    isChecked = json['isChecked'];
    isHeader = json['isHeader'];
    remark = json['remark'];
    dueDate = json['dueDate'];
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    modifiedBy = json['modifiedBy'];
    modifiedTime = json['modifiedTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['checkUpItemID'] = this.checkUpItemID;
    data['checkUpHeaderID'] = this.checkUpHeaderID;
    data['truckType'] = this.truckType;
    data['subTruckType'] = this.subTruckType;
    data['detailNo'] = this.detailNo;
    data['detailName'] = this.detailName;
    data['isChecked'] = this.isChecked;
    data['isHeader'] = this.isHeader;
    data['remark'] = this.remark;
    data['dueDate'] = this.dueDate;
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedTime'] = this.modifiedTime;
    return data;
  }
}
