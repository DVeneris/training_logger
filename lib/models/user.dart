class User {
  final String id;
  final String userName;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String createdDate;
  final String? mediaItemId;

  User({
    required this.id,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.createdDate,
    this.mediaItemId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['userName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      createdDate: json['createdDate'],
      mediaItemId: json['mediaItemId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'createdDate': createdDate,
      'mediaItemId': mediaItemId,
    };
  }
}
