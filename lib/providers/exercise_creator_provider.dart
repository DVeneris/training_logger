import 'package:flutter/material.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/exercise_service.dart';

class ExerciseCreatorProvider with ChangeNotifier {
  late final ExerciseService _exerciseService;

  ExerciseCreatorProvider(ExerciseService exerciseService) {
    _exerciseService = exerciseService;
  }

  late ExerciseDTO _exerciseDTO;
  ExerciseDTO get exercise => _exerciseDTO;

  set exercise(ExerciseDTO newExercise) {
    _exerciseDTO = newExercise;
    notifyListeners();
  }

  Future<void> createExercise(VoidCallback onSuccess) async {
    await _exerciseService.createExercise(exercise);
    onSuccess.call();
  }
}
