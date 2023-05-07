import 'package:training_tracker/DTOS/exercise_dto.dart';

class WorkoutDTO {
  late final String id;
  final String userId;
  final String name;
  final String? note;
  final DateTime createDate;
  //final WorkoutGroup workoutGroup;
  DateTime updateDate;
  List<ExerciseDTO> exerciseList;
  final String totalTime;
  final int totalVolume;

  WorkoutDTO({
    required this.id,
    required this.userId,
    required this.name,
    this.note,
    required this.createDate,
    required this.updateDate,
    required this.exerciseList,
    required this.totalTime,
    required this.totalVolume,
  });
}
