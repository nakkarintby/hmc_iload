class Driver {
  String? firstName;
  String? lastName;
  String? refreshToken;
  String? refreshTokenExpiryTime;
  String? uid;
  String? deviceInfo;
  String? osInfo;
  String? firebaseToken;
  String? licenseExpiredDate;
  String? role;
  String? pin;
  bool? isDeleted;
  String? createdBy;
  String? createdTime;
  String? modifiedBy;
  String? modifiedTime;
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

  Driver(
      {this.firstName,
      this.lastName,
      this.refreshToken,
      this.refreshTokenExpiryTime,
      this.uid,
      this.deviceInfo,
      this.osInfo,
      this.firebaseToken,
      this.licenseExpiredDate,
      this.role,
      this.pin,
      this.isDeleted,
      this.createdBy,
      this.createdTime,
      this.modifiedBy,
      this.modifiedTime,
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

  Driver.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    refreshToken = json['refreshToken'];
    refreshTokenExpiryTime = json['refreshTokenExpiryTime'];
    uid = json['uid'];
    deviceInfo = json['deviceInfo'];
    osInfo = json['osInfo'];
    firebaseToken = json['firebaseToken'];
    licenseExpiredDate = json['licenseExpiredDate'];
    role = json['role'];
    pin = json['pin'];
    isDeleted = json['isDeleted'];
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    modifiedBy = json['modifiedBy'];
    modifiedTime = json['modifiedTime'];
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
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['refreshToken'] = this.refreshToken;
    data['refreshTokenExpiryTime'] = this.refreshTokenExpiryTime;
    data['uid'] = this.uid;
    data['deviceInfo'] = this.deviceInfo;
    data['osInfo'] = this.osInfo;
    data['firebaseToken'] = this.firebaseToken;
    data['licenseExpiredDate'] = this.licenseExpiredDate;
    data['role'] = this.role;
    data['pin'] = this.pin;
    data['isDeleted'] = this.isDeleted;
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedTime'] = this.modifiedTime;
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
