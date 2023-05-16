import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/exercise_complete.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/models/workout.dart';
import 'package:training_tracker/services/workout_service.dart';
import 'package:training_tracker/widgets/workout/workout.dart';

import '../../routes.dart';
import 'exercise.dart';

class SingleWorkoutCreator extends StatefulWidget {
  const SingleWorkoutCreator({super.key});

  @override
  State<SingleWorkoutCreator> createState() => _SingleWorkoutCreatorState();
}

class _SingleWorkoutCreatorState extends State<SingleWorkoutCreator> {
  var workout = WorkoutDTO(
      id: "0055",
      userId: "00000",
      name: "",
      createDate: DateTime.now(),
      updateDate: DateTime.now(),
      exerciseList: [],
      totalTime: "55 min",
      totalVolume: 5);
  final TextEditingController _workoutNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _workoutNameController.addListener(() => _onWorkoutNameChange());
  }

  _onWorkoutNameChange() {
    workout.name = _workoutNameController.text;
  }

  @override
  void dispose() {
    super.dispose();
    _workoutNameController.dispose();
  }

  Future<void> _handleRoutineSave() async {
    if (workout.name.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Empty Workout Name'),
            content: Text('Please enter a name for the workout.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
      return;
    }
    await WorkoutService().createWorkout(workout);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: const Center(
            child:
                Text("Create workout", style: TextStyle(color: Colors.black))),
        leading: TextButton(
          style: TextButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 15,
              ),
              foregroundColor: Colors.blue),
          onPressed: () {},
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
                await _handleRoutineSave();
              },
              child: const Text("Save"),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          //close keyboard on outside tap
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text("Exercise Name"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _workoutNameController,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: workout.exerciseList.length,
                  itemBuilder: (context, index) {
                    return ExerciseSingle(
                      onExerciseDeletion: () {
                        workout.exerciseList.removeAt(index);
                      },
                      exercise: workout.exerciseList[index].exercise,
                      canTrain: false,
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
                          workout.exerciseList
                              .add(ExerciseOptionsDTO(exercise: exerciseToAdd));
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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     TextButton(
              //       onPressed: () {
              //         if (Navigator.of(context).canPop()) {
              //           Navigator.of(context).pop();
              //         }
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
              // )
            ],
          ),
        ),
      ),
    );
  }
}
