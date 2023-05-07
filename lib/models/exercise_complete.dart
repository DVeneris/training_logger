import 'package:training_tracker/models/exercise_set.dart';
import 'package:training_tracker/models/exercise.dart';
//den xreiazetai



// class ExerciseComplete extends Exercise {
//   String? note;
//   List<ExerciseSet> sets;

//   ExerciseComplete({
//     required String id,
//     required String name,
//     required this.sets,
//     required String exerciseGroup,
//     this.note,
//   }) : super(id: id, name: name, exerciseGroup: exerciseGroup);

//   factory ExerciseComplete.fromJson(Map<String, dynamic> json) {
//     var sets = <ExerciseSet>[];
//     if (json['sets'] != null) {
//       json['sets'].forEach((setJson) {
//         sets.add(ExerciseSet.fromJson(setJson));
//       });
//     }
//     return ExerciseComplete(
//       id: json['id'],
//       name: json['name'],
//       sets: sets,
//       exerciseGroup: json['exerciseGroup'],
//       note: json['note'],
//     );
//   }

//   @override
//   Map<String, dynamic> toMap() {
//     var setsJson = <Map<String, dynamic>>[];
//     sets.forEach((set) {
//       setsJson.add(set.toMap());
//     });
//     return {
//       'id': id,
//       'name': name,
//       'sets': setsJson,
//       'exerciseGroup': exerciseGroup,
//       'note': note,
//     };
//   }
// }
