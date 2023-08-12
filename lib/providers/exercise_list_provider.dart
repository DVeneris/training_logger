import 'package:flutter/material.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/exercise_service.dart';

class ExerciseListProvider with ChangeNotifier {
  late final ExerciseService _exerciseService;
  late final AuthService _authService;

  ExerciseListProvider(
      AuthService authService, ExerciseService exerciseService) {
    _authService = authService;
    _exerciseService = exerciseService;
  }

  List<ExerciseDTO> _exerciseList = [];
  List<ExerciseDTO> get exerciseList => _exerciseList;

  set exerciseList(List<ExerciseDTO> newList) {
    _exerciseList = newList;
    notifyListeners();
  }

  bool _calledByCreator = false;
  bool get calledByCreator => _calledByCreator;

  set calledByCreator(bool result) {
    _calledByCreator = result;
    notifyListeners();
  }

  Future<List<ExerciseDTO>> getExerciseList() async {
    final user = _authService.getUser();
    final exList = await _exerciseService.getExerciseList(user!.uid, null);
    exerciseList = exList;
    return exList;
  }

  void addToList(ExerciseDTO exerciseDTO) {
    _exerciseList.add(exerciseDTO);
    notifyListeners();
  }
}
