import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/workout.dart';
import 'package:training_tracker/models/workout_history.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/snapshot_object.dart';

class WorkoutHistoryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> createWorkoutHistory(WorkoutHistory workoutHistory) async {
    var ref = _db.collection('workoutHistory');
    var snapshot = await ref.add(workoutHistory.toMap());
  }

  Future<List<WorkoutHistory>> getWorkoutHistoryList(String userId) async {
    var ref =
        _db.collection('workoutHistory').where('userId', isEqualTo: userId);
    var snapshot = await ref.get(); //read collection once
    Iterable<SnapshotObject> snapshotList = <SnapshotObject>[];
    snapshotList = snapshot.docs.map((s) {
      return SnapshotObject(id: s.id, data: s.data());
    });
    var workoutHistoryList =
        snapshotList.map((e) => WorkoutHistory.fromJson(e.data, e.id));

    return workoutHistoryList.toList();
  }

  // Future<void> createWorkoutHistory(WorkoutDTO workoutDTO) async {
  //   var user = AuthService().user;
  //   // var workout = Workout(
  //   //     userId: user!.uid,
  //   //     name: workoutDTO.name,
  //   //     createDate: workoutDTO.createDate ?? DateTime.now(),
  //   //     updateDate: DateTime.now(),
  //   //     exerciseList: _calculateExerciseOptionList(workoutDTO.exerciseList),
  //   //     totalTime: "0",
  //   //     totalVolume: 0);
  //   var workoutHistory = WorkoutHistory(
  //       userId: user!.uid,
  //       workoutId: workoutDTO.id!,
  //       workoutName: workoutDTO.name,
  //       exerciseOptions: _getExerciseOptions(workoutDTO.exerciseList));

  //   var ref = _db.collection('workout');
  //   var workoutMap = workout.toMap();
  //   var snapshot = await ref.add(workoutMap);
  // }

  // List<WorkoutHistoryExerciseOptions> _getExerciseOptions(
  //     List<ExerciseOptionsDTO> exerciselist) {
  //   var list = <WorkoutHistoryExerciseOptions>[];
  //   exerciselist.forEach((element) {
  //     var options = WorkoutHistoryExerciseOptions(
  //         id: element.exercise.id!,
  //         name: element.exercise.name,
  //         currentSets: element.exercise.currentSets,
  //         previousSets: element.exercise.previousSets); //
  //   });
  //   return list;
  // }
}
