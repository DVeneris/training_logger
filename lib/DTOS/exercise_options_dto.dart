import 'package:training_tracker/DTOS/exercise_dto.dart';

class ExerciseOptionsDTO {
  int time = 0;
  String note = "";
  ExerciseDTO exercise = ExerciseDTO();
  ExerciseOptionsDTO({this.time = 0, this.note = "", required this.exercise});
  factory ExerciseOptionsDTO.fromJson(Map<String, dynamic> json) {
    return ExerciseOptionsDTO(
      time: json['time'] as int,
      note: json['note'] as String,
      exercise: ExerciseDTO.fromJson(
        json['exercise'],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'note': note,
      'exercise': exercise.toMap(),
    };
  }
}
