import 'package:training_tracker/DTOS/media-item-dto.dart';
import 'package:training_tracker/models/enums/enums.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/models/exercise_set.dart';
import 'package:training_tracker/models/media_item.dart';

class ExerciseDTO {
  String? id;
  String? userId;
  String name;
  ExerciseGroup exerciseGroup;
  List<ExerciseSet> currentSets;
  List<ExerciseSet> previousSets;
  WeightUnit unit;
  Equipment equipment;
  MediaItem? mediaItem;

  ExerciseDTO(
      {this.id,
      this.userId,
      this.name = '',
      this.exerciseGroup = ExerciseGroup.none,
      this.currentSets = const [],
      this.previousSets = const [],
      this.unit = WeightUnit.kg,
      this.equipment = Equipment.none,
      this.mediaItem});
}
