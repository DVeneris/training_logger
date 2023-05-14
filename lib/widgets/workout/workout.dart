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
  late Timer _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
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
        exercise.sets = [];
        exercise.sets.add(ExerciseSet(isComplete: false));
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
              onPressed: () {},
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
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  startTimer();
                },
                child: Text("start"),
              ),
              Text("$_start"),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.workout.exerciseList.length,
                  itemBuilder: (context, index) {
                    return ExerciseSingle(
                      exercise: widget.workout.exerciseList[index],
                      onSelectParam: () {
                        setState(() {});
                      },
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      var exerciseToAdd = await Navigator.of(context)
                              .pushNamed(RouteGenerator.exerciseList)
                          as ExerciseDTO?;
                      if (exerciseToAdd != null) {
                        setState(() {
                          widget.workout.exerciseList.add(exerciseToAdd);
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
