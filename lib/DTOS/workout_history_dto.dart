import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/workout_history.dart';

class WorkoutHistoryDTO {
  String? id;
  final String userId;
  final WorkoutDTO workout;
  final List<WorkoutHistoryExerciseOptions> exerciseOptions;
  final String totalTime;
  final int totalVolume;
  final DateTime? workoutDate;
  WorkoutHistoryDTO({
    this.id,
    required this.userId,
    required this.workout,
    required this.exerciseOptions,
    required this.totalTime,
    required this.totalVolume,
    required this.workoutDate,
  });
}
