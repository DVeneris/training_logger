import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/models/enums/enums.dart';
import 'package:training_tracker/models/exercise.dart';

extension ExerciseMapping on Exercise {
  ExerciseDTO toDTO() {
    return ExerciseDTO(
      id: id,
      userId: userId,
      name: name,
      exerciseGroup: exerciseGroup,
      sets: sets,
      equipment: equipment,
      //mediaItem: MediaItemDTO(mediaItemId),
    );
  }
}

extension ExerciseDTOMapping on ExerciseDTO {
  Exercise toModel() {
    return Exercise(
      id: id,
      userId: userId ?? "",
      name: name,
      exerciseGroup: exerciseGroup,
      sets: sets,
      unit: unit,
      mediaItemId: mediaItem.id ?? "",
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
