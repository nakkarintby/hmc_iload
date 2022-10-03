class ImageSequence {
  int? docID;
  String? type;
  int? seq;
  int? max;
  String? msg;
  String? status;

  ImageSequence(
      {this.docID, this.type, this.seq, this.max, this.msg, this.status});

  ImageSequence.fromJson(Map<String, dynamic> json) {
    docID = json['docID'];
    type = json['type'];
    seq = json['seq'];
    max = json['max'];
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docID'] = this.docID;
    data['type'] = this.type;
    data['seq'] = this.seq;
    data['max'] = this.max;
    data['msg'] = this.msg;
    data['status'] = this.status;
    return data;
  }
}
