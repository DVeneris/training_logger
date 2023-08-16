import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/exercise_options_dto.dart';
import 'package:training_tracker/DTOS/media-item-dto.dart';
import 'package:training_tracker/DTOS/user-dto.dart';
import 'package:training_tracker/DTOS/user_profile_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/enums/enums.dart';
import 'package:training_tracker/models/media_item.dart';
import 'package:training_tracker/models/user.dart';
import 'package:training_tracker/models/workout.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/exercise_service.dart';
import 'package:training_tracker/services/user-service.dart';
import 'package:training_tracker/services/workout_service.dart';

class UserProvider with ChangeNotifier {
  late final AuthService _authService;
  late final UserService _userService;
  UserProvider(AuthService authService, UserService userService) {
    _authService = authService;
    _userService = userService;
  }

  UserDTO? _user;
  UserDTO? get user => _user;
  set user(UserDTO? newUser) {
    _user = newUser;
    notifyListeners();
  }

  void removeUser() {
    _user = null;
  }

  void setMediaItem(MediaItemDTO mediaItem) {
    _userProfile.mediaItem = mediaItem;
    notifyListeners();
  }

  late UserProfileDTO _userProfile;
  UserProfileDTO get userProfile => _userProfile;
  set userProfile(UserProfileDTO newUser) {
    _userProfile = newUser;
    notifyListeners();
  }

  late bool _userExists;
  bool get userExists => _userExists;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  set isSaving(bool result) {
    _isSaving = result;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool result) {
    _isLoading = result;
    notifyListeners();
  }

  Future<void> anonLoginUser(VoidCallback onSuccess) async {
    await _authService.anonLogin();
    var userName = "user_${getRandomString(6)}";
    var authUser =
        await _userService.createUser(userName); //check for empty user
    _user = authUser!;
    await _initStartingData();
    onSuccess();

    notifyListeners();
  }

  Future<void> checkIfUserExist(String username) async {
    var userExists = await _userService.checkIfUserExists(username);
    _userExists = userExists;
    notifyListeners();
  }

  String getRandomString(int length) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  Future<void> updateUser() async {
    isSaving = true;
    await _userService.updateUser(userProfile);
    isSaving = false;
  }

  Future<UserDTO?> getCurrentUser() async {
    try {
      if (_user != null) return _user!;
      user = await _userService.getCurrentUser();
      return _user!;
    } on Exception catch (e) {
      return null;
    }
  }

  Stream<User?> getUserStream() {
    return _authService.getUserStream();
  }

