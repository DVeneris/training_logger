import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/models/enums/enums.dart';
import 'package:training_tracker/models/exercise_set.dart';
import 'package:training_tracker/models/media_item.dart';

class Exercise {
  String? id;
  final String userId;
  final String name;
  final ExerciseGroup exerciseGroup;
  final List<ExerciseSet> sets;
  final WeightUnit unit;
  final String mediaItemId;
  final Equipment equipment;

  Exercise(
      {this.id,
      required this.userId,
      required this.name,
      required this.exerciseGroup,
      required this.unit,
      required this.sets,
      required this.mediaItemId,
      required this.equipment});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'exerciseGroup': exerciseGroup.index,
      'unit': unit.index,
      'sets': sets.map((set) => set.toMap()).toList(),
      'mediaItemId': mediaItemId,
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
        sets: List<Map<String, dynamic>>.from(json['sets'])
            .map((setJson) => ExerciseSet.fromJson(setJson))
            .toList(),
        mediaItemId: json['mediaItemId'],
        equipment: Equipment.values[json['equipment']]);
  }
}
