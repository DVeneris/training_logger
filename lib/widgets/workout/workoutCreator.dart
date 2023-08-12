import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/exercise_complete.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/models/workout.dart';
import 'package:training_tracker/providers/exercise_list_provider.dart';
import 'package:training_tracker/providers/workout_creator_provider.dart';
import 'package:training_tracker/providers/workout_template_list_provider.dart';
import 'package:training_tracker/services/auth.dart';
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
  // var workout = WorkoutDTO(
  //     userId: AuthService().getUser()!.uid, //na ginei me DI
  //     name: "",
  //     createDate: DateTime.now(),
  //     updateDate: DateTime.now(),
  //     exerciseList: [],
  //     totalTime: "0",
  //     totalVolume: 5);
  final TextEditingController _workoutNameController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _workoutNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final workoutListProvider =
        Provider.of<WorkoutTemplateListProvider>(context);
    final provider = Provider.of<WorkoutCreatorProvider>(context);
    final workout = provider.workout;

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
          onPressed: () {
            Navigator.of(context).pop();
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
                if (workout.name.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Empty Workout Name'),
                        content:
                            const Text('Please enter a name for the workout.'),
                        actions: [
                          TextButton(
                            child: const Text('OK'),
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
                await provider.createWorkout(() {
                  workoutListProvider.addToList(workout);
                  Navigator.of(context).pop();
                });
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
                child: Text("Routune Name"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _workoutNameController,
                  onChanged: (value) {
                    workout.name = value;
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: workout.exerciseList.length,
                  itemBuilder: (context, index) {
                    return ExerciseSingle(
                      exercise: workout.exerciseList[index].exercise,
                      onExerciseDeletion: () {
                        provider.deteteExercise(workout.exerciseList[index]);
                      },
                      onAddExerciseSet: () {
                        provider.addExerciseSet(workout.exerciseList[index]);
                      },
                      onExerciseSetDeletion: (int setIndex) {
                        provider.removeExerciseSetAtIndex(
                            workout.exerciseList[index], setIndex);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('item dismissed')));
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
                      Provider.of<ExerciseListProvider>(context, listen: false)
                          .calledByCreator = true;
                      await Navigator.of(context)
                              .pushNamed(RouteGenerator.exerciseList)
                          as ExerciseDTO?;
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
      ),
    );
  }
}
