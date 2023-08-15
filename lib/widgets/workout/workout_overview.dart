import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/exercise_complete.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/models/workout.dart';
import 'package:training_tracker/providers/workout_provider.dart';
import 'package:training_tracker/widgets/workout/workout.dart';

import '../../routes.dart';
import '../../utils/exercise_overview.dart';
import 'exercise.dart';

class WorkoutOverView extends StatefulWidget {
  const WorkoutOverView({super.key});
  @override
  State<WorkoutOverView> createState() => _WorkoutOverViewState();
}

class _WorkoutOverViewState extends State<WorkoutOverView> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WorkoutProvider>(context);
    final workout = provider.workout;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Center(
            child: Text(workout!.name,
                style: const TextStyle(color: Colors.black))),
        leading: TextButton(
          style: TextButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 15,
              ),
              foregroundColor: Colors.blue),
          onPressed: () {},
          child: const Text("cancel"),
        ),
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
              Expanded(
                child: ListView.builder(
                  itemCount: workout.exerciseList.length,
                  itemBuilder: (context, index) {
                    return ExerciseOverviewSingle(
                      exercise: workout.exerciseList[index].exercise,
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
                    child: GestureDetector(
                      onTap: () async {
                        await Navigator.of(context).pushNamed(
                          RouteGenerator.singleWorkout,
                        ) as Workout?;
                      },
                      child: const Text(
                        "Edit Workout",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
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
