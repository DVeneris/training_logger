import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/media-item-dto.dart';
import 'package:training_tracker/models/enums/enums.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/models/media_item.dart';
import 'package:uuid/uuid.dart';

extension ExerciseMapping on Exercise {
  ExerciseDTO toDTO() {
    return ExerciseDTO(
        id: id,
        userId: userId,
        name: name,
        exerciseGroup: exerciseGroup,
        currentSets: currentSets,
        previousSets: previousSets,
        equipment: equipment,
        mediaItem: getMediaItemDTO(mediaItem));
  }
}

MediaItemDTO? getMediaItemDTO(MediaItem? mediaItem) {
  if (mediaItem == null) return null;
  return MediaItemDTO(
      id: mediaItem.id,
      name: mediaItem.name,
      url: mediaItem.url,
      userId: mediaItem.userId);
}

MediaItem? getMediaItem(MediaItemDTO? mediaItemDTO) {
  if (mediaItemDTO == null) return null;
  return MediaItem(
      id: mediaItemDTO.id,
      userId: mediaItemDTO.userId,
      name: mediaItemDTO.name,
      url: mediaItemDTO.url);
}

extension ExerciseDTOMapping on ExerciseDTO {
  Exercise toModel() {
    return Exercise(
      id: id,
      userId: userId ?? "",
      name: name,
      exerciseGroup: exerciseGroup,
      currentSets: currentSets,
      previousSets: previousSets,
      unit: unit,
      mediaItem: getMediaItem(mediaItem),
      equipment: equipment,
    );
  }
}

extension ExerciseDTOIterableMapping on Iterable<Exercise> {
  List<ExerciseDTO> toDTOList() {
    return map((exercise) => exercise.toDTO()).toList();
  }
}

// extension ExerciseIterableMapping on Iterable<ExerciseDTO> {
//   List<Exercise> toModelList() {
//     return map((exerciseDTO) => exerciseDTO.toModel()).toList();
//   }
// }
