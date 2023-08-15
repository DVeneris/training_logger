import 'package:training_tracker/DTOS/exercise_options_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/workout_history.dart';

class WorkoutHistoryDTO {
  String? id;
  final String userId;
  final String workoutName;
  final String note;
  final String totalTime;
  final int totalVolume;
  final DateTime? workoutDate;
  List<ExerciseOptionsDTO> exerciseList;

  WorkoutHistoryDTO({
    this.id,
    required this.userId,
    required this.workoutName,
    required this.note,
    required this.totalTime,
    required this.totalVolume,
    required this.workoutDate,
    required this.exerciseList,
  });
}
