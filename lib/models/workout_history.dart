import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_tracker/DTOS/exercise_options_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/exercise_set.dart';
import 'package:training_tracker/models/workout.dart';

class WorkoutHistory {
  String? id;
  final String userId;
  final String workoutName;
  final String note;
  final String totalTime;
  final int totalVolume;
  final DateTime? workoutDate;
  List<ExerciseOptionsDTO> exerciseList;

  WorkoutHistory({
    this.id,
    required this.userId,
    required this.workoutName,
    required this.note,
    required this.totalTime,
    required this.totalVolume,
    required this.workoutDate,
    required this.exerciseList,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'workoutName': workoutName,
      'note': note,
      'totalTime': totalTime,
      'totalVolume': totalVolume,
      'workoutDate': workoutDate?.toIso8601String(),
      'exerciseList':
          exerciseList.map((exerciseOption) => exerciseOption.toMap()).toList(),
    };
  }

  factory WorkoutHistory.fromJson(Map<String, dynamic> json, String id) {
    return WorkoutHistory(
      id: id,
      userId: json['userId'],
      workoutName: json['workoutName'],
      note: json['note'],
      totalTime: json['totalTime'],
      totalVolume: json['totalVolume'],
      workoutDate: json['workoutDate'] != null
          ? DateTime.parse(json['workoutDate'])
          : null,
      exerciseList: List<Map<String, dynamic>>.from(json['exerciseList'])
          .map((exerciseJson) => ExerciseOptionsDTO.fromJson(exerciseJson))
          .toList(),
    );
  }
}
