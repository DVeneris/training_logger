import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:training_tracker/widgets/workout/workout.dart';

import '../../routes.dart';
import 'exercise.dart';

class SingleWorkoutCreator extends StatefulWidget {
  const SingleWorkoutCreator({super.key});

  @override
  State<SingleWorkoutCreator> createState() => _SingleWorkoutCreatorState();
}

class _SingleWorkoutCreatorState extends State<SingleWorkoutCreator> {
  var workout = Workout(
      id: "0055",
      name: "",
      createDate: DateTime.now(),
      updateDate: DateTime.now(),
      exercises: [],
      totalTime: "55 min",
      totalVolume: 5);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: const Center(
            child: Text("Create new workout",
                style: TextStyle(color: Colors.black))),
        leading: TextButton(
          style: TextButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 15,
              ),
              foregroundColor: Colors.blue),
          onPressed: () {},
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
              onPressed: () {
                print(workout);
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
              Expanded(
                child: ListView.builder(
                  itemCount: workout.exercises.length,
                  itemBuilder: (context, index) {
                    return ExerciseSingle(
                      exercise: workout.exercises[index],
                      canTrain: false,
                      onSelectParam: () {
                        setState(() {});
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
                      var lele = await Navigator.of(context)
                              .pushNamed(RouteGenerator.exerciseList)
                          as ExerciseComplete?;
                      if (lele != null) {
                        setState(() {
                          workout.exercises.add(lele);
                        });
                      }
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text(
                      "Cancel Workout",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
