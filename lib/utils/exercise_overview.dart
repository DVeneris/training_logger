import 'package:flutter/material.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/models/exercise_complete.dart';
import 'package:training_tracker/models/exercise.dart';

import '../widgets/workout/workout.dart';

class ExerciseOverviewSingle extends StatefulWidget {
  final ExerciseDTO exercise;

  const ExerciseOverviewSingle({
    super.key,
    required this.exercise,
  });

  @override
  State<ExerciseOverviewSingle> createState() => _ExerciseOverviewSingleState();
}

class _ExerciseOverviewSingleState extends State<ExerciseOverviewSingle> {
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
                DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Set',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Weight',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Reps',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ],
                  rows: widget.exercise.currentSets.map((set) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(Text(
                            "${widget.exercise.currentSets.indexOf(set) + 1}")),
                        DataCell(Text(set.weight ?? '')),
                        DataCell(Text(set.reps ?? '')),
                      ],
                    );
                  }).toList(),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
// Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: const [
//             Expanded(flex: 1, child: Text("Set")),
//             Expanded(flex: 2, child: Center(child: Text("Weight"))),
//             Expanded(flex: 2, child: Center(child: Text("Reps"))),
//           ],
//         ),
//         ListView.builder(
//           shrinkWrap: true,
//           scrollDirection: Axis.vertical,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: widget.exercise.sets.length,
//           itemBuilder: (context, index) {
//             var set = widget.exercise.sets[index];
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                       flex: 1,
//                       child: Text("${widget.exercise.sets.indexOf(set) + 1}")),
//                   Expanded(
//                     flex: 2,
//                     child: Padding(
//                         padding: const EdgeInsets.only(right: 4.0),
//                         child: Text(set.weight ?? '')),
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Padding(
//                         padding: const EdgeInsets.only(right: 4.0),
//                         child: Text(set.reps ?? '')),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),