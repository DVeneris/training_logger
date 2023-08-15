import 'package:training_tracker/DTOS/media-item-dto.dart';
import 'package:training_tracker/DTOS/user-dto.dart';
import 'package:training_tracker/models/media_item.dart';
import 'package:training_tracker/models/user.dart';

extension ExerciseMapping on AppUser {
  UserDTO toDTO() {
    return UserDTO(
        uid: uid,
        email: email,
        userName: userName,
        createdDate: createdDate,
        // identifier: identifier,
        // provider: provider,
        signinDate: signinDate,
        description: description,
        link: link,
        name: name,
        mediaItem: getMediaItemDTO(mediaItem));
  }

  MediaItemDTO? getMediaItemDTO(MediaItem? mediaItem) {
    if (mediaItem == null) return null;
    return MediaItemDTO(
        id: mediaItem.id,
        name: mediaItem.name,
        url: mediaItem.url,
        userId: mediaItem.userId);
  }
}
