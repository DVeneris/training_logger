import 'dart:async';

import 'package:flutter/material.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/widgets/workout/exercise_list.dart';

class ExerciseProvider with ChangeNotifier {
  late ExerciseDTO _exerciseDTO;
  ExerciseDTO get exercise => _exerciseDTO;

  set exercise(ExerciseDTO newExercise) {
    _exerciseDTO = newExercise;
    notifyListeners();
  }

  List<ExerciseDTO> _exerciseList = [];
  List<ExerciseDTO> get exerciseList => _exerciseList;

  set excerciseList(List<ExerciseDTO> newExerciseList) {
    _exerciseList = newExerciseList;
    notifyListeners();
  }

  late WorkoutDTO _workoutDTO;
  WorkoutDTO get workout => _workoutDTO;

  set workout(WorkoutDTO newWorkout) {
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

  int _calculateTotalSetsAndWeight() {
    var totalWeight = 0;
    for (var e in _workoutDTO.exerciseList) {
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
  late Timer providerTimer;
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
    });
  }

  void startTimer() {
    remainingTime = 10;
    isRunning = true;
    providerTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
      } else {
        providerTimer.cancel();
        isRunning = false;
      }
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
    providerTimer.cancel();
  }

  void _cancelTimer() {
    isRunning = false;
    remainingTime = 10;

    providerTimer.cancel();
  }
}
