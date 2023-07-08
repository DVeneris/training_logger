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
      currentSets: currentSets,
      previousSets: previousSets,
      equipment: equipment,
      mediaItem: mediaItem,
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
      currentSets: currentSets,
      previousSets: previousSets,
      unit: unit,
      mediaItem: mediaItem,
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
