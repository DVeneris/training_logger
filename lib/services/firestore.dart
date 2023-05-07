import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/user-dto.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/models/user.dart';
import 'package:training_tracker/services/auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> createExercise(Exercise exercise) async {
    var user = AuthService().user!;
    var ref = _db.collection('exercise');
    var snapshot = await _db.collection("exercise").add(exercise.toMap());
    //return Exercise.fromJson(snapshot. ?? {});
  }

  Future<void> updateExercise(Exercise exercise) async {
    var user = AuthService().user!;
    var ref = _db.collection('exercise').doc(exercise.userId);

    //return Exercise.fromJson(snapshot. ?? {});
  }

  Future<List<Exercise>> getExerciseList(String userId) async {
    var ref = _db.collection('exercise').where('userId', isEqualTo: userId);
    var snapshot = await ref.get(); //read collection once
    var data = snapshot.docs.map((s) => s.data());
    var exercises = data.map((e) => Exercise.fromJson(e));
    return exercises.toList();
  }

  Future<Exercise> getExercise(String exerciseId) async {
    var ref = _db.collection('exercise').doc(exerciseId);
    var snapshot = await ref.get(); //read collection once
    return Exercise.fromJson(snapshot.data() ?? {});
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
