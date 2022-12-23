class CheckUpItemClass {
  int? checkUpItemID;
  int? checkUpHeaderID;
  String? truckType;
  String? subTruckType;
  String? groupName;
  int? detailNo;
  String? detailName;
  bool? isChecked;
  int? fixDay;
  bool? isWarning;
  String? remark;
  String? dueDate;
  String? createdBy;
  String? createdTime;
  String? modifiedBy;
  String? modifiedTime;

  CheckUpItemClass(
      {this.checkUpItemID,
      this.checkUpHeaderID,
      this.truckType,
      this.subTruckType,
      this.groupName,
      this.detailNo,
      this.detailName,
      this.isChecked,
      this.fixDay,
      this.isWarning,
      this.remark,
      this.dueDate,
      this.createdBy,
      this.createdTime,
      this.modifiedBy,
      this.modifiedTime});

  CheckUpItemClass.fromJson(Map<String, dynamic> json) {
    checkUpItemID = json['checkUpItemID'];
    checkUpHeaderID = json['checkUpHeaderID'];
    truckType = json['truckType'];
    subTruckType = json['subTruckType'];
    groupName = json['groupName'];
    detailNo = json['detailNo'];
    detailName = json['detailName'];
    isChecked = json['isChecked'];
    fixDay = json['fixDay'];
    isWarning = json['isWarning'];
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
    data['groupName'] = this.groupName;
    data['detailNo'] = this.detailNo;
    data['detailName'] = this.detailName;
    data['isChecked'] = this.isChecked;
    data['fixDay'] = this.fixDay;
    data['isWarning'] = this.isWarning;
    data['remark'] = this.remark;
    data['dueDate'] = this.dueDate;
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedTime'] = this.modifiedTime;
    return data;
  }
}
