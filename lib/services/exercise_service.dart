import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/mappers/exercise_mapper.dart';
import 'package:training_tracker/models/enums/enums.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/snapshot_object.dart';

class ExerciseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> createExercise(ExerciseDTO exerciseDTO) async {
    var user = AuthService().user;
    var exercise = Exercise(
        userId: user!.uid,
        name: exerciseDTO.name,
        exerciseGroup: exerciseDTO.exerciseGroup,
        unit: WeightUnit.kg,
        sets: [],
        mediaItemId: 'nPQc2Iur2xnqo405UnhZ',
        equipment: Equipment.none);

    var ref = _db.collection('exercise');
    var snapshot = await _db.collection("exercise").add(exercise.toMap());
    //return Exercise.fromJson(snapshot. ?? {});
  }

  Future<void> updateExercise(Exercise exercise) async {
    var user = AuthService().user!;
    var ref = _db.collection('exercise').doc(exercise.userId);

    //return Exercise.fromJson(snapshot. ?? {});
  }

  Future<List<ExerciseDTO>> getExerciseList(
      String? userId, List<String>? exerciseIds) async {
    var ref = _db
        .collection('exercise')
        .where('userId', isEqualTo: userId)
        .where(FieldPath.documentId, whereIn: exerciseIds);
    var snapshot = await ref.get(); //read collection once
    Iterable<SnapshotObject> snapshotList = <SnapshotObject>[];
    snapshotList = snapshot.docs.map((s) {
      return SnapshotObject(id: s.id, data: s.data());
    });
    var exercises = snapshotList.map((e) => Exercise.fromJson(e.data, e.id));
    return exercises.toDTOList();
  }

  Future<ExerciseDTO> getExercise(String exerciseId) async {
    var ref = _db.collection('exercise').doc(exerciseId);
    var snapshot = await ref.get(); //read collection once
    return Exercise.fromJson(snapshot.data() ?? {}, snapshot.id).toDTO();
  }

  // Stream<Exercise> streamReport(){//kai kala otan dimiourgithei mia nea Exrcise na tin kalesei pisw
  //   return AuthService().userStream.switchMap((user) {//apo rfdart
  //     if(user!=null){

  //     }
  //     else{
  //       return Stream.fromIterable([Exercise()])
  //     }
  //   });

  // }
}
