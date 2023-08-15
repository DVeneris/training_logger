import 'package:flutter/material.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/exercise_options_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/enums/enums.dart';
import 'package:training_tracker/models/exercise_set.dart';
import 'package:training_tracker/models/workout.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/exercise_service.dart';
import 'package:training_tracker/services/workout_service.dart';

class WorkoutCreatorProvider with ChangeNotifier {
  late final WorkoutService _workoutService;

  WorkoutCreatorProvider(WorkoutService workoutService) {
    _workoutService = workoutService;
  }

  late WorkoutDTO _tmpWorkoutDTO;
  late WorkoutDTO _workoutDTO;
  WorkoutDTO get workout => _workoutDTO;

  set workout(WorkoutDTO newWorkout) {
    _workoutDTO = newWorkout;
    notifyListeners();
  }

  late WorkoutCreatorOperationMode _operationMode;
  WorkoutCreatorOperationMode get operationMode => _operationMode;

  set operationMode(WorkoutCreatorOperationMode mode) {
    _operationMode = mode;
  }

  Future<void> createWorkout(VoidCallback onSuccess) async {
    _workoutDTO = await _workoutService.createWorkout(workout);
    onSuccess.call();
  }

  void initWorkout(WorkoutDTO newWorkout) {
    _workoutDTO = newWorkout;
    _tmpWorkoutDTO = _workoutDTO;
  }

  void resetWorkout() {
    _workoutDTO = _tmpWorkoutDTO;
  }

  Future<void> updateWorkout(VoidCallback onSuccess) async {
    await _workoutService.editWorkout(workout);
    onSuccess.call();
  }

  void pushExercise(ExerciseOptionsDTO exerciseDTO) {
    workout.exerciseList.add(exerciseDTO);
    notifyListeners();
  }

  void removeExerciseSetAtIndex(ExerciseOptionsDTO exercise, int index) {
    workout.exerciseList
        .where((e) => e == exercise)
        .first
        .exercise
        .currentSets
        .removeAt(index);
    notifyListeners();
  }

  void setExerciseSetCheckedAtIndex(
      ExerciseOptionsDTO exercise, int index, bool checked) {
    workout.exerciseList
        .where((e) => e == exercise)
        .first
        .exercise
        .currentSets[index]
        .isComplete = checked;
    notifyListeners();
  }

  void addExerciseSet(ExerciseOptionsDTO exercise) {
    workout.exerciseList
        .where((e) => e == exercise)
        .first
        .exercise
        .currentSets
        .add(ExerciseSet());
    notifyListeners();
  }

  void deteteExercise(ExerciseOptionsDTO exerciseDTO) {
    workout.exerciseList.remove(exerciseDTO);
    notifyListeners();
  }

  void pushWorkout() {
    var newWorkout = WorkoutDTO(
      name: "",
      createDate: DateTime.now(),
      updateDate: DateTime.now(),
      exerciseList: [],
    );
    workout = newWorkout;
    _tmpWorkoutDTO = _workoutDTO;
  }
}
