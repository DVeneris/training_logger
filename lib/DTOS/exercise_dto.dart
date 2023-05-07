import 'package:training_tracker/DTOS/media-item-dto.dart';
import 'package:training_tracker/models/enums/enums.dart';
import 'package:training_tracker/models/exercise_set.dart';
import 'package:training_tracker/models/media_item.dart';

class ExerciseDTO {
  final String id;
  final String userId;
  final String name;
  final ExerciseGroup exerciseGroup;
  List<ExerciseSet> sets;
  late MediaItemDTO mediaItem;

  ExerciseDTO(
      {required this.id,
      required this.userId,
      required this.name,
      required this.exerciseGroup,
      required this.sets,
      MediaItemDTO? mediaItem}) {
    this.mediaItem = mediaItem ?? MediaItemDTO();
  }
}
