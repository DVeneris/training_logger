class ExerciseSet {
  String? weight;
  String? reps;
  late bool isComplete;

  ExerciseSet({this.weight, this.reps, bool? isComplete}) {
    this.isComplete = isComplete ?? false;
  }

  factory ExerciseSet.fromJson(Map<String, dynamic> json) {
    return ExerciseSet(
      weight: json['weight'],
      reps: json['reps'],
      isComplete: json['isComplete'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'weight': weight,
      'reps': reps,
      'isComplete': isComplete,
    };
  }
}
