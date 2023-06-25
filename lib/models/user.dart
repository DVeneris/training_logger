class AppUser {
  final String uid;
  final String? email;
  final String userName;
  final String? identifier;
  final String? provider;
  final DateTime? createdDate;
  final DateTime? signinDate;
  // final String? mediaItemId;

  AppUser({
    required this.uid,
    required this.userName,
    this.email,
    this.identifier,
    this.provider,
    this.createdDate,
    this.signinDate,
  });
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'],
      userName: json['userName'],
      email: json['email'],
      identifier: json['identifier'],
      provider: json['provider'],
      createdDate: json['createdDate'],
      signinDate: json['signinDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'email': email,
      'identifier': identifier,
      'provider': provider,
      'createdDate': createdDate,
      'signinDate': signinDate,
    };
  }
}
