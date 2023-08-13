import 'package:flutter/material.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/DTOS/workout_history_dto.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/exercise_service.dart';
import 'package:training_tracker/services/workout_history_service.dart';

class WorkoutHistoryProvider with ChangeNotifier {
  late final WorkoutHistoryService _workoutHistoryService;
  late final AuthService _authService;
  late final ExerciseService _exerciseService;

  WorkoutHistoryProvider(
      AuthService authService,
      WorkoutHistoryService workoutHistoryService,
      ExerciseService exerciseService) {
    _authService = authService;
    _workoutHistoryService = workoutHistoryService;
    _exerciseService = exerciseService;
  }

  // List<WorkoutHistoryDTO> _workoutHistoryList = [];
  // List<WorkoutHistoryDTO> get workoutHistoryList => _workoutHistoryList;

  // set exerciseList(List<ExerciseDTO> newList) {
  //   _exerciseList = newList;
  //   notifyListeners();
  // }

  // bool _calledByCreator = false;
  // bool get calledByCreator => _calledByCreator;

  // set calledByCreator(bool result) {
  //   _calledByCreator = result;
  //   notifyListeners();
  // }

  Future<List<WorkoutHistoryDTO>> getWorkoutHistoryList() async {
    final user = _authService.getUser();
    final wList = await _workoutHistoryService.getWorkoutHistoryList(user!.uid);
    return wList;
  }

  // Future<WorkoutDTO> calculateWorkoutDto(WorkoutHistoryDTO historyDTO) async {
  //   final user = _authService.getUser();

  //   var exerciseIds =  historyDTO.exerciseOptions.map((opt) => opt.id).toList();
  //   var exerciseList = await _exerciseService.getExerciseList(user!.uid, exerciseIds);

  //   var exerciseOptions = ExerciseOptionsDTO(exercise: exercise, note:"", time: historyDTO.exerciseOptions. )
  // }
}
