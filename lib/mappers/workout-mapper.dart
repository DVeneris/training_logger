import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/workout.dart';

extension ExerciseOptionsMapping on ExerciseOptionsDTO {
  ExerciseOptions toExerciseOptions() {
    return ExerciseOptions(
      time: time,
      note: note,
      unit: exercise.unit,
      exerciseId: exercise.id!,
      sets: exercise.sets,
    );
  }
}

extension ExerciseOptionsDTOMapping on ExerciseOptions {
  ExerciseOptionsDTO toExerciseOptionsDTO(List<ExerciseDTO> exercises) {
    var exercise = exercises.firstWhere((element) => element.id == exerciseId);
    exercise.sets = sets;
    return ExerciseOptionsDTO(
      note: note,
      time: time,
      exercise: exercise,
    );
  }
}

extension WorkoutMapping on WorkoutDTO {
  Workout toModel() {
    return Workout(
      id: id,
      userId: userId,
      name: name,
      note: note,
      createDate: createDate!,
      updateDate: updateDate!,
      exerciseList: exerciseList
          .map((exerciseOptionsDTO) => exerciseOptionsDTO.toExerciseOptions())
          .toList(),
      totalTime: totalTime,
      totalVolume: totalVolume,
    );
  }
}

extension WorkoutDTOMapping on Workout {
  WorkoutDTO toWorkoutDTO(List<ExerciseDTO> exercises) {
    //
    return WorkoutDTO(
      id: id,
      userId: userId,
      name: name,
      note: note ?? "",
      createDate: createDate,
      updateDate: updateDate,
      exerciseList: exerciseList
          .map((options) => options.toExerciseOptionsDTO(exercises))
          .toList(),
      totalTime: totalTime,
      totalVolume: totalVolume,
    );
  }
}

extension WorkoutIterableMapping on Iterable<WorkoutDTO> {
  List<Workout> toModelList() {
    return map((workoutDTO) => workoutDTO.toModel()).toList();
  }
}

extension WorkoutIterableDTOMapping on Iterable<Workout> {
  List<WorkoutDTO> toDtoList(List<ExerciseDTO> exercises) {
    return map((workout) => workout.toWorkoutDTO(exercises)).toList();
  }
}
