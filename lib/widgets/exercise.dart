import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:training_tracker/widgets/workout.dart';
import 'package:training_tracker/widgets/workoutSetTextField.dart';

class ExerciseSingle extends StatefulWidget {
  //Exercise exercise = Exercise(name: "Leg Extension (Mashine)", sets: [Set()]);
  final ExerciseComplete exercise;
  Function() onSelectParam;
  ExerciseSingle(
      {super.key, required this.exercise, required this.onSelectParam});

  @override
  State<ExerciseSingle> createState() => _ExerciseSingleState();
}

class _ExerciseSingleState extends State<ExerciseSingle> {
  // late Exercise exercise;

  final weightController = TextEditingController();
  final repsController = TextEditingController();
  @override
  void initState() {
    super.initState();
    widget.exercise.mediaItem ??= MediaItem();
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
                      backgroundImage: AssetImage(
                          widget.exercise.mediaItem?.url ??
                              "assets/no_media.png"),
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
            IconButton(
              icon: const Icon(Icons.more_vert),
              color: Colors.blue,
              onPressed: () {},
            )
          ],
        ),
        FittedBox(
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: DataTable(
                columnSpacing: 30,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Set',
                        style: TextStyle(fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Previous',
                        style: TextStyle(fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        textAlign: TextAlign.center,
                        'kg',
                        style: TextStyle(fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        textAlign: TextAlign.center,
                        'Reps',
                        style: TextStyle(fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(''),
                    ),
                  ),
                ],
                rows: widget.exercise.sets.map((set) {
                  return DataRow(
                    cells: <DataCell>[
                      DataCell(Text(
                          "${widget.exercise.sets.indexOf(set) + 1}")), //den einai auto
                      const DataCell(Text('-')),
                      DataCell(WorkoutSetTextield(
                        onChange: (data) {
                          set.weight = data;
                        },
                      )),
                      DataCell(WorkoutSetTextield(
                        onChange: (data) {
                          set.reps = data;
                        },
                      )),
                      DataCell(Checkbox(
                          value: set.isComplete ?? false,
                          onChanged: (bool? onChanged) {
                            setState(() {
                              set.isComplete = onChanged;
                            });
                          })),
                    ],
                  );
                }).toList()),
          ),
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
                      widget.exercise.sets.add(new Set());
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
