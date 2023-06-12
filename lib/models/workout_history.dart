import 'package:training_tracker/models/exercise_set.dart';

class WorkoutHistory {
  String? id;
  final String userId;
  final String workoutId;
  final String workoutName;
  final List<WorkoutHistoryExerciseOptions> exerciseOptions;

  WorkoutHistory({
    this.id,
    required this.userId,
    required this.workoutId,
    required this.workoutName,
    required this.exerciseOptions,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'workoutId': workoutId,
      'workoutName': workoutName,
      'exerciseOptions': exerciseOptions
          .map((exerciseOption) => exerciseOption.toMap())
          .toList(),
    };
  }

  factory WorkoutHistory.fromJson(Map<String, dynamic> json, String id) {
    return WorkoutHistory(
      id: id,
      userId: json['userId'],
      workoutId: json['workoutId'],
      workoutName: json['workoutName'],
      exerciseOptions: List<Map<String, dynamic>>.from(json['exerciseOptions'])
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

  WorkoutHistoryExerciseOptions({
    required this.id,
    required this.name,
    required this.currentSets,
    required this.previousSets,
  });

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
      id: json['id'],
      name: json['name'],
      currentSets: List<Map<String, dynamic>>.from(json['currentSets'])
          .map((setJson) => ExerciseSet.fromJson(setJson))
          .toList(),
      previousSets: List<Map<String, dynamic>>.from(json['previousSets'])
          .map((setJson) => ExerciseSet.fromJson(setJson))
          .toList(),
    );
  }
}
