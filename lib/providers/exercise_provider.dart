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
    notifyListeners();
  }

  bool _workoutIsUnset = true;
  bool get workoutIsUnset => _workoutIsUnset;

  set workoutIsUnset(bool? isUnset) {
    _workoutIsUnset = isUnset ?? true;
    notifyListeners();
  }

  int _calculateTotalSetsAndWeight() {
    var totalWeight = 0;
    for (var e in workout.exerciseList) {
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

  int _workoutTime = 0;
  int _totalWeight = 0;
  int _remainingTime = 10; //initial time in seconds
  late Timer _timer;
  late Timer _workoutDurationTimer;
  bool _isRunning = false;

  void _startWorkoutTimer() {
    _workoutTime = 0;

    _workoutDurationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _workoutTime++;
    });
  }

  void _startTimer() {
    _remainingTime = 10;
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
      } else {
        _timer.cancel();
        _isRunning = false;
      }
    });
  }

  void _startCountdown() {
    if (_isRunning) {
      _cancelTimer();
    }
    _startTimer();
  }

  void _stopTimer() {
    _isRunning = false;
    _timer.cancel();
  }

  void _cancelTimer() {
    _isRunning = false;
    _remainingTime = 10;

    _timer.cancel();
  }
}
