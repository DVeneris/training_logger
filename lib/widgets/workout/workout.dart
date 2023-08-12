import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/exercise_complete.dart';
import 'package:training_tracker/models/exercise_set.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/models/workout.dart';
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
              child: Text(workout.name, style: TextStyle(color: Colors.black))),
          leading: TextButton(
            style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 15,
                ),
                foregroundColor: Colors.blue),
            onPressed: () {
              showDialog(
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
                            provider.stopWorkoutTimer();
                            Navigator.of(context).pop(true);
                          },
                          child: const Text('Yes, cancel!'),
                        ),
                      ],
                    );
                  });
            },
            child: const Text("cancel"),
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
                  provider.stopWorkoutTimer();
                  workout.totalTime = provider.workoutTime.toString();
                  workout.totalVolume = provider.totalWeight;
                  await WorkoutService().updateWorkout(workout);
                  Navigator.of(context).pop(); //do sth
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
                                var addToStart = [const WorkoutStats()];
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
                      color: Color.fromARGB(255, 182, 182, 182),
                      height: 100,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  TextButton(
                                    child: const Text("- 15"),
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
                                      return Text(time.toString());
                                    },
                                    shouldRebuild: (previous, next) => true,
                                  ),
                                  TextButton(
                                    child: const Text("+ 15"),
                                    onPressed: () {
                                      provider.remainingTime += 15;
                                    },
                                  ),
                                ],
                              )
                            ],
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
