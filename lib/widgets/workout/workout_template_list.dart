import 'package:flutter/material.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/main.dart';
import 'package:training_tracker/models/enums/enums.dart';
import 'package:training_tracker/models/exercise_complete.dart';
import 'package:training_tracker/models/exercise_set.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/models/workout.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/workout_service.dart';
import 'package:training_tracker/utils/routine_list_card.dart';
import 'package:training_tracker/widgets/workout/workout.dart';

import '../../routes.dart';

class WorkoutTemplateList extends StatefulWidget {
  const WorkoutTemplateList({super.key});

  @override
  State<WorkoutTemplateList> createState() => _WorkoutTemplateListState();
}

class _WorkoutTemplateListState extends State<WorkoutTemplateList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<WorkoutDTO>>(
        future:
            WorkoutService().getWorkoutList(userId: AuthService().user!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            //loading icon
            return const Text(
              'loading',
              textDirection: TextDirection.ltr,
            );
          } else if (snapshot.hasError) {
            return const Text(
              'error in snapshot',
              textDirection: TextDirection.ltr,
            );
            //show error
          } else if (snapshot.hasData) {
            var workoutList = snapshot.data!;
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
                        onPressed: (() async {
                          await Navigator.of(context).pushNamed(
                            RouteGenerator.workoutCreator,
                          );
                          setState(() {});
                        }),
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  RouteGenerator.singleWorkout,
                                  arguments: {'workout': workoutList[index]},
                                );
                              },
                              child:
                                  RoutineListCard(workout: workoutList[index]));
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: workoutList.length),
                  )
                ]),
              ),
            );
          } else {
            //no data found
            return const Text(
              'no data',
              textDirection: TextDirection.ltr,
            );
          }
        });
  }
}
