import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/providers/workout_provider.dart';
import 'package:training_tracker/routes.dart';

class RoutineListCard extends StatelessWidget {
  final WorkoutDTO workout;
  const RoutineListCard({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WorkoutProvider>(context, listen: false);
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 120,
        maxHeight: 180,
      ),
      child: Card(
        color: const Color.fromARGB(255, 235, 240, 249),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            workout.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const Icon(Icons.more_horiz)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 45,
                            child: ListView.builder(
                              itemCount: workout.exerciseList.length >= 3
                                  ? 3
                                  : workout.exerciseList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 3.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        workout
                                            .exerciseList[index].exercise.name,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          if (workout.exerciseList.length >= 3) ...[
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: [
                                  Text(
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                    "And ${workout.exerciseList.length - 3} more excersises",
                                  ),
                                ],
                              ),
                            )
                          ]
                        ],
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    provider.workout = workout;
                    provider.startWorkoutTimer();
                    Navigator.of(context)
                        .pushNamed(RouteGenerator.singleWorkout);
                  },
                  child: const Text("Start"),
                )
              ]),
        ),
      ),
    );
  }
}
