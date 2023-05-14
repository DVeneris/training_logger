import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/models/exercise_complete.dart';
import 'package:training_tracker/models/exercise_set.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/utils/popupMenuButton.dart';
import 'package:training_tracker/widgets/workout/workout.dart';
import 'package:training_tracker/utils/workoutSetTextField.dart';

class ExerciseSingle extends StatefulWidget {
  //Exercise exercise = Exercise(name: "Leg Extension (Mashine)", sets: [Set()]);
  final ExerciseDTO exercise;
  late final bool canTrain;
  final Function() onSelectParam;
  final Function()? onExerciseDeletion;
  ExerciseSingle(
      {super.key,
      required this.exercise,
      required this.onSelectParam,
      this.onExerciseDeletion,
      bool? canTrain}) {
    this.canTrain = canTrain ?? true;
  }

  @override
  State<ExerciseSingle> createState() => _ExerciseSingleState();
}

class _ExerciseSingleState extends State<ExerciseSingle> {
  final weightController = TextEditingController();
  final repsController = TextEditingController();
  @override
  void initState() {
    super.initState();
    widget.exercise.mediaItem;
    repsController.addListener(_printLatestValue);
    weightController.addListener(_printLatestValue);
    //exercise.mediaItem?.url ??= "/assets/no_media.png";
  }

  void _printLatestValue() {
    print('Second text field: ${repsController.text}');
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    repsController.dispose();
    weightController.dispose();
    super.dispose();
  }

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
                    CircleAvatar(
                      maxRadius: 20,
                      minRadius: 10,
                      backgroundImage:
                          AssetImage(widget.exercise.mediaItem.url),
                      backgroundColor: Colors.transparent,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        widget.exercise.name,
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
                  if (widget.onExerciseDeletion != null) {
                    widget.onExerciseDeletion!();
                  }
                }
              }),
            )
            //   IconButton(
            //     icon: const Icon(Icons.more_vert),
            //     color: Colors.blue,
            //     onPressed: () {},
            //   )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
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
          itemCount: widget.exercise.sets.length,
          itemBuilder: (context, index) {
            var set = widget.exercise.sets[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Dismissible(
                key: Key("${widget.exercise.id}-index-$index"),
                onDismissed: (direction) {
                  // Remove the item from the data source.
                  setState(() {
                    widget.exercise.sets.removeAt(index);
                  });
                  // Then show a snackbar.
                  // ScaffoldMessenger.of(context)
                  //     .showSnackBar(SnackBar(content: Text('item dismissed')));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 1,
                        child:
                            Text("${widget.exercise.sets.indexOf(set) + 1}")),
                    const Expanded(flex: 1, child: Center(child: Text('-'))),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: WorkoutSetTextield(
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
                          text: set.reps ?? '',
                          onChange: (data) {
                            set.reps = data;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: widget.canTrain
                          ? Checkbox(
                              value: set.isComplete,
                              onChanged: (bool? onChanged) {
                                setState(() {
                                  set.isComplete = onChanged ?? false;
                                });
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
                    setState(() {
                      widget.exercise.sets.add(new ExerciseSet());
                      widget.onSelectParam();
                    });
                    print(widget.exercise.sets.length);
                  },
                )),
          ],
        ),
      ],
    );
  }
}

// DataTable(
//                 columnSpacing: 30,
//                 columns: const <DataColumn>[
//                   DataColumn(
//                     label: Expanded(
//                       child: Text(
//                         'Set',
//                         style: TextStyle(fontStyle: FontStyle.normal),
//                       ),
//                     ),
//                   ),
//                   DataColumn(
//                     label: Expanded(
//                       child: Text(
//                         'Previous',
//                         style: TextStyle(fontStyle: FontStyle.normal),
//                       ),
//                     ),
//                   ),
//                   DataColumn(
//                     label: Expanded(
//                       child: Text(
//                         textAlign: TextAlign.center,
//                         'kg',
//                         style: TextStyle(fontStyle: FontStyle.normal),
//                       ),
//                     ),
//                   ),
//                   DataColumn(
//                     label: Expanded(
//                       child: Text(
//                         textAlign: TextAlign.center,
//                         'Reps',
//                         style: TextStyle(fontStyle: FontStyle.normal),
//                       ),
//                     ),
//                   ),
//                   DataColumn(
//                     label: Expanded(
//                       child: Text(''),
//                     ),
//                   ),
//                 ],
//                 rows: widget.exercise.sets.map((set) {
//                   return DataRow(
//                     cells: <DataCell>[
//                       DataCell(Text(
//                           "${widget.exercise.sets.indexOf(set) + 1}")), //den einai auto
//                       const DataCell(Text('-')),
//                       DataCell(WorkoutSetTextield(
//                         onChange: (data) {
//                           set.weight = data;
//                         },
//                       )),
//                       DataCell(WorkoutSetTextield(
//                         onChange: (data) {
//                           set.reps = data;
//                         },
//                       )),
//                       DataCell(widget.canTrain
//                           ? Checkbox(
//                               value: set.isComplete,
//                               onChanged: (bool? onChanged) {
//                                 setState(() {
//                                   set.isComplete = onChanged ?? false;
//                                 });
//                               })
//                           : Dismissible(
//                               onDismissed: ((direction) {}),
//                               key: Key(set.toString()),
//                               child: const Icon(
//                                 Icons.lock,
//                                 color: Colors.grey,
//                               ),
//                             )),
//                     ],
//                   );
//                 }).toList()),



// Table(
//             children: widget.exercise.sets.map((set) {
//           return TableRow(children: [
//             ListView.builder(
//               shrinkWrap: true,
//               scrollDirection: Axis.vertical,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: widget.exercise.sets.length,
//               itemBuilder: (context, index) {
//                 var set = widget.exercise.sets[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("${widget.exercise.sets.indexOf(set) + 1}"),
//                       const Text('-'),
//                       WorkoutSetTextield(
//                         onChange: (data) {
//                           set.weight = data;
//                         },
//                       ),
//                       WorkoutSetTextield(
//                         onChange: (data) {
//                           set.reps = data;
//                         },
//                       ),
//                       widget.canTrain
//                           ? Checkbox(
//                               value: set.isComplete,
//                               onChanged: (bool? onChanged) {
//                                 setState(() {
//                                   set.isComplete = onChanged ?? false;
//                                 });
//                               })
//                           : const Icon(
//                               Icons.lock,
//                               color: Colors.grey,
//                             ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ]);
//         }).toList()),