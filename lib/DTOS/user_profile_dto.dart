import 'package:training_tracker/models/media_item.dart';

class UserProfileDTO {
  String? name;
  String? description;
  String? link;
  String? userName;
  MediaItem? mediaItem;

  // final MediaItem? mediaItemId;
  UserProfileDTO(
      {this.description, this.link, this.name, this.userName, this.mediaItem});
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'link': link,
      'username': userName,
      'description': description,
      'mediaItem': mediaItem?.toMap(),
    };
  }
}
