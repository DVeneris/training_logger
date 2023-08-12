import 'package:flutter/material.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/workout.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/exercise_service.dart';
import 'package:training_tracker/services/workout_service.dart';

class WorkoutTemplateListProvider with ChangeNotifier {
  late final WorkoutService _workoutService;
  late final AuthService _authService;

  WorkoutTemplateListProvider(
      AuthService authService, WorkoutService workoutService) {
    _authService = authService;
    _workoutService = workoutService;
  }

  List<WorkoutDTO> _workoutList = [];
  List<WorkoutDTO> get workoutList => _workoutList;

  set workoutList(List<WorkoutDTO> newList) {
    _workoutList = newList;
    notifyListeners();
  }

  Future<List<WorkoutDTO>> getWorkoutList() async {
    final user = _authService.getUser();
    final wList = await _workoutService.getWorkoutList(userId: user!.uid);
    workoutList = wList;
    return wList;
  }

  void addToList(WorkoutDTO workoutDTO) {
    _workoutList.add(workoutDTO);
    notifyListeners();
  }
}
