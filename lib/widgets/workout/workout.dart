import 'dart:async';
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
import 'package:training_tracker/providers/exercise_provider.dart';
import 'package:training_tracker/services/workout_service.dart';

import '../../routes.dart';
import 'exercise.dart';

class SingleWorkout extends StatefulWidget {
  const SingleWorkout({super.key});

  @override
  State<SingleWorkout> createState() => _SingleWorkoutState();
}

class _SingleWorkoutState extends State<SingleWorkout> {
  // int _workoutTime = 0;
  // int _totalWeight = 0;
  // int _remainingTime = 10; //initial time in seconds
  // late Timer _timer;
  // late Timer _workoutDurationTimer;
  // bool _isRunning = false;

  // @override
  // void dispose() {
  //   _timer.cancel();
  //   _workoutDurationTimer.cancel();
  //   super.dispose();
  // }

  // @override
  // void initState() {
  //   super.initState();

  //   _startWorkoutTimer();
  //   // if (widget.startUnset) {
  //   //var workout = widget.workout;
  //   //   exercise.exercise.sets = [];
  //   //   exercise.exercise.sets.add(ExerciseSet(isComplete: false));
  //   // } // for (var exercise in widget.workout.exerciseList) {
  //   // }
  //   _totalWeight = _calculateTotalSetsAndWeight();
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExerciseProvider>(context);
    final workout = provider.workout;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Center(
            child: Text(workout.name, style: TextStyle(color: Colors.black))),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_downward,
            color: Colors.blue,
          ),
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
                workout.totalTime = provider.workoutTime.toString();
                workout.totalVolume = provider.totalWeight;
                await WorkoutService().updateWorkout(workout);
                Navigator.of(context).pop();
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
                                Row(
                                  children: [
                                    Text(provider.workoutTime.toString()),
                                    const Text("----------------"),
                                    Text(provider.totalWeight.toString()),

                                    // Text('data'),
                                  ],
                                ),
                              ];
                              result.addAll(addToStart);
                            }
                            var addToBody = [
                              ExerciseSingle(
                                onSetChecked: (result) {
                                  provider.checkExercise();
                                },
                                exercise: workout.exerciseList[index].exercise,
                                onSelectParam: () {},
                              )
                            ];
                            result.addAll(addToBody);
                            if (index == workout.exerciseList.length - 1 ||
                                workout.exerciseList.length == 0) {
                              var addToEnd = [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        var exerciseToAdd = await Navigator.of(
                                                    context)
                                                .pushNamed(
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        if (Navigator.of(context).canPop()) {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: const Text(
                                        "Cancel Workout",
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () async {
                                var exerciseToAdd = await Navigator.of(context)
                                        .pushNamed(RouteGenerator.exerciseList)
                                    as ExerciseDTO?;
                                if (exerciseToAdd != null) {
                                  var options = ExerciseOptionsDTO(
                                      exercise: exerciseToAdd);
                                  // setState(() {
                                  workout.exerciseList.add(options);
                                  // });
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
                                      setState(() {
                                        provider.isRunning = false;
                                      });
                                      provider.providerTimer.cancel();
                                    } else {
                                      provider.remainingTime = time;
                                    }
                                  },
                                ),
                                Text(provider.remainingTime.toString()),
                                TextButton(
                                  child: const Text("+ 15"),
                                  onPressed: () {
                                    setState(() {
                                      provider.remainingTime += 15;
                                    });
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
    );
  }
}
