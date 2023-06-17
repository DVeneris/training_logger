import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/enums/enums.dart';
import 'package:training_tracker/models/exercise_complete.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/models/exercise_set.dart';

class Workout {
  String? id;
  final String userId;
  final String name;
  final String? note;
  final DateTime createDate;
  final DateTime updateDate;
  final List<ExerciseOptions> exerciseList;
  final String totalTime;
  final int totalVolume;

  Workout({
    this.id,
    required this.userId,
    required this.name,
    this.note,
    required this.createDate,
    required this.updateDate,
    required this.exerciseList,
    required this.totalTime,
    required this.totalVolume,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'note': note,
      'createDate': createDate.toIso8601String(),
      'updateDate': updateDate.toIso8601String(),
      'exerciseList': exerciseList.map((exercise) => exercise.toMap()).toList(),
      'totalTime': totalTime,
      'totalVolume': totalVolume,
    };
  }

  factory Workout.fromJson(Map<String, dynamic> json, String id) {
    var exList = json['exerciseList'];
    var tt = exList as List<dynamic>;
    tt.map((e) => ExerciseOptions.fromJson(e));

    return Workout(
      id: id,
      userId: json['userId'],
      name: json['name'],
      note: json['note'],
      createDate: DateTime.parse(json['createDate']),
      updateDate: DateTime.parse(json['updateDate']),
      exerciseList: List<dynamic>.from(json['exerciseList'])
          .map((exerciseJson) => ExerciseOptions.fromJson(exerciseJson))
          .toList(),
      totalTime: json['totalTime'],
      totalVolume: json['totalVolume'],
    );
  }
}

class ExerciseOptions {
  final int time;
  final String note;
  final String exerciseId;
  final WeightUnit unit;
  List<ExerciseSet> currentSets;
  List<ExerciseSet> previousSets;

  ExerciseOptions({
    required this.time,
    required this.note,
    required this.unit,
    required this.exerciseId,
    required this.currentSets,
    required this.previousSets,
  });

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'note': note,
      'exerciseId': exerciseId,
      'unit': unit.index,
      'currentSets': currentSets.map((set) => set.toMap()).toList(),
      'previousSets': previousSets.map((set) => set.toMap()).toList(),
    };
  }

  factory ExerciseOptions.fromJson(Map<String, dynamic> json) {
    //var unit1 = WeightUnit.values[json['unit']];
    var prevSet = json['previousSets'];
    var currSet = json['currentSets'];
    return ExerciseOptions(
      time: json['time'],
      note: json['note'],
      unit: WeightUnit.values[json['unit']],
      exerciseId: json['exerciseId'],
      previousSets: prevSet == null
          ? []
          : List<Map<String, dynamic>>.from(json['previousSets'])
              .map((setJson) => ExerciseSet.fromJson(setJson))
              .toList(),
      currentSets: currSet == null
          ? []
          : List<Map<String, dynamic>>.from(json['currentSets'])
              .map((setJson) => ExerciseSet.fromJson(setJson))
              .toList(),
    );
  }
}
