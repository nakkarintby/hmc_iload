class GetSequnce {
  bool? canUpload;
  bool? canComplete;
  int? sequence;
  String? errorMsg;
  int? max;
  int? min;

  GetSequnce(
      {this.canUpload,
      this.canComplete,
      this.sequence,
      this.errorMsg,
      this.max,
      this.min});

  GetSequnce.fromJson(Map<String, dynamic> json) {
    canUpload = json['canUpload'];
    canComplete = json['canComplete'];
    sequence = json['sequence'];
    errorMsg = json['errorMsg'];
    max = json['max'];
    min = json['min'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canUpload'] = this.canUpload;
    data['canComplete'] = this.canComplete;
    data['sequence'] = this.sequence;
    data['errorMsg'] = this.errorMsg;
    data['max'] = this.max;
    data['min'] = this.min;
    return data;
  }
}
