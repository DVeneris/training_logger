import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/exercise_options_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/enums/enums.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/models/workout.dart';
import 'package:training_tracker/providers/workout_creator_provider.dart';
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
    final workoutCreatorProvider = Provider.of<WorkoutCreatorProvider>(context);

    final provider = Provider.of<WorkoutProvider>(context);
    final workout = provider.workout;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Center(
            child: Text(workout!.name,
                style: const TextStyle(color: Colors.black))),
        leadingWidth: 60,
        leading: TextButton(
          style: TextButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 15,
              ),
              foregroundColor: Colors.blue),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Back"),
        ),
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
            crossAxisAlignment: CrossAxisAlignment.center,
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
                      workoutCreatorProvider.operationMode =
                          WorkoutCreatorOperationMode.create;
                      workoutCreatorProvider.initWorkout(workout);

                      Navigator.of(context)
                          .pushNamed(RouteGenerator.workoutCreator);
                    },
                    child: const Text(
                      "Make new workout",
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
