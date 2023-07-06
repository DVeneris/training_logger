import 'package:training_tracker/models/media_item.dart';

class UserDTO {
  final String uid;
  final String? email;
  final String userName;
  final String? identifier;
  final String? provider;
  String? name;
  String? description;
  String? link;
  final DateTime? createdDate;
  final DateTime? signinDate;
  final MediaItem? mediaItem;
  UserDTO(
      {required this.uid,
      required this.userName,
      this.email,
      this.identifier,
      this.provider,
      this.createdDate,
      this.signinDate,
      this.description,
      this.link,
      this.name,
      this.mediaItem});
}