  Future<void> _initStartingData() async {
    var exerciseList = <ExerciseDTO>[
      ExerciseDTO(
          currentSets: [],
          previousSets: [],
          unit: WeightUnit.kg,
          equipment: Equipment.mashine,
          exerciseGroup: ExerciseGroup.quadriceps,
          name: "Leg Press",
          mediaItem: MediaItemDTO(
              id: "37c4c4e6-2605-4d0b-8466-663a70ced97d",
              name: "37c4c4e6-2605-4d0b-8466-663a70ced97d",
              userId: _user!.uid,
              url:
                  "https://firebasestorage.googleapis.com/v0/b/workout-logger-dveneris.appspot.com/o/V67cvCm6ULOKBSO4levXbl8rwLD3%2F37c4c4e6-2605-4d0b-8466-663a70ced97d.png?alt=media&token=9cf94107-6749-429f-83fa-0358a1afc8b1")),
      ExerciseDTO(
          currentSets: [],
          previousSets: [],
          unit: WeightUnit.kg,
          equipment: Equipment.mashine,
          exerciseGroup: ExerciseGroup.glutes,
          name: "Leg Curl",
          mediaItem: MediaItemDTO(
              id: "70c6d7f5-84de-432a-9a65-1fc2460f26b2",
              name: "70c6d7f5-84de-432a-9a65-1fc2460f26b2",
              userId: _user!.uid,
              url:
                  "https://firebasestorage.googleapis.com/v0/b/workout-logger-dveneris.appspot.com/o/V67cvCm6ULOKBSO4levXbl8rwLD3%2F70c6d7f5-84de-432a-9a65-1fc2460f26b2.png?alt=media&token=d33c7812-3f71-4187-9f64-facf20c9ce93")),
      ExerciseDTO(
          currentSets: [],
          previousSets: [],
          unit: WeightUnit.kg,
          equipment: Equipment.mashine,
          exerciseGroup: ExerciseGroup.quadriceps,
          name: "Leg Extension",
          mediaItem: MediaItemDTO(
              id: "c3131eab-3b51-4564-bae2-15ce9d0fce2d",
              name: "c3131eab-3b51-4564-bae2-15ce9d0fce2d",
              userId: _user!.uid,
              url:
                  "https://firebasestorage.googleapis.com/v0/b/workout-logger-dveneris.appspot.com/o/V67cvCm6ULOKBSO4levXbl8rwLD3%2Fc3131eab-3b51-4564-bae2-15ce9d0fce2d.png?alt=media&token=83966d61-fcf2-4e6c-a30e-510c7b41332b")),
      ExerciseDTO(
          currentSets: [],
          previousSets: [],
          unit: WeightUnit.kg,
          equipment: Equipment.mashine,
          exerciseGroup: ExerciseGroup.chest,
          name: "Cable Crossovers",
          mediaItem: MediaItemDTO(
              id: "be81a682-eff2-4611-9a87-9c19c06538ec",
              name: "be81a682-eff2-4611-9a87-9c19c06538ec",
              userId: _user!.uid,
              url:
                  "https://firebasestorage.googleapis.com/v0/b/workout-logger-dveneris.appspot.com/o/V67cvCm6ULOKBSO4levXbl8rwLD3%2Fbe81a682-eff2-4611-9a87-9c19c06538ec.png?alt=media&token=dc6790a1-21fc-4c8b-a7c8-7620f36c3af7")),
      ExerciseDTO(
          currentSets: [],
          previousSets: [],
          unit: WeightUnit.kg,
          equipment: Equipment.barbell,
          exerciseGroup: ExerciseGroup.chest,
          name: "Barbell Bench Press",
          mediaItem: MediaItemDTO(
              id: "b90e8cbf-4f5b-4b65-a4e0-1ea9de05fd84",
              name: "b90e8cbf-4f5b-4b65-a4e0-1ea9de05fd84",
              userId: _user!.uid,
              url:
                  "https://firebasestorage.googleapis.com/v0/b/workout-logger-dveneris.appspot.com/o/V67cvCm6ULOKBSO4levXbl8rwLD3%2Fb90e8cbf-4f5b-4b65-a4e0-1ea9de05fd84.png?alt=media&token=35c380b7-4c17-43e3-89c3-3d326c52d5ad")),
      ExerciseDTO(
          currentSets: [],
          previousSets: [],
          unit: WeightUnit.kg,
          equipment: Equipment.dumbell,
          exerciseGroup: ExerciseGroup.chest,
          name: "Dumbell Flyes",
          mediaItem: MediaItemDTO(
              id: "71d24b7b-c021-47d1-b28d-f6cb50f8f1bf",
              name: "71d24b7b-c021-47d1-b28d-f6cb50f8f1bf",
              userId: _user!.uid,
              url:
                  "https://firebasestorage.googleapis.com/v0/b/workout-logger-dveneris.appspot.com/o/V67cvCm6ULOKBSO4levXbl8rwLD3%2F71d24b7b-c021-47d1-b28d-f6cb50f8f1bf.png?alt=media&token=0f459d05-f649-420f-8828-65c3bf005a60")),
    ];
    var taskList = <Future<ExerciseDTO>>[];
    for (var exercise in exerciseList) {
      var exerciseTask = ExerciseService().createAndGetExercise(exercise);
      taskList.add(exerciseTask);
    }
    var createdExerciseList = await taskList.wait;
    var legExerciseList = createdExerciseList
        .where((ex) =>
            ex.name == "Leg Press" ||
            ex.name == "Leg Curl" ||
            ex.name == "Cable Crossovers")
        .toList();
    var chestExerciseList = createdExerciseList
        .where((ex) =>
            ex.name == "Dumbell Flyes" ||
            ex.name == "Barbell Bench Press" ||
            ex.name == "Leg Extension")
        .toList();

    var workoutDtolist = <WorkoutDTO>[
      WorkoutDTO(
          createDate: DateTime.now(),
          updateDate: DateTime.now(),
          name: "Leg Day",
          userId: _user!.uid,
          exerciseList: legExerciseList
              .map((ex) => ExerciseOptionsDTO(exercise: ex))
              .toList()),
      WorkoutDTO(
          createDate: DateTime.now(),
          updateDate: DateTime.now(),
          name: "Chest Day",
          userId: _user!.uid,
          exerciseList: chestExerciseList
              .map((ex) => ExerciseOptionsDTO(exercise: ex))
              .toList()),
    ];

    await WorkoutService().bulkCreate(workoutDtolist);
  }
}
