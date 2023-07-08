import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/models/workout.dart';

class WorkoutDTO {
  String? id;
  String userId;
  String name;
  String note;
  DateTime? createDate;
  DateTime? updateDate;
  List<ExerciseOptionsDTO> exerciseList;
  String totalTime;
  int totalVolume;

  WorkoutDTO({
    this.id,
    required this.userId,
    this.name = "",
    this.note = "",
    this.createDate,
    this.updateDate,
    required this.exerciseList,
    this.totalTime = "",
    this.totalVolume = 0,
  });
}

class ExerciseOptionsDTO {
  int time = 0;
  String note = "";
  ExerciseDTO exercise = ExerciseDTO();
  ExerciseOptionsDTO({this.time = 0, this.note = "", required this.exercise});
}
