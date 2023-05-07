import 'package:training_tracker/models/enums/enums.dart';
import 'package:training_tracker/models/exercise_set.dart';
import 'package:training_tracker/models/media_item.dart';

class Exercise {
  late final String id;
  final String userId;
  final String name;
  final ExerciseGroup exerciseGroup;
  List<ExerciseSet> sets;
  final WeightUnit unit;
  final String mediaItemId;

  Exercise({
    required this.id,
    required this.userId,
    required this.name,
    required this.exerciseGroup,
    required this.unit,
    required this.sets,
    required this.mediaItemId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'exerciseGroup': exerciseGroup.name,
      'unit': unit.name,
      'sets': sets.map((set) => set.toMap()).toList(),
      'mediaItemId': mediaItemId,
    };
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      exerciseGroup: ExerciseGroup.values[json['exerciseGroup']],
      unit: WeightUnit.values[json['unit']],
      sets: List<Map<String, dynamic>>.from(json['sets'])
          .map((setJson) => ExerciseSet.fromJson(setJson))
          .toList(),
      mediaItemId: json['mediaItemId'],
    );
  }
}
