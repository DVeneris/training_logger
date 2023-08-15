import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/exercise_options_dto.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/models/workout.dart';

class WorkoutDTO {
  String? id;
  String? userId;
  String name;
  String note;
  DateTime? createDate;
  DateTime? updateDate;
  List<ExerciseOptionsDTO> exerciseList;

  WorkoutDTO({
    this.id,
    this.userId,
    this.name = "",
    this.note = "",
    this.createDate,
    this.updateDate,
    required this.exerciseList,
  });
}
