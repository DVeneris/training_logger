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
  MediaItemDTO? mediaItem;

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
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'exerciseGroup': exerciseGroup.index,
      'unit': unit.index,
      'previousSets': previousSets.map((set) => set.toMap()).toList(),
      'currentSets': currentSets.map((set) => set.toMap()).toList(),
      'mediaItem': mediaItem?.toMap(),
      'equipment': equipment.index
    };
  }

  factory ExerciseDTO.fromJsonWithId(Map<String, dynamic> json, String id) {
    return ExerciseDTO(
        id: id,
        userId: json['userId'],
        name: json['name'],
        exerciseGroup: ExerciseGroup.values[json['exerciseGroup']],
        unit: WeightUnit.values[json['unit']],
        currentSets: json['currentSets'] == null
            ? []
            : List<Map<String, dynamic>>.from(json['currentSets'])
                .map((setJson) => ExerciseSet.fromJson(setJson))
                .toList(),
        previousSets: json['previousSets'] == null
            ? []
            : List<Map<String, dynamic>>.from(json['previousSets'])
                .map((setJson) => ExerciseSet.fromJson(setJson))
                .toList(),
        mediaItem: json['mediaItem'] != null
            ? MediaItemDTO.fromJson(json['mediaItem'])
            : null,
        equipment: Equipment.values[json['equipment']]);
  }
  factory ExerciseDTO.fromJson(Map<String, dynamic> json) {
    return ExerciseDTO(
        id: json['id'],
        userId: json['userId'],
        name: json['name'],
        exerciseGroup: ExerciseGroup.values[json['exerciseGroup']],
        unit: WeightUnit.values[json['unit']],
        currentSets: json['currentSets'] == null
            ? []
            : List<Map<String, dynamic>>.from(json['currentSets'])
                .map((setJson) => ExerciseSet.fromJson(setJson))
                .toList(),
        previousSets: json['previousSets'] == null
            ? []
            : List<Map<String, dynamic>>.from(json['previousSets'])
                .map((setJson) => ExerciseSet.fromJson(setJson))
                .toList(),
        mediaItem: json['mediaItem'] != null
            ? MediaItemDTO.fromJson(json['mediaItem'])
            : null,
        equipment: Equipment.values[json['equipment']]);
  }
}
