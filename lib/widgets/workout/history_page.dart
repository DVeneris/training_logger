import 'package:flutter/material.dart';
import 'package:training_tracker/models/exercise-complete.dart';
import 'package:training_tracker/models/exercise-set.dart';
import 'package:training_tracker/models/workout.dart';
import 'package:training_tracker/widgets/workout/workout.dart';
import 'package:training_tracker/utils/workout_history_card.dart';
import 'package:training_tracker/widgets/workout/workout_overview.dart';

import '../../routes.dart';

class WorkoutHistory extends StatefulWidget {
  const WorkoutHistory({super.key});

  @override
  State<WorkoutHistory> createState() => _WorkoutHistoryState();
}

class _WorkoutHistoryState extends State<WorkoutHistory> {
  var workoutList = <Workout>[
    Workout(
        id: "00001",
        createDate: DateTime.now(),
        updateDate: DateTime.now(),
        name: "Mitsos",
        totalTime: "45 min",
        totalVolume: 5000,
        exercises: [
          ExerciseComplete(
              id: "0001",
              name: "Leg Extension (Mashine)1",
              sets: [
                ExerciseSet(reps: "15", weight: "25", isComplete: true),
                ExerciseSet(reps: "15", weight: "25", isComplete: true),
                ExerciseSet(reps: "15", weight: "25", isComplete: true)
              ],
              exerciseGroup: 'Legs'),
          ExerciseComplete(
              id: "0002",
              name: "Leg Extension (Mashine)2",
              sets: [
                ExerciseSet(reps: "15", weight: "25", isComplete: true),
                ExerciseSet(reps: "15", weight: "25", isComplete: true),
                ExerciseSet(reps: "15", weight: "25", isComplete: true)
              ],
              exerciseGroup: 'Legs'),
          ExerciseComplete(
              id: "0003",
              name: "Leg Extension (Mashine)3",
              sets: [
                ExerciseSet(reps: "15", weight: "25", isComplete: true),
                ExerciseSet(reps: "15", weight: "25", isComplete: true),
                ExerciseSet(reps: "15", weight: "25", isComplete: true)
              ],
              exerciseGroup: 'Legs'),
          ExerciseComplete(
              id: "0004",
              name: "Leg Extension (Mashine)4",
              sets: [
                ExerciseSet(reps: "15", weight: "25", isComplete: true),
                ExerciseSet(reps: "15", weight: "25", isComplete: true),
                ExerciseSet(reps: "15", weight: "25", isComplete: true)
              ],
              exerciseGroup: 'Legs'),
          ExerciseComplete(
              id: "0005",
              name: "Leg Extension (Mashine)5",
              sets: [
                ExerciseSet(reps: "15", weight: "25", isComplete: true),
                ExerciseSet(reps: "15", weight: "25", isComplete: true),
                ExerciseSet(reps: "15", weight: "25", isComplete: true)
              ],
              exerciseGroup: 'Legs'),
          ExerciseComplete(
              id: "0006",
              name: "Leg Extension (Mashine)6",
              sets: [
                ExerciseSet(reps: "15", weight: "25", isComplete: true),
                ExerciseSet(reps: "15", weight: "25", isComplete: true),
                ExerciseSet(reps: "15", weight: "25", isComplete: true)
              ],
              exerciseGroup: 'Legs'),
        ])
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: AppBar().preferredSize.height + 40,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        title: const TextField(
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 87, 171, 240),
              suffixIcon: Icon(Icons.search),
              hintText: "Search Data...",
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              hintStyle: TextStyle(
                color: Colors.white60,
              ),
            )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: workoutList.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                      height: 440,
                      child: GestureDetector(
                        onTap: () async {
                          await Navigator.of(context).pushNamed(
                            RouteGenerator.workoutOverview,
                            arguments: {'workout': workoutList[index]},
                          ) as Workout?;
                        },
                        child: HomeCard(
                          workout: workoutList[index],
                        ),
                      ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
