import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/exercise_options_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/DTOS/workout_history_dto.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/models/workout.dart';
import 'package:training_tracker/providers/user_provider.dart';
import 'package:training_tracker/widgets/workout/workout.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../routes.dart';

class HomeCard extends StatelessWidget {
  final WorkoutHistoryDTO workoutHistory;
  const HomeCard({super.key, required this.workoutHistory});
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 10.0,
        right: 10.0,
      ),
      child: Card(
        color: const Color.fromARGB(255, 206, 229, 250),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              children: [
                userProvider.user!.mediaItem != null &&
                        userProvider.user!.mediaItem!.url != null
                    ? CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            NetworkImage(userProvider.user!.mediaItem!.url!))
                    : const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage("assets/no_media.png"),
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userProvider.user!.userName,
                        textAlign: TextAlign.left,
                      ),
                      if (workoutHistory.workoutDate != null)
                        Text(
                          timeago.format(workoutHistory.workoutDate!),
                          style: TextStyle(color: Colors.grey.shade600),
                        )
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    workoutHistory.workoutName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DataTable(
                    dividerThickness: 0,
                    headingRowHeight: 25,
                    dataTextStyle: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade600,
                    ),
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Time',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Volume',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Sets',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ],
                    rows: <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text(workoutHistory.totalTime)),
                          DataCell(Text('${workoutHistory.totalVolume} kg')),
                          DataCell(
                            Text(
                              _calculateTotalSets(workoutHistory.exerciseList),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              height: 20,
              thickness: 1,
              indent: 0,
              endIndent: 0,
              color: Color.fromARGB(255, 173, 172, 172),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Workout",
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: workoutHistory.exerciseList.length.clamp(0, 3),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                              "${workoutHistory.exerciseList[index].exercise.currentSets.length} x  "),
                          const SizedBox(
                            height: 10,
                          ),
                          workoutHistory
                                      .exerciseList[index].exercise.mediaItem !=
                                  null
                              ? ClipOval(
                                  child: Image.network(
                                  workoutHistory.exerciseList[index].exercise
                                      .mediaItem!.url!,
                                  width: 50,
                                  height: 40,
                                  fit: BoxFit.contain,
                                ))
                              : const CircleAvatar(
                                  maxRadius: 20,
                                  minRadius: 10,
                                  backgroundImage:
                                      AssetImage("assets/no_media.png"),
                                ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(workoutHistory
                                  .exerciseList[index].exercise.name),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            if (workoutHistory.exerciseList.length > 3) ...[
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          "And ${workoutHistory.exerciseList.length - 3} more excersises",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ]),
        ),
      ),
    );
  }

  String _calculateTotalSets(List<ExerciseOptionsDTO> exerciseOptions) {
    int totalSets = 0;

    for (var exercise in exerciseOptions) {
      totalSets += exercise.exercise.currentSets.length;
    }
    return totalSets.toString();
  }
}
