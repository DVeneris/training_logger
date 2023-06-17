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
  // List<ExerciseOptionsDTO> _workoutExerciseList = [];
  int _workoutTime = 0;
  int _totalWeight = 0;
  int _remainingTime = 10; //initial time in seconds
  late Timer _timer;
  late Timer _workoutDurationTimer;
  bool _isRunning = false;

  int _calculateTotalSetsAndWeight() {
    var totalWeight = 0;
    for (var e in widget.workout.exerciseList) {
      for (var s in e.exercise.currentSets) {
        if (s.isComplete && s.weight != null) {
          var weight = int.tryParse(s.weight!);
          weight = weight ?? 0;
          var reps = int.tryParse(s.reps!);
          reps = reps ?? 0;
          var volume = weight * reps;
          totalWeight = totalWeight + volume;
        }
      }
    }

    return totalWeight;
  }

  void _startWorkoutTimer() {
    setState(() {
      _workoutTime = 0;
    });
    _workoutDurationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _workoutTime++;
      });
    });
  }

  void _startTimer() {
    setState(() {
      _remainingTime = 10;
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
    _workoutDurationTimer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _startWorkoutTimer();
    if (widget.startUnset) {
      //var workout = widget.workout;
      //   exercise.exercise.sets = [];
      //   exercise.exercise.sets.add(ExerciseSet(isComplete: false));
      // } // for (var exercise in widget.workout.exerciseList) {
    }
    // for (var element in widget.workout.exerciseList) {
    //   var exercise = ExerciseDTO(
    //       id: element.exercise.id,
    //       unit: element.exercise.unit,
    //       name: element.exercise.name,
    //       userId: element.exercise.userId,
    //       mediaItem: element.exercise.mediaItem,
    //       equipment: element.exercise.equipment,
    //       exerciseGroup: element.exercise.exerciseGroup,
    //       previousSets: element.exercise.currentSets,
    //       currentSets: element.exercise.currentSets.map((e) {
    //         return ExerciseSet();
    //       }).toList());

    //   var options = ExerciseOptionsDTO(
    //       exercise: exercise, note: element.note, time: element.time);
    //   widget.workout.exerciseList.add(options);
    // }
    _totalWeight = _calculateTotalSetsAndWeight();
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
                widget.workout.totalTime = _workoutTime.toString();
                widget.workout.totalVolume = _totalWeight;
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
                Expanded(
                  child: widget.workout.exerciseList.isNotEmpty
                      ? ListView.builder(
                          itemCount: widget.workout.exerciseList.length,
                          itemBuilder: (context, index) {
                            List<Widget> result = [];
                            if (index == 0) {
                              var addToStart = [
                                Row(
                                  children: [
                                    Text(_workoutTime.toString()),
                                    const Text("----------------"),
                                    Text(_totalWeight.toString()),

                                    // Text('data'),
                                  ],
                                ),
                              ];
                              result.addAll(addToStart);
                            }
                            var addToBody = [
                              ExerciseSingle(
                                onSetChecked: (result) {
                                  _startCountdown();
                                  setState(() {
                                    _totalWeight =
                                        _calculateTotalSetsAndWeight();
                                  });
                                },
                                exercise:
                                    widget.workout.exerciseList[index].exercise,
                                onSelectParam: () {
                                  setState(() {});
                                },
                              )
                            ];
                            result.addAll(addToBody);
                            if (index ==
                                    widget.workout.exerciseList.length - 1 ||
                                widget.workout.exerciseList.length == 0) {
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
                                          setState(() {
                                            widget.workout.exerciseList
                                                .add(options);
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
                                  setState(() {
                                    widget.workout.exerciseList.add(options);
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
                ),
              ],
            ),
            if (_isRunning)
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
                                    var time = _remainingTime - 15;
                                    if (time <= 0) {
                                      setState(() {
                                        _isRunning = false;
                                      });
                                      _timer.cancel();
                                    } else {
                                      _remainingTime = time;
                                    }
                                  },
                                ),
                                Text(_remainingTime.toString()),
                                TextButton(
                                  child: const Text("+ 15"),
                                  onPressed: () {
                                    setState(() {
                                      _remainingTime += 15;
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
