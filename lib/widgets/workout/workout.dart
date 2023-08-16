import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/exercise_options_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/exercise_set.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/models/workout.dart';
import 'package:training_tracker/providers/workout_history_provider.dart';
import 'package:training_tracker/providers/workout_provider.dart';
import 'package:training_tracker/services/workout_service.dart';
import 'package:training_tracker/utils/workout_stats.dart';

import '../../routes.dart';
import 'exercise.dart';

class SingleWorkout extends StatefulWidget {
  const SingleWorkout({super.key});

  @override
  State<SingleWorkout> createState() => _SingleWorkoutState();
}

class _SingleWorkoutState extends State<SingleWorkout> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WorkoutProvider>(context);
    final workout = provider.workout;
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you want to cancel workout?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    provider.resetWorkout();
                    provider.stopWorkoutTimer();
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes, cancel!'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          title: Center(
              child: Text(workout!.name,
                  style: const TextStyle(color: Colors.black))),
          leadingWidth: 70,
          leading: TextButton(
            style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 15,
                ),
                foregroundColor: Colors.blue),
            onPressed: () {
              showDialog(
                  useRootNavigator: false,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Do you want to cancel workout?'),
                      actionsAlignment: MainAxisAlignment.spaceBetween,
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            provider.resetWorkout();

                            provider.stopWorkoutTimer();
                            Navigator.of(context).pop(true);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Yes, cancel!'),
                        ),
                      ],
                    );
                  });
            },
            child: const Text("Cancel"),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 15,
                    ),
                    foregroundColor: Colors.blue),
                onPressed: () async {
                  showDialog(
                      useRootNavigator: false,
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Save workout'),
                          content:
                              const Text('Do you want to save your progress?'),
                          actionsAlignment: MainAxisAlignment.spaceBetween,
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text('Cancel'),
                            ),
                            // TextButton(
                            //   onPressed: () async {
                            //     provider.stopWorkoutTimer();
                            //     await provider.createWorkoutHistory(() {
                            //       Navigator.of(context).pop(true);
                            //       Navigator.of(context).pop();
                            //     });
                            //   },
                            //   child: const Text('No, keep the old'),
                            // ),
                            TextButton(
                              onPressed: () async {
                                provider.totalWeight = 0;
                                provider.stopWorkoutTimer();
                                await provider.saveAndCreateWorkoutHistory(() {
                                  Navigator.of(context).pop(true);
                                  Navigator.of(context).pop();
                                });
                              },
                              child: const Text('Yes, Save'),
                            ),
                          ],
                        );
                      });
                },
                child: const Text("Finish"),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Stack(children: [
              Column(
                children: [
                  Expanded(
                    child: workout.exerciseList.isNotEmpty
                        ? ListView.builder(
                            itemCount: workout.exerciseList.length,
                            itemBuilder: (context, index) {
                              List<Widget> result = [];
                              if (index == 0) {
                                var addToStart = [
                                  const WorkoutStats(),
                                  Text(provider.workout!.note)
                                ];
                                result.addAll(addToStart);
                              }
                              var addToBody = [
                                ExerciseSingle(
                                  canTrain: true,
                                  onSetChecked: (result, setIndex) {
                                    provider.setExerciseSetCheckedAtIndex(
                                        workout.exerciseList[index],
                                        setIndex,
                                        result ?? false);
                                    if (result != null && result != false) {
                                      provider.checkExercise();
                                    }
                                  },
                                  exercise:
                                      workout.exerciseList[index].exercise,
                                  onExerciseDeletion: () {
                                    provider.deteteExercise(
                                        workout.exerciseList[index]);
                                  },
                                  onAddExerciseSet: () {
                                    provider.addExerciseSet(
                                        workout.exerciseList[index]);
                                  },
                                  onExerciseSetDeletion: (int setIndex) {
                                    provider.removeExerciseSetAtIndex(
                                        workout.exerciseList[index], setIndex);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('item dismissed')));
                                  },
                                )
                              ];
                              result.addAll(addToBody);
                              if (index == workout.exerciseList.length - 1 ||
                                  workout.exerciseList.isEmpty) {
                                var addToEnd = [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          // var exerciseToAdd = await Navigator.of(
                                          //             context)
                                          //         .pushNamed(
                                          //             RouteGenerator.exerciseList)
                                          //     as ExerciseDTO?;
                                          Navigator.of(context).pushNamed(
                                              RouteGenerator.exerciseList);

                                          // if (exerciseToAdd != null) {
                                          //   var options = ExerciseOptionsDTO(
                                          //       exercise: exerciseToAdd);

                                          //   workout.exerciseList.add(options);
                                          // }
                                        },
                                        child: const Text(
                                          "Add Exercise",
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //     TextButton(
                                  //       onPressed: () {
                                  //         provider.stopWorkoutTimer();
                                  //         // if (Navigator.of(context).canPop()) {
                                  //         Navigator.of(context).pop();
                                  //         // }
                                  //       },
                                  //       child: const Text(
                                  //         "Cancel Workout",
                                  //         style: TextStyle(
                                  //           color: Colors.redAccent,
                                  //           fontWeight: FontWeight.normal,
                                  //           fontSize: 15,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  const SizedBox(
                                    height: 100,
                                  )
                                ];
                                result.addAll(addToEnd);
                              }
                              return Column(
                                children: result,
                              );
                            },
                          )
                        : Column(
                            children: [
                              const WorkoutStats(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      var exerciseToAdd =
                                          await Navigator.of(context).pushNamed(
                                                  RouteGenerator.exerciseList)
                                              as ExerciseDTO?;
                                      if (exerciseToAdd != null) {
                                        var options = ExerciseOptionsDTO(
                                            exercise: exerciseToAdd);
                                        workout.exerciseList.add(options);
                                      }
                                    },
                                    child: const Text(
                                      "Add Exercise",
                                      style: TextStyle(
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
                  ),
                ],
              ),
              if (provider.isRunning)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 60.0),
                    child: Container(
                      color: const Color.fromARGB(255, 164, 204, 241),
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  child: const Text(
                                    "- 15",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    var time = provider.remainingTime - 15;
                                    if (time <= 0) {
                                      provider.isRunning = false;
                                      provider.stopTimer();
                                    } else {
                                      provider.remainingTime = time;
                                    }
                                  },
                                ),
                                Selector<WorkoutProvider, int>(
                                  selector: (_, service) =>
                                      service.remainingTime,
                                  builder: (context, time, child) {
                                    return Text(time.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ));
                                  },
                                  shouldRebuild: (previous, next) => true,
                                ),
                                TextButton(
                                  child: const Text("+ 15",
                                      style: TextStyle(
                                        fontSize: 20,
                                      )),
                                  onPressed: () {
                                    provider.remainingTime += 15;
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
            ]),
          ),
        ),
      ),
    );
  }
}
