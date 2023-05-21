import 'package:cloud_firestore/cloud_firestore.dart';
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
}
