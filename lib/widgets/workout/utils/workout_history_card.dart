import 'package:flutter/material.dart';
import 'package:training_tracker/widgets/workout/workout.dart';

import '../../../routes.dart';

class HomeCard extends StatelessWidget {
  final Workout workout;
  HomeCard({super.key, required this.workout}) {
    int totalSets = 0;

    for (var exercise in workout.exercises) {
      totalSets += exercise.sets.length;
    }
    print('Total sets: $totalSets');
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 10.0,
        right: 10.0,
      ),
      child: Card(
        color: Color.fromARGB(255, 206, 229, 250),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 201, 78, 223),
                  maxRadius: 20,
                  minRadius: 10,
                  child: Text(
                    "D",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Dveneris",
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "333 days ago",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    workout.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                    dataRowHeight: 25,
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
                          DataCell(Text(workout.totalTime)),
                          DataCell(Text('${workout.totalVolume} kg')),
                          DataCell(
                              Text(_calculateTotalSets(workout.exercises))),
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
                  itemCount: workout.exercises.length.clamp(0, 3),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("${workout.exercises[index].sets.length} x  "),
                          CircleAvatar(
                            maxRadius: 20,
                            minRadius: 10,
                            backgroundImage: AssetImage(
                                workout.exercises[index].mediaItem.url),
                            backgroundColor: Colors.transparent,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(workout.exercises[index].name),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            if (workout.exercises.length >= 3) ...[
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          "And ${workout.exercises.length - 3} more excersises",
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

  String _calculateTotalSets(List<ExerciseComplete>? exercises) {
    int totalSets = 0;

    for (var exercise in exercises!) {
      totalSets += exercise.sets.length;
    }
    return totalSets.toString();
  }
}
