import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/DTOS/workout_history_dto.dart';
import 'package:training_tracker/models/workout.dart';
import 'package:training_tracker/models/workout_history.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/extensions/helper_extensions.dart';
import 'package:training_tracker/services/snapshot_object.dart';
import 'package:training_tracker/services/workout_service.dart';

class WorkoutHistoryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  // Future<void> createWorkoutHistory(WorkoutHistory workoutHistory) async {
  //   var ref = _db.collection('workoutHistory');
  //   var snapshot = await ref.add(workoutHistory.toMap());
  // }

  Future<List<WorkoutHistoryDTO>> getWorkoutHistoryList(String userId) async {
    var ref =
        _db.collection('workoutHistory').where('userId', isEqualTo: userId);
    var snapshot = await ref.get(); //read collection once
    Iterable<SnapshotObject> snapshotList = <SnapshotObject>[];
    snapshotList = snapshot.docs.map((s) {
      return SnapshotObject(id: s.id, data: s.data());
    });
    var workoutHistoryList =
        snapshotList.map((e) => WorkoutHistory.fromJson(e.data, e.id)).toList();

    var ids =
        workoutHistoryList.map((e) => e.workoutId).toList().removeDuplicates();
    var workoutDtoListraw =
        await WorkoutService().getWorkoutList(userId: userId, workoutIds: ids);
    var workoutHistoryDtoList = <WorkoutHistoryDTO>[];
    for (var e in workoutHistoryList) {
      var workoutToAdd = workoutDtoListraw
          .toList()
          .where((element) => element.id == e.workoutId)
          .first;
      var workoutHistoryDto = WorkoutHistoryDTO(
          id: e.id,
          totalTime: e.totalTime,
          totalVolume: e.totalVolume,
          userId: e.userId,
          workoutDate: e.workoutDate,
          workout: workoutToAdd,
          exerciseOptions: e.exerciseOptions);
      workoutHistoryDtoList.add(workoutHistoryDto);
    }
    return workoutHistoryDtoList;
    // workoutHistoryList.forEach((workout) {
    //   var workoutDto = await WorkoutService().get

    // });
    // return workoutHistoryList.toList();
  }

  Future<void> createWorkoutHistory(WorkoutDTO workoutDTO) async {
    var user = _authService.getUser();

    var workoutHistory = WorkoutHistory(
        userId: user!.uid,
        workoutId: workoutDTO.id!,
        // workoutName: workoutDTO.name,
        totalTime: workoutDTO.totalTime,
        totalVolume: workoutDTO.totalVolume,
        workoutDate: DateTime.now(),
        exerciseOptions: _getExerciseOptions(workoutDTO.exerciseList));

    var ref = _db.collection('workoutHistory');
    var workoutMap = workoutHistory.toMap();
    var snapshot = await ref.add(workoutMap);
  }

  List<WorkoutHistoryExerciseOptions> _getExerciseOptions(
      List<ExerciseOptionsDTO> exerciselist) {
    var list = <WorkoutHistoryExerciseOptions>[];
    exerciselist.forEach((element) {
      var options = WorkoutHistoryExerciseOptions(
          id: element.exercise.id!,
          name: element.exercise.name,
          currentSets: element.exercise.currentSets,
          previousSets: element.exercise.previousSets);
      list.add(options);
    });
    return list;
  }
}
