import 'package:training_tracker/models/media_item.dart';

class UserDTO {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String email;
  final DateTime? createdDate;
  final MediaItem? mediaItemId;

  UserDTO(
      {this.id,
      this.firstName,
      this.lastName,
      required this.email,
      this.createdDate,
      this.mediaItemId});
}
