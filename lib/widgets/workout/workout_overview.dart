import 'package:flutter/material.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/exercise_complete.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/models/workout.dart';
import 'package:training_tracker/widgets/workout/workout.dart';

import '../../routes.dart';
import '../../utils/exercise_overview.dart';
import 'exercise.dart';

class WorkoutOverView extends StatefulWidget {
  final WorkoutDTO workout;
  const WorkoutOverView({super.key, required this.workout});

  @override
  State<WorkoutOverView> createState() => _WorkoutOverViewState();
}

class _WorkoutOverViewState extends State<WorkoutOverView> {
  // final workout = Workout(
  //     id: "00001",
  //     createDate: DateTime.now(),
  //     updateDate: DateTime.now(),
  //     name: "Mitsos",
  //     totalTime: "45 min",
  //     totalVolume: 5000,
  //     exercises: [
  //       ExerciseComplete(
  //           id: "0001",
  //           name: "Leg Extension (Mashine)1",
  //           sets: [
  //             Set(reps: "15", weight: "25", isComplete: true),
  //             Set(reps: "15", weight: "25", isComplete: true),
  //             Set(reps: "15", weight: "25", isComplete: true)
  //           ],
  //           exerciseGroup: 'Legs'),
  //       ExerciseComplete(
  //           id: "0002",
  //           name: "Leg Extension (Mashine)2",
  //           sets: [
  //             Set(reps: "15", weight: "25", isComplete: true),
  //             Set(reps: "15", weight: "25", isComplete: true),
  //             Set(reps: "15", weight: "25", isComplete: true)
  //           ],
  //           exerciseGroup: 'Legs'),
  //       ExerciseComplete(
  //           id: "0003",
  //           name: "Leg Extension (Mashine)3",
  //           sets: [
  //             Set(reps: "15", weight: "25", isComplete: true),
  //             Set(reps: "15", weight: "25", isComplete: true),
  //             Set(reps: "15", weight: "25", isComplete: true)
  //           ],
  //           exerciseGroup: 'Legs'),
  //       ExerciseComplete(
  //           id: "0004",
  //           name: "Leg Extension (Mashine)4",
  //           sets: [
  //             Set(reps: "15", weight: "25", isComplete: true),
  //             Set(reps: "15", weight: "25", isComplete: true),
  //             Set(reps: "15", weight: "25", isComplete: true)
  //           ],
  //           exerciseGroup: 'Legs'),
  //       ExerciseComplete(
  //           id: "0005",
  //           name: "Leg Extension (Mashine)5",
  //           sets: [
  //             Set(reps: "15", weight: "25", isComplete: true),
  //             Set(reps: "15", weight: "25", isComplete: true),
  //             Set(reps: "15", weight: "25", isComplete: true)
  //           ],
  //           exerciseGroup: 'Legs'),
  //       ExerciseComplete(
  //           id: "0006",
  //           name: "Leg Extension (Mashine)6",
  //           sets: [
  //             Set(reps: "15", weight: "25", isComplete: true),
  //             Set(reps: "15", weight: "25", isComplete: true),
  //             Set(reps: "15", weight: "25", isComplete: true)
  //           ],
  //           exerciseGroup: 'Legs'),
  //     ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Center(
            child: Text(widget.workout.name,
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
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: TextButton(
        //       style: TextButton.styleFrom(
        //           textStyle: const TextStyle(
        //             fontSize: 15,
        //           ),
        //           foregroundColor: Colors.blue),
        //       onPressed: () {
        //         print(workout);
        //       },
        //       child: const Text("Save"),
        //     ),
        //   ),
        // ],
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
                  itemCount: widget.workout.exerciseList.length,
                  itemBuilder: (context, index) {
                    return ExerciseOverviewSingle(
                      exercise: widget.workout.exerciseList[index],
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
                    child: GestureDetector(
                      onTap: () async {
                        await Navigator.of(context).pushNamed(
                          RouteGenerator.singleWorkout,
                          arguments: {'workout': widget.workout},
                        ) as Workout?;
                      },
                      child: Text(
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
