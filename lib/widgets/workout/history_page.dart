import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/DTOS/workout_history_dto.dart';
import 'package:training_tracker/models/enums/enums.dart';
import 'package:training_tracker/models/exercise_complete.dart';
import 'package:training_tracker/models/exercise_set.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/models/workout.dart';
import 'package:training_tracker/providers/workout_history_provider.dart';
import 'package:training_tracker/providers/workout_provider.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/workout_history_service.dart';
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
  @override
  Widget build(BuildContext context) {
    final workoutHistoryProvider = Provider.of<WorkoutHistoryProvider>(context);
    final workoutProvider = Provider.of<WorkoutProvider>(context);

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
      body: FutureBuilder<List<WorkoutHistoryDTO>>(
          future: workoutHistoryProvider.getWorkoutHistoryList(),
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
              var workoutHistoryList = snapshot.data!;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: workoutHistoryList.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                              height: 440,
                              child: GestureDetector(
                                onTap: () async {
                                  // workoutProvider.workout =
                                  //     _toWorkoutDTO(workoutHistoryList[index]);
                                  await Navigator.of(context).pushNamed(
                                    RouteGenerator.workoutOverview,
                                  );
                                },
                                child: HomeCard(
                                  workoutHistory: workoutHistoryList[index],
                                ),
                              ));
                        },
                      ),
                    )
                  ],
                ),
              );
            } else {
              //no data found
              return const Text(
                'no data',
                textDirection: TextDirection.ltr,
              );
            }
          }),
    );
  }

  // WorkoutDTO _toWorkoutDTO(WorkoutHistoryDTO workoutHistoryDto) {
  //   return WorkoutDTO(userId: workoutHistoryDto.userId, exerciseList: workoutHistoryDto.exerciseList)
  // }
}
