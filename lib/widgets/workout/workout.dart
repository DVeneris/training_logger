import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/exercise_complete.dart';
import 'package:training_tracker/models/exercise_set.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/models/workout.dart';
import 'package:training_tracker/services/workout_service.dart';

import '../../routes.dart';
import 'exercise.dart';

class SingleWorkout extends StatefulWidget {
  final WorkoutDTO workout;
  late bool startUnset;
  SingleWorkout({super.key, required this.workout, bool? startUnset}) {
    this.startUnset = startUnset ?? true;
  }

  @override
  State<SingleWorkout> createState() => _SingleWorkoutState();
}

class _SingleWorkoutState extends State<SingleWorkout> {
  int _remainingTime = 10; //initial time in seconds
  late Timer _timer;
  bool _isRunning = false;

  void _startTimer() {
    setState(() {
      _remainingTime = 10;
      _isRunning = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer.cancel();
          _isRunning = false;
        }
      });
    });
  }

  void _startCountdown() {
    if (_isRunning) {
      _cancelTimer();
    }
    _startTimer();
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
    });
    _timer.cancel();
  }

  void _cancelTimer() {
    setState(() {
      _isRunning = false;
      _remainingTime = 10;
    });
    _timer.cancel();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.startUnset) {
      //var workout = widget.workout;
      for (var exercise in widget.workout.exerciseList) {
        exercise.exercise.sets = [];
        exercise.exercise.sets.add(ExerciseSet(isComplete: false));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Center(
            child: Text(widget.workout.name,
                style: TextStyle(color: Colors.black))),
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
                await WorkoutService().updateWorkout(widget.workout);
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
                ElevatedButton(
                  child: Text(_isRunning ? "Stop" : "Start"),
                  onPressed: _isRunning ? _stopTimer : _startTimer,
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  child: Text("Cancel"),
                  onPressed: _cancelTimer,
                ),
                Text("$_remainingTime "),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.workout.exerciseList.length,
                    itemBuilder: (context, index) {
                      Widget result;
                      if (index == widget.workout.exerciseList.length - 1) {
                        result = Column(children: [
                          ExerciseSingle(
                            exercise:
                                widget.workout.exerciseList[index].exercise,
                            onSetChecked: (result) {
                              _startCountdown();
                            },
                            onSelectParam: () {
                              setState(() {});
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  var exerciseToAdd =
                                      await Navigator.of(context).pushNamed(
                                              RouteGenerator.exerciseList)
                                          as ExerciseDTO?;
                                  if (exerciseToAdd != null) {
                                    setState(() {
                                      widget.workout.exerciseList.add(
                                          ExerciseOptionsDTO(
                                              exercise: exerciseToAdd));
                                    });
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
                        ]);
                      } else {
                        result = ExerciseSingle(
                          onSetChecked: (result) {
                            // _startCountdown();
                          },
                          exercise: widget.workout.exerciseList[index].exercise,
                          onSelectParam: () {
                            setState(() {});
                          },
                        );
                      }
                      return result;
                    },
                  ),
                ),
              ],
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Padding(
            //     padding: const EdgeInsets.only(bottom: 60.0),
            //     child: Container(
            //       color: Colors.white,
            //       height: 100,
            //       child: Row(
            //         children: [
            //           Column(
            //             children: [
            //               Row(
            //                 children: [
            //                   TextButton(
            //                     child: const Text("- 15"),
            //                     onPressed: () {},
            //                   ),
            //                   Text("40"),
            //                   TextButton(
            //                     child: const Text("+ 15"),
            //                     onPressed: () {},
            //                   ),
            //                 ],
            //               )
            //             ],
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // )
          ]),
        ),
      ),
    );
  }
}
