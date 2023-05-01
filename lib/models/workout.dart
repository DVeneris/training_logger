import 'package:training_tracker/models/exercise-complete.dart';

class Workout {
  final String id;
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
}
