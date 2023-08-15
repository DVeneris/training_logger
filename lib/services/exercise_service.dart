import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/media-item-dto.dart';
import 'package:training_tracker/mappers/exercise_mapper.dart';
import 'package:training_tracker/models/enums/enums.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/models/media_item.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/snapshot_object.dart';

class ExerciseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  Future<void> createExercise(ExerciseDTO exerciseDTO) async {
    var authUser = _authService.getUser();
    var exercise = Exercise(
        userId: authUser!.uid,
        name: exerciseDTO.name,
        exerciseGroup: exerciseDTO.exerciseGroup,
        unit: WeightUnit.kg,
        currentSets: exerciseDTO.currentSets,
        previousSets: exerciseDTO.previousSets,
        mediaItem: getMediaItem(exerciseDTO.mediaItem),
        equipment: Equipment.none);

    var snapshot = await _db.collection("exercise").add(exercise.toMap());
  }

  MediaItem? getMediaItem(MediaItemDTO? mediaItemDTO) {
    if (mediaItemDTO == null) return null;
    return MediaItem(
        id: mediaItemDTO.id,
        userId: mediaItemDTO.userId,
        name: mediaItemDTO.name,
        url: mediaItemDTO.url);
  }

  Future<void> updateExercise(Exercise exercise) async {
    var ref = _db.collection('exercise').doc(exercise.userId);
  }

  Future<List<ExerciseDTO>> getExerciseList(
      String? userId, List<String>? exerciseIds) async {
    Query<Map<String, dynamic>> ref;
    if (exerciseIds != null && exerciseIds.isNotEmpty) {
      ref = _db
          .collection('exercise')
          .where('userId', isEqualTo: userId)
          .where(FieldPath.documentId, whereIn: exerciseIds);
    } else {
      ref = _db.collection('exercise').where('userId', isEqualTo: userId);
    }
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
}
