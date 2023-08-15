import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_tracker/models/media_item.dart';
import 'package:training_tracker/services/auth.dart';

class AppUser {
  final String uid;
  final String? email;
  final String userName;
  // final String? identifier;
  // final String? provider;
  final DateTime? createdDate;
  final DateTime? signinDate;
  final String? name;
  final String? description;
  final String? link;
  final MediaItem? mediaItem;

  AppUser(
      {required this.uid,
      required this.userName,
      this.email,
      // this.identifier,
      // this.provider,
      this.createdDate,
      this.signinDate,
      this.description,
      this.link,
      this.name,
      this.mediaItem});
  factory AppUser.fromJson(Map<String, dynamic> json) {
    var uid = json['uid'];
    if (uid == null) {
      AuthService().signOut();
      throw Exception(); //todo
    }
    DateTime createdDateTime = DateTime.now();
    var createdDate = json['createdDate'];
    if (createdDate != null) {
      var timestamp = createdDate as Timestamp;
      createdDateTime = timestamp.toDate();
    }
    DateTime signinDateTime = DateTime.now();
    var signinDate = json['signinDate'];
    if (signinDate != null) {
      var timestamp = signinDate as Timestamp;
      signinDateTime = timestamp.toDate();
    }
    return AppUser(
      uid: json['uid'],
      userName: json['userName'],
      email: json['email'],
      // identifier: json['identifier'],
      // provider: json['provider'],
      createdDate: createdDateTime,
      signinDate: signinDateTime,
      name: json['name'],
      link: json['link'],
      description: json['description'],
      mediaItem: json['mediaItem'] != null
          ? MediaItem.fromJson(json['mediaItem'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'email': email,
      // 'identifier': identifier,
      // 'provider': provider,
      'createdDate': createdDate,
      'signinDate': signinDate,
      'name': name,
      'link': link,
      'description': description,
      'mediaItem': mediaItem?.toMap(),
    };
  }
}
