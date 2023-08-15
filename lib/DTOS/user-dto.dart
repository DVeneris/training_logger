import 'package:training_tracker/DTOS/media-item-dto.dart';
import 'package:training_tracker/models/media_item.dart';

class UserDTO {
  final String uid;
  final String? email;
  final String userName;
  // final String? identifier;
  // final String? provider;
  String? name;
  String? description;
  String? link;
  DateTime? createdDate;
  DateTime? signinDate;
  MediaItemDTO? mediaItem;
  UserDTO(
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
}
