import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/enums/enums.dart';
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

class SingleWorkoutCreator extends StatelessWidget {
  const SingleWorkoutCreator({super.key});

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
        title: Center(
            child: provider.operationMode == WorkoutCreatorOperationMode.create
                ? const Text("Create workout",
                    style: TextStyle(color: Colors.black))
                : const Text("Edit workout",
                    style: TextStyle(color: Colors.black))),
        leadingWidth: 60,
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
                          Navigator.of(context).pop(true);
                          Navigator.of(context).pop();
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
                              provider.resetWorkout();
                              Navigator.of(context).pop(); // Close the dialog
                            },
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }
                provider.operationMode == WorkoutCreatorOperationMode.create
                    ? await provider.createWorkout(() {
                        workoutListProvider.addToList(provider.workout);
                        Navigator.of(context).pop();
                      })
                    : await provider.updateWorkout(() {
                        workoutListProvider.getWorkoutList();
                        Navigator.of(context).pop();
                      });
              },
              child: const Text("Save"),
            ),
          ),
        ],
      ),
      body: WillPopScope(
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
        child: Padding(
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Text("Workout Name"),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    initialValue: workout.name,
                    onChanged: (value) {
                      workout.name = value;
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Text("Workout notes"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: TextFormField(
                    maxLines: 2,
                    initialValue: workout.note,
                    onChanged: (value) {
                      workout.note = value;
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
                        Provider.of<ExerciseListProvider>(context,
                                listen: false)
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
      ),
    );
  }
}
