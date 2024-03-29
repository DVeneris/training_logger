import 'package:flutter/material.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/media-item-dto.dart';
import 'package:training_tracker/models/media_item.dart';
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

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool result) {
    _isLoading = result;
    notifyListeners();
  }

  void setMediaItem(MediaItemDTO mediaItem) {
    _exerciseDTO.mediaItem = mediaItem;
    notifyListeners();
  }
}
