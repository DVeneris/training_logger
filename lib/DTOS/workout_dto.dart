import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/models/workout.dart';

class WorkoutDTO {
  String? id;
  String userId;
  String name;
  String note;
  DateTime? createDate;
  DateTime? updateDate;
  List<ExerciseDTO> exerciseList;
  Map<ExerciseOptions, List<ExerciseDTO>> dd;
  String totalTime;
  int totalVolume;

  WorkoutDTO({
    this.id,
    required this.userId,
    this.name = "",
    this.note = "",
    this.createDate,
    this.updateDate,
    this.exerciseList = const [],
    this.totalTime = "",
    this.totalVolume = 0,
  });
}

extension WorkoutDTOMapping on WorkoutDTO {
  Workout toModel() {
    return Workout(
      id: id,
      userId: userId,
      name: name,
      note: note,
      createDate: createDate!,
      updateDate: updateDate!,
      exerciseIds: exerciseList.map((e) => e.id!).toList(), //des to '!'
      totalTime: totalTime,
      totalVolume: totalVolume,
    );
  }
}

//exerciseList.map((exerciseDTO) => exerciseDTO.toExercise().id!).toList()
class ExerciseOptions {
  //time
  //note
}
