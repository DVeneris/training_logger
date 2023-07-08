import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/models/enums/enums.dart';
import 'package:training_tracker/models/exercise_set.dart';
import 'package:training_tracker/models/media_item.dart';

class Exercise {
  String? id;
  final String userId;
  final String name;
  final ExerciseGroup exerciseGroup;
  final List<ExerciseSet> currentSets;
  final List<ExerciseSet> previousSets;
  final WeightUnit unit;
  final MediaItem? mediaItem;
  final Equipment equipment;

  Exercise(
      {this.id,
      required this.userId,
      required this.name,
      required this.exerciseGroup,
      required this.unit,
      required this.currentSets,
      required this.previousSets,
      required this.mediaItem,
      required this.equipment});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'exerciseGroup': exerciseGroup.index,
      'unit': unit.index,
      'previousSets': previousSets.map((set) => set.toMap()).toList(),
      'currentSets': currentSets.map((set) => set.toMap()).toList(),
      'mediaItem': mediaItem?.toMap(),
      'equipment': equipment.index
    };
  }

  factory Exercise.fromJson(Map<String, dynamic> json, String id) {
    return Exercise(
        id: id,
        userId: json['userId'],
        name: json['name'],
        exerciseGroup: ExerciseGroup.values[json['exerciseGroup']],
        unit: WeightUnit.values[json['unit']],
        currentSets: json['currentSets'] == null
            ? []
            : List<Map<String, dynamic>>.from(json['currentSets'])
                .map((setJson) => ExerciseSet.fromJson(setJson))
                .toList(),
        previousSets: json['previousSets'] == null
            ? []
            : List<Map<String, dynamic>>.from(json['previousSets'])
                .map((setJson) => ExerciseSet.fromJson(setJson))
                .toList(),
        mediaItem: json['mediaItem'] != null
            ? MediaItem.fromJson(json['mediaItem'])
            : null,
        equipment: Equipment.values[json['equipment']]);
  }
}
