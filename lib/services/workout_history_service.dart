import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/DTOS/workout_history_dto.dart';
import 'package:training_tracker/mappers/workout_history_mapper.dart';
import 'package:training_tracker/models/workout.dart';
import 'package:training_tracker/models/workout_history.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/extensions/helper_extensions.dart';
import 'package:training_tracker/services/snapshot_object.dart';
import 'package:training_tracker/services/workout_service.dart';

class WorkoutHistoryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  Future<List<WorkoutHistoryDTO>> getWorkoutHistoryList(String userId) async {
    var ref =
        _db.collection('workoutHistory').where('userId', isEqualTo: userId);
    var snapshot = await ref.get();
    Iterable<SnapshotObject> snapshotList = <SnapshotObject>[];
    snapshotList = snapshot.docs.map((s) {
      return SnapshotObject(id: s.id, data: s.data());
    });
    var workoutHistoryList =
        snapshotList.map((e) => WorkoutHistory.fromJson(e.data, e.id)).toList();
    return workoutHistoryList.toDtoList();
  }

  Future<void> createWorkoutHistory(
      WorkoutDTO workoutDTO, String totalTime, int totalVolume) async {
    var user = _authService.getUser();

    var workoutHistory = WorkoutHistory(
      userId: user!.uid,
      exerciseList: workoutDTO.exerciseList,
      note: workoutDTO.note,
      totalTime: totalTime,
      totalVolume: totalVolume,
      workoutDate: DateTime.now(),
      workoutName: workoutDTO.name,
    );

    var ref = _db.collection('workoutHistory');
    var workoutMap = workoutHistory.toMap();
    var snapshot = await ref.add(workoutMap);
  }
}
