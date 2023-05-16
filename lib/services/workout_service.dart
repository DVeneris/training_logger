import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/workout.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/snapshot_object.dart';

import '../widgets/workout/workout.dart';

class WorkoutService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> createWorkout(WorkoutDTO workoutDTO) async {
    var user = AuthService().user;
    var workout = Workout(
        userId: user!.uid,
        name: workoutDTO.name,
        createDate: workoutDTO.createDate ?? DateTime.now(),
        updateDate: DateTime.now(),
        exerciseList: _calculateExerciseOptionList(workoutDTO.exerciseList),
        totalTime: "0",
        totalVolume: 0);

    var ref = _db.collection('workout');
    var snapshot = await ref.add(workout.toMap());
    //return Exercise.fromJson(snapshot. ?? {});
  }

  List<ExerciseOptions> _calculateExerciseOptionList(
      List<ExerciseOptionsDTO> exerciseList) {
    var list = <ExerciseOptions>[];
    for (var option in exerciseList) {
      list.add(ExerciseOptions(
          time: option.time,
          note: option.note,
          exerciseId: option.exercise.id ?? "",
          sets: option.exercise.sets));
    }
    return list;
  }

  // Future<void> updateExercise(Exercise exercise) async {
  //   var user = AuthService().user!;
  //   var ref = _db.collection('exercise').doc(exercise.userId);

  //   //return Exercise.fromJson(snapshot. ?? {});
  // }

  Future<List<WorkoutDTO>> getWorkoutList(String userId) async {
    var ref = _db.collection('workout').where('userId', isEqualTo: userId);
    var snapshot = await ref.get(); //read collection once
    Iterable<SnapshotObject> snapshotList = <SnapshotObject>[];
    snapshotList = snapshot.docs.map((s) {
      return SnapshotObject(id: s.id, data: s.data());
    });
    var exercises = snapshotList.map((e) => Workout.fromJson(e.data, e.id));
    return exercises.toDTOList();
  }

  // Future<ExerciseDTO> getExercise(String exerciseId) async {
  //   var ref = _db.collection('exercise').doc(exerciseId);
  //   var snapshot = await ref.get(); //read collection once
  //   return Exercise.fromJson(snapshot.data() ?? {}, snapshot.id).toDTO();
  // }
}
