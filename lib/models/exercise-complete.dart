import 'package:training_tracker/models/exercise-set.dart';
import 'package:training_tracker/models/exercise.dart';

class ExerciseComplete extends Exercise {
  String? note;
  List<ExerciseSet> sets;

  ExerciseComplete(
      {required super.id,
      required super.name,
      required this.sets,
      required super.exerciseGroup});
}
