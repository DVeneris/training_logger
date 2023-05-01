import 'package:training_tracker/models/media-item.dart';

class Exercise {
  final String id;
  String name;
  String exerciseGroup;
  MediaItem mediaItem;

  Exercise({
    required this.id,
    required this.name,
    required this.exerciseGroup,
    MediaItem? mediaItem,
  }) : mediaItem = mediaItem ?? MediaItem();
}
