import 'package:training_tracker/models/exercise_complete.dart';
import 'package:training_tracker/models/exercise.dart';

class Workout {
  late final String id;
  final String userId;
  final String name;
  final String? note;
  final DateTime createDate;
  //final WorkoutGroup workoutGroup;
  DateTime updateDate;
  List<String> exerciseIds;
  final String totalTime;
  final int totalVolume;

  Workout({
    required this.id,
    required this.userId,
    required this.name,
    this.note,
    required this.createDate,
    required this.updateDate,
    required this.exerciseIds,
    required this.totalTime,
    required this.totalVolume,
  });

  // factory Workout.fromJson(Map<String, dynamic> json) {
  //   var exercises = <Exercise>[];
  //   if (json['exercises'] != null) {
  //     json['exercises'].forEach((exerciseJson) {
  //       exercises.add(Exercise.fromJson(exerciseJson));
  //     });
  //   }
  //   return Workout(
  //     id: json['id'],
  //     userId: json['userId'],
  //     name: json['name'],
  //     note: json['note'],
  //     createDate: DateTime.parse(json['createDate']),
  //     updateDate: DateTime.parse(json['updateDate']),
  //     exercises: exercises,
  //     totalTime: json['totalTime'],
  //     totalVolume: json['totalVolume'],
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   var exercisesJson = <Map<String, dynamic>>[];
  //   exercises.forEach((exercise) {
  //     exercisesJson.add(exercise.toMap());
  //   });
  //   return {
  //     'id': id,
  //     'userId': userId,
  //     'name': name,
  //     'note': note,
  //     'createDate': createDate.toIso8601String(),
  //     'updateDate': updateDate.toIso8601String(),
  //     'exercises': exercisesJson,
  //     'totalTime': totalTime,
  //     'totalVolume': totalVolume,
  //   };
  // }
}
