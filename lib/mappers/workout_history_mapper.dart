import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/DTOS/workout_history_dto.dart';
import 'package:training_tracker/mappers/workout-mapper.dart';
import 'package:training_tracker/models/workout.dart';
import 'package:training_tracker/models/workout_history.dart';

extension WorkoutHistoryMapper on WorkoutHistoryDTO {
  WorkoutHistory toModel() {
    return WorkoutHistory(
        exerciseList: exerciseList,
        note: note,
        totalTime: totalTime,
        totalVolume: totalVolume,
        userId: userId,
        workoutDate: workoutDate,
        workoutName: workoutName,
        id: id);
  }
}

extension WorkoutHistoryDTOMapper on WorkoutHistory {
  WorkoutHistoryDTO toDto() {
    return WorkoutHistoryDTO(
        note: note,
        exerciseList: exerciseList,
        totalTime: totalTime,
        totalVolume: totalVolume,
        userId: userId,
        workoutDate: workoutDate,
        workoutName: workoutName,
        id: id);
  }
}

extension WorkoutHistoryDTOListMapper on List<WorkoutHistory> {
  List<WorkoutHistoryDTO> toDtoList() {
    return map((item) => item.toDto()).toList();
  }
}
