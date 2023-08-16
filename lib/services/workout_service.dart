import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/exercise_options_dto.dart';
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
  final AuthService _authService = AuthService();
  final WorkoutHistoryService _historyService = WorkoutHistoryService();

  Future<WorkoutDTO> createWorkout(WorkoutDTO workoutDTO) async {
    var user = _authService.getUser();
    var workout = Workout(
        userId: user!.uid,
        name: workoutDTO.name,
        note: workoutDTO.note,
        createDate: DateTime.now(),
        updateDate: DateTime.now(),
        exerciseList: _calculateExerciseOptionList(workoutDTO.exerciseList));

    var ref = _db.collection('workout');
    var workoutMap = workout.toMap();
    var snapshot = await ref.add(workoutMap);
    var dto = await getWorkout(snapshot.id);
    return dto;
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
        currentSets: [],
        previousSets: option.exercise.currentSets,
      ));
    }
    return list;
  }

  Future<void> saveAndCreateWorkoutHistory(
      WorkoutDTO workoutDTO, String totalTime, int totalVolume) async {
    var user = _authService.getUser();
    var workout = Workout(
        userId: user!.uid,
        name: workoutDTO.name,
        createDate: workoutDTO.createDate ?? DateTime.now(),
        updateDate: DateTime.now(),
        exerciseList: _calculateExerciseOptionList(workoutDTO.exerciseList));

    var ref = _db.collection('workout').doc(workoutDTO.id);
    var workoutMap = workout.toMap();
    var snapshot = await ref.update(workoutMap);

    await _historyService.createWorkoutHistory(
        workoutDTO, totalTime, totalVolume);
  }

  Future<void> createWorkoutHistory(
      WorkoutDTO workoutDTO, String totalTime, int totalVolume) async {
    await _historyService.createWorkoutHistory(
        workoutDTO, totalTime, totalVolume);
  }

  Future<void> editWorkout(WorkoutDTO workoutDTO) async {
    var user = _authService.getUser();
    var workout = Workout(
        userId: user!.uid,
        name: workoutDTO.name,
        note: workoutDTO.note,
        createDate: workoutDTO.createDate ?? DateTime.now(),
        updateDate: DateTime.now(),
        exerciseList: _calculateExerciseOptionList(workoutDTO.exerciseList));

    var ref = _db.collection('workout').doc(workoutDTO.id);
    var workoutMap = workout.toMap();
    var snapshot = await ref.update(workoutMap);
  }

  Future<WorkoutDTO> getWorkout(String workoutId) async {
    var ref = _db.collection('workout').doc(workoutId);
    var snapshot = await ref.get(); //read collection once
    var workout = Workout.fromJson(snapshot.data() ?? {}, snapshot.id);
    var exerciseIds = <String>[];
    exerciseIds.addAll(workout.exerciseList.map((e) => e.exerciseId));
    var exerciseList =
        await ExerciseService().getExerciseList(null, exerciseIds);
    var dto = workout.toWorkoutDTO(exerciseList);
    return dto;
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
    await _db.collection("workout").doc(workoutId).delete();
  }

  Future<void> bulkCreate(List<WorkoutDTO> list) async {
    final ref = _db.collection('workout');
    WriteBatch batch = _db.batch();

    for (WorkoutDTO dto in list) {
      final newItem = ref.doc();
      var user = _authService.getUser();
      var workout = Workout(
          userId: user!.uid,
          name: dto.name,
          note: dto.note,
          createDate: DateTime.now(),
          updateDate: DateTime.now(),
          exerciseList: _calculateExerciseOptionList(dto.exerciseList));

      var workoutMap = workout.toMap();
      batch.set(newItem, workoutMap);
    }
    batch.commit();
  }
}
