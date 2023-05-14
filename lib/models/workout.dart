import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/exercise_complete.dart';
import 'package:training_tracker/models/exercise.dart';

class Workout {
  String? id;
  final String userId;
  final String name;
  final String? note;
  final DateTime createDate;
  final DateTime updateDate;
  final List<String> exerciseIds;
  final String totalTime;
  final int totalVolume;

  Workout({
    this.id,
    required this.userId,
    required this.name,
    this.note,
    required this.createDate,
    required this.updateDate,
    required this.exerciseIds,
    required this.totalTime,
    required this.totalVolume,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'note': note,
      'createDate': createDate.toIso8601String(),
      'updateDate': updateDate.toIso8601String(),
      'exerciseIds': exerciseIds,
      'totalTime': totalTime,
      'totalVolume': totalVolume,
    };
  }

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      note: json['note'],
      createDate: DateTime.parse(json['createDate']),
      updateDate: DateTime.parse(json['updateDate']),
      exerciseIds: List<String>.from(json['exerciseIds']),
      totalTime: json['totalTime'],
      totalVolume: json['totalVolume'],
    );
  }
}

extension WorkoutMapping on Workout {
  WorkoutDTO toDTO() {
    return WorkoutDTO(
      id: id,
      userId: userId,
      name: name,
      note: note ?? '',
      createDate: createDate,
      updateDate: updateDate,
      // exerciseList: exerciseIds.map((exerciseId) => Exercise(id: exerciseId).toDTO()).toList(),
      totalTime: totalTime,
      totalVolume: totalVolume,
    );
  }
}
