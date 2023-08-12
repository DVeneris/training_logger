import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/models/exercise_complete.dart';
import 'package:training_tracker/models/exercise_set.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/providers/exercise_creator_provider.dart';
import 'package:training_tracker/utils/popupMenuButton.dart';
import 'package:training_tracker/widgets/workout/workout.dart';
import 'package:training_tracker/utils/workoutSetTextField.dart';

import '../../providers/workout_provider.dart';

class ExerciseSingle extends StatelessWidget {
  final ExerciseDTO exercise;
  final bool? canTrain;
  final Function() onAddExerciseSet;
  final Function() onExerciseDeletion;
  final Function(int) onExerciseSetDeletion;
  final Function(bool?, int)? onSetChecked;
  const ExerciseSingle(
      {super.key,
      required this.exercise,
      required this.onAddExerciseSet,
      required this.onExerciseDeletion,
      required this.onExerciseSetDeletion,
      this.canTrain = false,
      this.onSetChecked});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    exercise.mediaItem != null
                        ? CircleAvatar(
                            maxRadius: 20,
                            minRadius: 10,
                            backgroundImage:
                                NetworkImage(exercise.mediaItem!.url!))
                        : const CircleAvatar(
                            maxRadius: 20,
                            minRadius: 10,
                            backgroundImage: AssetImage("assets/no_media.png"),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        exercise.name,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            CustomPopupMenuButton(
              onItemSelection: ((option) {
                if (option == Options.delete) {
                  onExerciseDeletion();
                }
              }),
            )
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 1, child: Text("Set")),
            Expanded(flex: 1, child: Text("Previous")),
            Expanded(flex: 2, child: Center(child: Text("Weight"))),
            Expanded(flex: 2, child: Center(child: Text("Reps"))),
            Expanded(flex: 1, child: Text("")),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: exercise.currentSets.length,
          itemBuilder: (context, index) {
            var set = exercise.currentSets.isNotEmpty
                ? exercise.currentSets[index]
                : ExerciseSet();

            var prevSet = ExerciseSet();
            if (index < exercise.previousSets.length) {
              prevSet = exercise.previousSets.isNotEmpty
                  ? exercise.previousSets[index]
                  : ExerciseSet();
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Dismissible(
                key: Key("${exercise.id}-index-$index"),
                onDismissed: (direction) {
                  // Remove the item from the data source.
                  // setState(() {
                  onExerciseSetDeletion(index);
                  // });
                  // Then show a snackbar.
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 1,
                        child:
                            Text("${exercise.currentSets.indexOf(set) + 1}")),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: prevSet.reps != null || prevSet.weight != null
                            ? Text('${prevSet.weight} x ${prevSet.reps}')
                            : const Text('-'),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: WorkoutSetTextield(
                          hint: prevSet.weight ?? '',
                          text: set.weight ?? '',
                          onChange: (data) {
                            set.weight = data;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: WorkoutSetTextield(
                          hint: prevSet.reps ?? '',
                          text: set.reps ?? '',
                          onChange: (data) {
                            set.reps = data;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: canTrain != null && canTrain == true
                          ? Checkbox(
                              value: set.isComplete,
                              onChanged: set.reps == null || set.weight == null
                                  ? null
                                  : (bool? change) {
                                      if (onSetChecked != null) {
                                        onSetChecked!(change, index);
                                      }
                                    })
                          : const Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 9.0, bottom: 9),
                child: TextButton(
                  child: const Text(
                    "Add Set",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {
                    onAddExerciseSet();
                  },
                )),
          ],
        ),
      ],
    );
  }
}






// class ExerciseSingle extends StatefulWidget {
//   final ExerciseDTO exercise;
//   late final bool canTrain;
//   final Function() onSelectParam;
//   final Function()? onExerciseDeletion;
//   final Function(bool?) onSetChecked;
//   ExerciseSingle(
//       {super.key,
//       required this.exercise,
//       required this.onSelectParam,
//       this.onExerciseDeletion,
//       bool? canTrain,
//       required this.onSetChecked}) {
//     this.canTrain = canTrain ?? true;
//   }

//   @override
//   State<ExerciseSingle> createState() => _ExerciseSingleState();
// }

// class _ExerciseSingleState extends State<ExerciseSingle> {
//   final weightController = TextEditingController();
//   final repsController = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     repsController.addListener(_printLatestValue);
//     weightController.addListener(_printLatestValue);
//   }

//   void _printLatestValue() {
//     print('Second text field: ${repsController.text}');
//   }

//   @override
//   void dispose() {
//     repsController.dispose();
//     weightController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }