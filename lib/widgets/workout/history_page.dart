import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/DTOS/workout_history_dto.dart';
import 'package:training_tracker/models/enums/enums.dart';
import 'package:training_tracker/models/exercise_set.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/models/workout.dart';
import 'package:training_tracker/providers/user_provider.dart';
import 'package:training_tracker/providers/workout_history_provider.dart';
import 'package:training_tracker/providers/workout_provider.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/workout_history_service.dart';
import 'package:training_tracker/widgets/workout/workout.dart';
import 'package:training_tracker/utils/workout_history_card.dart';
import 'package:training_tracker/widgets/workout/workout_overview.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../routes.dart';

class WorkoutHistory extends StatefulWidget {
  const WorkoutHistory({super.key});

  @override
  State<WorkoutHistory> createState() => _WorkoutHistoryState();
}

class _WorkoutHistoryState extends State<WorkoutHistory> {
  @override
  Widget build(BuildContext context) {
    final workoutHistoryProvider =
        Provider.of<WorkoutHistoryProvider>(context, listen: false);
    final workoutProvider = Provider.of<WorkoutProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          toolbarHeight: AppBar().preferredSize.height + 20,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          title: Text("Welcome ${userProvider.user.userName}")),
      body: FutureBuilder<List<WorkoutHistoryDTO>>(
          future: workoutHistoryProvider.getWorkoutHistoryList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.blue,
                  size: 100,
                ),
              );
            } else if (snapshot.hasError) {
              return const Text(
                'error in snapshot',
                textDirection: TextDirection.ltr,
              );
            } else if (snapshot.hasData) {
              var workoutHistoryList = snapshot.data!;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    workoutHistoryList.isEmpty
                        ? const Center(
                            child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              "We couldn't find any workout history. Please start a new workout and see your progress now.",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.blue,
                              ),
                            ),
                          ))
                        : Expanded(
                            child: ListView.builder(
                              itemCount: workoutHistoryList.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                    height: 440,
                                    child: GestureDetector(
                                      onTap: () async {
                                        workoutProvider.workout = _toWorkoutDTO(
                                            workoutHistoryList[index]);
                                        await Navigator.of(context).pushNamed(
                                          RouteGenerator.workoutOverview,
                                        );
                                      },
                                      child: HomeCard(
                                        workoutHistory:
                                            workoutHistoryList[index],
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

  WorkoutDTO? _toWorkoutDTO(WorkoutHistoryDTO workoutHistory) {
    return WorkoutDTO(
      exerciseList: workoutHistory.exerciseList,
      name: workoutHistory.workoutName,
      note: workoutHistory.note,
    );
  }
}
