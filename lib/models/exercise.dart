import 'package:training_tracker/models/exercise-set.dart';
import 'package:training_tracker/models/media-item.dart';

class Exercise {
  late final String id;
  final String? userId;
  final String name;
  final String exerciseGroup;
  List<ExerciseSet> sets;
  final MediaItem mediaItem;

  Exercise({
    required this.id,
    this.userId,
    required this.name,
    required this.exerciseGroup,
    required this.sets,
    MediaItem? mediaItem,
  }) : mediaItem = mediaItem ?? MediaItem();
  factory Exercise.fromJson(Map<String, dynamic> json) {
    var sets = <ExerciseSet>[];
    if (json['sets'] != null) {
      json['sets'].forEach((setJson) {
        sets.add(ExerciseSet.fromJson(setJson));
      });
    }
    return Exercise(
      id: json['id'],
      userId: json['userId'],
      sets: sets,
      name: json['name'],
      exerciseGroup: json['exerciseGroup'],
      mediaItem: json['mediaItem'] != null
          ? MediaItem.fromJson(json['mediaItem'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    var setsJson = <Map<String, dynamic>>[];
    sets.forEach((set) {
      setsJson.add(set.toMap());
    });
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'sets': setsJson,
      'exerciseGroup': exerciseGroup,
      'mediaItem': mediaItem.toMap(),
    };
  }
}
