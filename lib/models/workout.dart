import 'package:training_tracker/models/exercise-complete.dart';

class Workout {
  late final String id;
  final String name;
  final String? note;
  final DateTime createDate;
  DateTime updateDate;
  List<ExerciseComplete> exercises;
  final String totalTime;
  final int totalVolume;

  Workout({
    required this.id,
    required this.name,
    this.note,
    required this.createDate,
    required this.updateDate,
    required this.exercises,
    required this.totalTime,
    required this.totalVolume,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    var exercises = <ExerciseComplete>[];
    if (json['exercises'] != null) {
      json['exercises'].forEach((exerciseJson) {
        exercises.add(ExerciseComplete.fromJson(exerciseJson));
      });
    }
    return Workout(
      id: json['id'],
      name: json['name'],
      note: json['note'],
      createDate: DateTime.parse(json['createDate']),
      updateDate: DateTime.parse(json['updateDate']),
      exercises: exercises,
      totalTime: json['totalTime'],
      totalVolume: json['totalVolume'],
    );
  }

  Map<String, dynamic> toMap() {
    var exercisesJson = <Map<String, dynamic>>[];
    exercises.forEach((exercise) {
      exercisesJson.add(exercise.toMap());
    });
    return {
      'id': id,
      'name': name,
      'note': note,
      'createDate': createDate.toIso8601String(),
      'updateDate': updateDate.toIso8601String(),
      'exercises': exercisesJson,
      'totalTime': totalTime,
      'totalVolume': totalVolume,
    };
  }
}
