import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/enums/enums.dart';
import 'package:training_tracker/providers/workout_creator_provider.dart';
import 'package:training_tracker/providers/workout_provider.dart';
import 'package:training_tracker/providers/workout_template_list_provider.dart';
import 'package:training_tracker/routes.dart';
import 'package:training_tracker/utils/popupMenuButton.dart';
import 'package:training_tracker/widgets/workout/workout_template_list.dart';

class RoutineListCard extends StatelessWidget {
  final WorkoutDTO workout;
  final Function onDelete;

  const RoutineListCard(
      {super.key, required this.workout, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final workoutProvider =
        Provider.of<WorkoutProvider>(context, listen: false);
    final workoutCreatorProvider = Provider.of<WorkoutCreatorProvider>(context);

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 120,
        maxHeight: 210,
      ),
      child: Card(
        color: const Color.fromARGB(255, 235, 240, 249),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
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
                          CustomPopupMenuButton(
                            operation: PopupOperationOptions.both,
                            onItemSelection: ((option) {
                              if (option == PopUpOptions.delete) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Delete Workout'),
                                      content: const Text(
                                          'Are you sure you want to delete this wrkout?'),
                                      actions: [
                                        TextButton(
                                          child: const Text('No'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Yes, Delete'),
                                          onPressed: () async {
                                            workoutProvider.workout = workout;
                                            await workoutProvider
                                                .deleteWorkout(() async {
                                              onDelete();
                                              Navigator.of(context).pop(true);
                                            });
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                              if (option == PopUpOptions.edit) {
                                workoutCreatorProvider.operationMode =
                                    WorkoutCreatorOperationMode.edit;
                                workoutCreatorProvider.initWorkout(workout);
                                Navigator.of(context)
                                    .pushNamed(RouteGenerator.workoutCreator);
                              }
                            }),
                          )
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
                          if (workout.exerciseList.length > 3) ...[
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
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
                    workoutProvider.initWorkout(workout);

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
