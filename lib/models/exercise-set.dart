class ExerciseSet {
  // final int setNumber;
  String? weight;
  String? reps;
  late bool isComplete;
  ExerciseSet({this.weight, this.reps, bool? isComplete}) {
    this.isComplete = isComplete ?? false;
  }
}
