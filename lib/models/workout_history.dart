import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_tracker/models/exercise_set.dart';

class WorkoutHistory {
  String? id;
  final String userId;
  final String workoutId;
  // final String workoutName;
  final List<WorkoutHistoryExerciseOptions> exerciseOptions;
  final String totalTime;
  final int totalVolume;
  final DateTime? workoutDate;
  WorkoutHistory({
    this.id,
    required this.userId,
    required this.workoutId,
    // required this.workoutName,
    required this.exerciseOptions,
    required this.totalTime,
    required this.totalVolume,
    required this.workoutDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'workoutId': workoutId,
      // 'workoutName': workoutName,
      'totalTime': totalTime,
      'totalVolume': totalVolume,
      'workoutDate': workoutDate,
      'exerciseOptions': exerciseOptions
          .map((exerciseOption) => exerciseOption.toMap())
          .toList(),
    };
  }

  factory WorkoutHistory.fromJson(Map<String, dynamic> json, String id) {
    var dateTime = null;
    var date = json['workoutDate'];
    if (date != null) {
      var timestamp = date as Timestamp;
      dateTime = timestamp.toDate();
    }
    return WorkoutHistory(
      id: id,
      userId: json['userId'],
      workoutId: json['workoutId'],
      totalVolume: json['totalVolume'] ?? 0,
      totalTime: json['totalTime'] ?? "",
      // workoutName: json['workoutName'],
      workoutDate: dateTime,
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
