import 'package:training_tracker/models/media-item.dart';

class Exercise {
  late final String id;
  String name;
  String exerciseGroup;
  MediaItem mediaItem;

  Exercise({
    required this.id,
    required this.name,
    required this.exerciseGroup,
    MediaItem? mediaItem,
  }) : mediaItem = mediaItem ?? MediaItem();
  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      name: json['name'],
      exerciseGroup: json['exerciseGroup'],
      mediaItem: json['mediaItem'] != null
          ? MediaItem.fromJson(json['mediaItem'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'exerciseGroup': exerciseGroup,
      'mediaItem': mediaItem.toMap(),
    };
  }
}
