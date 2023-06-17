import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/mappers/workout-mapper.dart';
import 'package:training_tracker/models/enums/enums.dart';
import 'package:training_tracker/models/user.dart';
import 'package:training_tracker/models/workout.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/exercise_service.dart';
import 'package:training_tracker/services/extensions/helper_extensions.dart';
import 'package:training_tracker/services/snapshot_object.dart';
import 'package:training_tracker/services/workout_history_service.dart';
import '../widgets/workout/workout.dart';

class WorkoutService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> createWorkout(WorkoutDTO workoutDTO) async {
    var user = AuthService().user;
    var workout = Workout(
        userId: user!.uid,
        name: workoutDTO.name,
        createDate: DateTime.now(),
        updateDate: DateTime.now(),
        exerciseList: _calculateExerciseOptionList(workoutDTO.exerciseList),
        totalTime: "0",
        totalVolume: 0);

    var ref = _db.collection('workout');
    var workoutMap = workout.toMap();
    var snapshot = await ref.add(workoutMap);
    //return Exercise.fromJson(snapshot. ?? {});
  }

  List<ExerciseOptions> _calculateExerciseOptionList(
      List<ExerciseOptionsDTO> exerciseList) {
    var list = <ExerciseOptions>[];
    for (var option in exerciseList) {
      list.add(ExerciseOptions(
        time: option.time,
        note: option.note,
        unit: option.exercise.unit,
        exerciseId: option.exercise.id ?? "",
        currentSets: option.exercise.currentSets,
        previousSets: option.exercise.previousSets,
      ));
    }
    return list;
  }

  Future<void> updateWorkout(WorkoutDTO workoutDTO) async {
    var user = AuthService().user;
    var workout = Workout(
        userId: user!.uid,
        name: workoutDTO.name,
        createDate: workoutDTO.createDate ?? DateTime.now(),
        updateDate: DateTime.now(),
        exerciseList: _calculateExerciseOptionList(workoutDTO.exerciseList),
        totalTime: workoutDTO.totalTime,
        totalVolume: workoutDTO.totalVolume);

    var ref = _db.collection('workout').doc(workoutDTO.id);
    var workoutMap = workout.toMap();
    var snapshot = await ref.update(workoutMap);
    await WorkoutHistoryService().createWorkoutHistory(workoutDTO);
  }

  Future<List<WorkoutDTO>> getWorkoutList(
      {required String userId, List<String>? workoutIds}) async {
    Query<Map<String, dynamic>> ref;
    if (workoutIds != null && workoutIds.isNotEmpty) {
      ref = _db
          .collection('workout')
          .where('userId', isEqualTo: userId)
          .where(FieldPath.documentId, whereIn: workoutIds);
    } else {
      ref = _db.collection('workout').where('userId', isEqualTo: userId);
    }

    var snapshot = await ref.get(); //read collection once
    Iterable<SnapshotObject> snapshotList = <SnapshotObject>[];
    snapshotList = snapshot.docs.map((s) {
      return SnapshotObject(id: s.id, data: s.data());
    });
    var workoutList = snapshotList.map((e) => Workout.fromJson(e.data, e.id));
    var exerciseIds = <String>[];
    if (workoutList.isEmpty) {
      return [];
    }
    for (var workout in workoutList) {
      exerciseIds.addAll(workout.exerciseList.map((e) => e.exerciseId));
    }
    exerciseIds = exerciseIds.removeDuplicates();
    var exerciseList =
        await ExerciseService().getExerciseList(null, exerciseIds);
    var workoutDTOList = workoutList.toDtoList(exerciseList.toList());
    return workoutDTOList;
  }

  Future<void> deleteWorkout(String workoutId) async {
    await _db.collection("workout").doc("workoutId").delete();
  }

  // Future<ExerciseDTO> getWorkout(String exerciseId) async {
  //   var ref = _db.collection('exercise').doc(exerciseId);
  //   var snapshot = await ref.get(); //read collection once
  //   return Exercise.fromJson(snapshot.data() ?? {}, snapshot.id).toDTO();
  // }
}
