class UpdatePin {
  User? user;
  String? msg;
  String? status;

  UpdatePin({this.user, this.msg, this.status});

  UpdatePin.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['msg'] = this.msg;
    data['status'] = this.status;
    return data;
  }
}

class User {
  String? fristName;
  String? lastName;
  String? refreshToken;
  String? refreshTokenExpiryTime;
  String? uid;
  String? deviceInfo;
  String? osInfo;
  String? firebaseToken;
  String? licensePlate;
  String? licensExpiredDateTime;
  String? role;
  String? pin;
  bool? isDeleted;
  String? createdBy;
  String? createdTime;
  String? modifiedBy;
  String? modifiedOn;
  int? id;
  String? userName;
  String? normalizedUserName;
  String? email;
  String? normalizedEmail;
  bool? emailConfirmed;
  String? passwordHash;
  String? securityStamp;
  String? concurrencyStamp;
  String? phoneNumber;
  bool? phoneNumberConfirmed;
  bool? twoFactorEnabled;
  bool? lockoutEnd;
  bool? lockoutEnabled;
  int? accessFailedCount;

  User(
      {this.fristName,
      this.lastName,
      this.refreshToken,
      this.refreshTokenExpiryTime,
      this.uid,
      this.deviceInfo,
      this.osInfo,
      this.firebaseToken,
      this.licensePlate,
      this.licensExpiredDateTime,
      this.role,
      this.pin,
      this.isDeleted,
      this.createdBy,
      this.createdTime,
      this.modifiedBy,
      this.modifiedOn,
      this.id,
      this.userName,
      this.normalizedUserName,
      this.email,
      this.normalizedEmail,
      this.emailConfirmed,
      this.passwordHash,
      this.securityStamp,
      this.concurrencyStamp,
      this.phoneNumber,
      this.phoneNumberConfirmed,
      this.twoFactorEnabled,
      this.lockoutEnd,
      this.lockoutEnabled,
      this.accessFailedCount});

  User.fromJson(Map<String, dynamic> json) {
    fristName = json['fristName'];
    lastName = json['lastName'];
    refreshToken = json['refreshToken'];
    refreshTokenExpiryTime = json['refreshTokenExpiryTime'];
    uid = json['uid'];
    deviceInfo = json['deviceInfo'];
    osInfo = json['osInfo'];
    firebaseToken = json['firebaseToken'];
    licensePlate = json['licensePlate'];
    licensExpiredDateTime = json['licensExpiredDateTime'];
    role = json['role'];
    pin = json['pin'];
    isDeleted = json['isDeleted'];
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    modifiedBy = json['modifiedBy'];
    modifiedOn = json['modifiedOn'];
    id = json['id'];
    userName = json['userName'];
    normalizedUserName = json['normalizedUserName'];
    email = json['email'];
    normalizedEmail = json['normalizedEmail'];
    emailConfirmed = json['emailConfirmed'];
    passwordHash = json['passwordHash'];
    securityStamp = json['securityStamp'];
    concurrencyStamp = json['concurrencyStamp'];
    phoneNumber = json['phoneNumber'];
    phoneNumberConfirmed = json['phoneNumberConfirmed'];
    twoFactorEnabled = json['twoFactorEnabled'];
    lockoutEnd = json['lockoutEnd'];
    lockoutEnabled = json['lockoutEnabled'];
    accessFailedCount = json['accessFailedCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fristName'] = this.fristName;
    data['lastName'] = this.lastName;
    data['refreshToken'] = this.refreshToken;
    data['refreshTokenExpiryTime'] = this.refreshTokenExpiryTime;
    data['uid'] = this.uid;
    data['deviceInfo'] = this.deviceInfo;
    data['osInfo'] = this.osInfo;
    data['firebaseToken'] = this.firebaseToken;
    data['licensePlate'] = this.licensePlate;
    data['licensExpiredDateTime'] = this.licensExpiredDateTime;
    data['role'] = this.role;
    data['pin'] = this.pin;
    data['isDeleted'] = this.isDeleted;
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedOn'] = this.modifiedOn;
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['normalizedUserName'] = this.normalizedUserName;
    data['email'] = this.email;
    data['normalizedEmail'] = this.normalizedEmail;
    data['emailConfirmed'] = this.emailConfirmed;
    data['passwordHash'] = this.passwordHash;
    data['securityStamp'] = this.securityStamp;
    data['concurrencyStamp'] = this.concurrencyStamp;
    data['phoneNumber'] = this.phoneNumber;
    data['phoneNumberConfirmed'] = this.phoneNumberConfirmed;
    data['twoFactorEnabled'] = this.twoFactorEnabled;
    data['lockoutEnd'] = this.lockoutEnd;
    data['lockoutEnabled'] = this.lockoutEnabled;
    data['accessFailedCount'] = this.accessFailedCount;
    return data;
  }
}
