import 'package:training_tracker/models/media_item.dart';

class UserProfileDTO {
  String? name;
  String? description;
  String? link;
  MediaItem? mediaItem;

  // final MediaItem? mediaItemId;
  UserProfileDTO({this.description, this.link, this.name, this.mediaItem});
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'link': link,
      'description': description,
      'mediaItem': mediaItem?.toMap(),
    };
  }
}
