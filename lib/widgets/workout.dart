import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../routes.dart';
import 'exercise.dart';

class SingleWorkout extends StatefulWidget {
  const SingleWorkout({super.key});

  @override
  State<SingleWorkout> createState() => _SingleWorkoutState();
}

class _SingleWorkoutState extends State<SingleWorkout> {
  var exerciseList = <ExerciseComplete>[
    ExerciseComplete(
        name: "Leg Extension (Mashine)",
        sets: [Set(isComplete: false)],
        exerciseGroup: 'Legs'),
    ExerciseComplete(
        name: "Leg Extension (Mashine)",
        sets: [Set(isComplete: false)],
        exerciseGroup: 'Legs'),
    ExerciseComplete(
        name: "Leg Extension (Mashine)",
        sets: [Set(isComplete: false)],
        exerciseGroup: 'Legs'),
    ExerciseComplete(
        name: "Leg Extension (Mashine)",
        sets: [Set(isComplete: false)],
        exerciseGroup: 'Legs'),
    ExerciseComplete(
        name: "Leg Extension (Mashine)",
        sets: [Set(isComplete: false)],
        exerciseGroup: 'Legs'),
    ExerciseComplete(
        name: "Leg Extension (Mashine)",
        sets: [Set(isComplete: false)],
        exerciseGroup: 'Legs'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
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
                  itemCount: exerciseList.length,
                  itemBuilder: (context, index) {
                    return ExerciseSingle(
                      exercise: exerciseList[index],
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
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(RouteGenerator.exerciseList);
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
  String? id;
  String? name;
  String? note;
  DateTime? createDate;
  DateTime? updateDate;
  List<Exercise>? exercises;
  int? totalTile;
  int? totalVolume;
}

class Exercise {
  String? id;
  final String name;
  String exerciseGroup;
  late final MediaItem mediaItem;

  Exercise({
    required this.name,
    required this.exerciseGroup, //mallon na ginei diko tou object: id, name, (media item?)
    MediaItem? mediaItem,
  }) {
    this.mediaItem = mediaItem ?? MediaItem();
  }
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
  bool? isComplete;
  Set({this.weight, this.reps, this.isComplete});
}

class ExerciseComplete extends Exercise {
  String? note;
  final List<Set> sets;
  ExerciseComplete(
      {required super.name, required this.sets, required super.exerciseGroup});
}
