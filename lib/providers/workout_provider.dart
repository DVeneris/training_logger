import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/exercise_options_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/exercise_set.dart';
import 'package:training_tracker/services/workout_service.dart';
import 'package:training_tracker/widgets/workout/exercise_list.dart';

class WorkoutProvider with ChangeNotifier {
  late final WorkoutService _workoutService;

  WorkoutProvider(WorkoutService workoutService) {
    _workoutService = workoutService;
  }
  late WorkoutDTO? _tmpWorkoutDTO;

  late WorkoutDTO? _workoutDTO;
  WorkoutDTO? get workout => _workoutDTO;

  set workout(WorkoutDTO? newWorkout) {
    _workoutDTO = newWorkout;
    notifyListeners();
  }

  List<WorkoutDTO> _workoutList = [];
  List<WorkoutDTO> get workoutList => _workoutList;

  set workoutList(List<WorkoutDTO>? newWorkoutList) {
    _workoutList = newWorkoutList ?? [];
    _workoutIsUnset = true;
    // notifyListeners();
  }

  bool _workoutIsUnset = true;
  bool get workoutIsUnset => _workoutIsUnset;

  set workoutIsUnset(bool? isUnset) {
    _workoutIsUnset = isUnset ?? true;
    notifyListeners();
  }

  void resetWorkout() {
    _workoutDTO = _tmpWorkoutDTO;
  }

  void initWorkout(WorkoutDTO newWorkout) {
    for (var exercise in newWorkout.exerciseList) {
      for (var set in exercise.exercise.currentSets) {
        set.isComplete = false;
      }
    }
    _workoutDTO = newWorkout;
    _tmpWorkoutDTO = _workoutDTO;

    startWorkoutTimer();
  }

  Future<void> deleteWorkout(VoidCallback onSuccess) async {
    if (_workoutDTO == null || _workoutDTO!.id == null) return;
    await _workoutService.deleteWorkout(_workoutDTO!.id!);
    onSuccess.call();
  }

  Future<void> saveAndCreateWorkoutHistory(VoidCallback onSuccess) async {
    if (_workoutDTO == null) return;

    await _workoutService.saveAndCreateWorkoutHistory(
        _workoutDTO!, workoutTime.toString(), totalWeight);
    onSuccess.call();
  }

  Future<void> createWorkoutHistory(VoidCallback onSuccess) async {
    if (_workoutDTO == null) return;
    var exList = _workoutDTO!.exerciseList;
    for (var exercise in _tmpWorkoutDTO!.exerciseList) {
      exList.map((e) {
        if (e.exercise.id == exercise.exercise.id) {
          exercise.exercise.currentSets = e.exercise.currentSets;
          exercise.exercise.previousSets = e.exercise.previousSets;
        }
      });
    }
    _workoutDTO = _tmpWorkoutDTO;
    await _workoutService.saveAndCreateWorkoutHistory(
        _workoutDTO!, workoutTime.toString(), totalWeight);
    onSuccess.call();
  }

  void pushExercise(ExerciseOptionsDTO exerciseDTO) {
    if (_workoutDTO == null) return;

    workout!.exerciseList.add(exerciseDTO);
    notifyListeners();
  }

  void removeExerciseSetAtIndex(ExerciseOptionsDTO exercise, int index) {
    if (_workoutDTO == null) return;

    workout!.exerciseList
        .where((e) => e == exercise)
        .first
        .exercise
        .currentSets
        .removeAt(index);
    notifyListeners();
  }

  void setExerciseSetCheckedAtIndex(
      ExerciseOptionsDTO exercise, int index, bool checked) {
    if (_workoutDTO == null) return;

    workout!.exerciseList
        .where((e) => e == exercise)
        .first
        .exercise
        .currentSets[index]
        .isComplete = checked;
    notifyListeners();
  }

  void addExerciseSet(ExerciseOptionsDTO exercise) {
    if (_workoutDTO == null) return;

    var ex = workout!.exerciseList
        .where((e) => e == exercise)
        .first
        .exercise
        .currentSets;
    ex.add(ExerciseSet());
    notifyListeners();
  }

  void deteteExercise(ExerciseOptionsDTO exerciseDTO) {
    if (_workoutDTO == null) return;

    workout!.exerciseList.remove(exerciseDTO);
    notifyListeners();
  }

  int _calculateTotalSetsAndWeight() {
    var totalWeight = 0;
    for (var e in _workoutDTO!.exerciseList) {
      for (var s in e.exercise.currentSets) {
        if (s.isComplete && s.weight != null) {
          var weight = int.tryParse(s.weight!);
          weight = weight ?? 0;
          var reps = int.tryParse(s.reps!);
          reps = reps ?? 0;
          var volume = weight * reps;
          totalWeight = totalWeight + volume;
        }
      }
    }

    return totalWeight;
  }

  int workoutTime = 0;
  int totalWeight = 0;
  int remainingTime = 10; //initial time in seconds
  late Timer _providerTimer;
  late Timer _workoutDurationTimer;
  bool isRunning = false;

  void checkExercise() {
    startCountdown();
    totalWeight = _calculateTotalSetsAndWeight();
  }

  void startWorkoutTimer() {
    workoutTime = 0;

    _workoutDurationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      workoutTime++;
      notifyListeners();
    });
  }

  void stopWorkoutTimer() {
    _workoutDurationTimer.cancel();
  }

  void startTimer() {
    remainingTime = 10;
    isRunning = true;
    _providerTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
      } else {
        _providerTimer.cancel();
        isRunning = false;
      }
      notifyListeners();
    });
  }

  void startCountdown() {
    if (isRunning) {
      _cancelTimer();
    }
    startTimer();
  }

  void stopTimer() {
    isRunning = false;
    _providerTimer.cancel();
  }

  void _cancelTimer() {
    isRunning = false;
    remainingTime = 10;

    _providerTimer.cancel();
  }
}
