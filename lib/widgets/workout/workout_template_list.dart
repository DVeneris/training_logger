import 'package:flutter/material.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/main.dart';
import 'package:training_tracker/models/enums/enums.dart';
import 'package:training_tracker/models/exercise_complete.dart';
import 'package:training_tracker/models/exercise_set.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/models/workout.dart';
import 'package:training_tracker/widgets/workout/workout.dart';

import '../../routes.dart';

class WorkoutTemplateList extends StatefulWidget {
  const WorkoutTemplateList({super.key});

  @override
  State<WorkoutTemplateList> createState() => _WorkoutTemplateListState();
}

class _WorkoutTemplateListState extends State<WorkoutTemplateList> {
  var workout = WorkoutDTO(
      id: "00001",
      userId: "00000",
      createDate: DateTime.now(),
      updateDate: DateTime.now(),
      name: "Mitsos",
      totalTime: "45 min",
      totalVolume: 5000,
      exerciseList: <ExerciseOptionsDTO>[
        // ExerciseDTO(
        //     id: "0001",
        //     userId: "00000", //default
        //     name: "Leg Extension (Mashine)1",
        //     sets: [ExerciseSet(isComplete: false)],
        //     exerciseGroup: ExerciseGroup.quadriceps),
        // ExerciseDTO(
        //     id: "0002",
        //     userId: "00000",
        //     name: "Leg Extension (Mashine)2",
        //     sets: [ExerciseSet(isComplete: false)],
        //     exerciseGroup: ExerciseGroup.quadriceps),
        // ExerciseDTO(
        //     id: "0003",
        //     userId: "00000",
        //     name: "Leg Extension (Mashine)3",
        //     sets: [ExerciseSet(isComplete: false)],
        //     exerciseGroup: ExerciseGroup.quadriceps),
        // ExerciseDTO(
        //     id: "0004",
        //     userId: "00000",
        //     name: "Leg Extension (Mashine)4",
        //     sets: [ExerciseSet(isComplete: false)],
        //     exerciseGroup: ExerciseGroup.quadriceps),
        // ExerciseDTO(
        //     id: "0005",
        //     userId: "00000",
        //     name: "Leg Extension (Mashine)5",
        //     sets: [ExerciseSet(isComplete: false)],
        //     exerciseGroup: ExerciseGroup.quadriceps),
        // ExerciseDTO(
        //     id: "0006",
        //     userId: "00000",
        //     name: "Leg Extension (Mashine)6",
        //     sets: [ExerciseSet(isComplete: false)],
        //     exerciseGroup: ExerciseGroup.quadriceps),
      ]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 60,
        title: const Center(
          child: Text("Workout",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              textAlign: TextAlign.center),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "My Templates",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: (() {
                  Navigator.of(context).pushNamed(
                    RouteGenerator.workoutCreator,
                  );
                }),
              )
            ],
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 120,
              maxHeight: 180,
            ),
            child: Card(
              color: Color.fromARGB(255, 235, 240, 249),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  workout.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Icon(Icons.more_horiz)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 45,
                                  child: ListView.builder(
                                    itemCount: workout.exerciseList.length >= 3
                                        ? 3
                                        : workout.exerciseList.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 3.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              workout.exerciseList[index]
                                                  .exercise.name,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                if (workout.exerciseList.length >= 3) ...[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          style: const TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                          "And ${workout.exerciseList.length - 3} more excersises",
                                        ),
                                      ],
                                    ),
                                  )
                                ]
                              ],
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () async {
                          await Navigator.of(context).pushNamed(
                            RouteGenerator.singleWorkout,
                            arguments: {'workout': workout},
                          ) as Workout?;
                        },
                        child: Text("Start"),
                      )
                    ]),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
