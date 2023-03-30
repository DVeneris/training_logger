import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../routes.dart';
import 'exercise.dart';

class SingleWorkout extends StatefulWidget {
  final Workout workout;
  late bool startUnset;
  SingleWorkout({super.key, required this.workout, bool? startUnset}) {
    this.startUnset = startUnset ?? true;
  }

  @override
  State<SingleWorkout> createState() => _SingleWorkoutState();
}

class _SingleWorkoutState extends State<SingleWorkout> {
  @override
  void initState() {
    super.initState();
    if (widget.startUnset) {
      //var workout = widget.workout;
      for (var exercise in widget.workout.exercises) {
        exercise.sets = [];
        exercise.sets.add(Set(isComplete: false));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Center(
            child: Text(widget.workout.name,
                style: TextStyle(color: Colors.black))),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_downward,
            color: Colors.blue,
          ),
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
              onPressed: () {},
              child: const Text("Finish"),
            ),
          ),
        ],
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
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widget.workout.exercises.length,
                  itemBuilder: (context, index) {
                    return ExerciseSingle(
                      exercise: widget.workout.exercises[index],
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
                          widget.workout.exercises.add(lele);
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

class Workout {
  final String id;
  final String name;
  final String? note;
  final DateTime createDate;
  DateTime updateDate;
  List<ExerciseComplete> exercises;
  final String totalTime;
  final int totalVolume;

  Workout({
    required this.id,
    required this.name,
    this.note,
    required this.createDate,
    required this.updateDate,
    required this.exercises,
    required this.totalTime,
    required this.totalVolume,
  });
  //  : assert(exercises.isNotEmpty),
  //      assert(totalTile >= 0),
  //      assert(totalVolume >= 0) {
  //        updateDate = updateDate.toUtc();
  //      }
}

class Exercise {
  final String id;
  String name;
  String exerciseGroup;
  MediaItem mediaItem;

  Exercise({
    required this.id,
    required this.name,
    required this.exerciseGroup,
    MediaItem? mediaItem,
  }) : mediaItem = mediaItem ?? MediaItem();
}

class MediaItem {
  //String? id;
  String? name;
  late String url;
  MediaItem({String? url}) {
    this.url = url ?? "assets/no_media.png";
  }
}

class Set {
  // final int setNumber;
  String? weight;
  String? reps;
  late bool isComplete;
  Set({this.weight, this.reps, bool? isComplete}) {
    this.isComplete = isComplete ?? false;
  }
}

class ExerciseComplete extends Exercise {
  String? note;
  List<Set> sets;

  ExerciseComplete(
      {required super.id,
      required super.name,
      required this.sets,
      required super.exerciseGroup});
}
