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
  List<ExerciseSet> sets;
  WeightUnit unit;
  Equipment equipment;
  late MediaItemDTO mediaItem;

  ExerciseDTO({
    this.id,
    this.userId,
    this.name = '',
    this.exerciseGroup = ExerciseGroup.none,
    this.sets = const [],
    MediaItemDTO? mediaItem,
    this.unit = WeightUnit.kg,
    this.equipment = Equipment.none,
  }) {
    this.mediaItem = mediaItem ?? MediaItemDTO();
  }
}
