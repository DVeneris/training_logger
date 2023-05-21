import 'package:training_tracker/models/exercise_set.dart';

class WorkoutHistory {
  String? id;
  final String workoutId;
  final String workoutName;
  final List<WorkoutHistoryExerciseOptions> exerciseOptions;

  WorkoutHistory(
    this.id,
    this.workoutId,
    this.workoutName,
    this.exerciseOptions,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'workoutId': workoutId,
      'workoutName': workoutName,
      'exerciseOptions': exerciseOptions
          .map((exerciseOption) => exerciseOption.toMap())
          .toList(),
    };
  }

  factory WorkoutHistory.fromJson(Map<String, dynamic> json, String id) {
    return WorkoutHistory(
      id,
      json['workoutId'],
      json['workoutName'],
      List<Map<String, dynamic>>.from(json['exerciseOptions'])
          .map((exerciseOptionJson) =>
              WorkoutHistoryExerciseOptions.fromJson(exerciseOptionJson))
          .toList(),
    );
  }
}

class WorkoutHistoryExerciseOptions {
  final String id;
  final String name;
  final List<ExerciseSet> currentSets;
  final List<ExerciseSet> previousSets;

  WorkoutHistoryExerciseOptions(
    this.id,
    this.name,
    this.currentSets,
    this.previousSets,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'currentSets': currentSets.map((set) => set.toMap()).toList(),
      'previousSets': previousSets.map((set) => set.toMap()).toList(),
    };
  }

  factory WorkoutHistoryExerciseOptions.fromJson(Map<String, dynamic> json) {
    return WorkoutHistoryExerciseOptions(
      json['id'],
      json['name'],
      List<Map<String, dynamic>>.from(json['currentSets'])
          .map((setJson) => ExerciseSet.fromJson(setJson))
          .toList(),
      List<Map<String, dynamic>>.from(json['previousSets'])
          .map((setJson) => ExerciseSet.fromJson(setJson))
          .toList(),
    );
  }
}
