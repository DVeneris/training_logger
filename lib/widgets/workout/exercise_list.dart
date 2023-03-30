import 'package:flutter/material.dart';
import 'package:training_tracker/utils/simpleExerciseTile.dart';
import 'package:training_tracker/widgets/workout/workout.dart';

class ExcerciseList extends StatefulWidget {
  const ExcerciseList({super.key});

  @override
  State<ExcerciseList> createState() => _ExcerciseListState();
}

class _ExcerciseListState extends State<ExcerciseList> {
  var exerciseCompleteList = <ExerciseComplete>[
    ExerciseComplete(
        id: "0001",
        name: "Leg Extension (Mashine)1",
        sets: [Set(isComplete: false)],
        exerciseGroup: 'Legs'),
    ExerciseComplete(
        id: "0002",
        name: "Leg Extension (Mashine)2",
        sets: [Set(isComplete: false)],
        exerciseGroup: 'Legs'),
    ExerciseComplete(
        id: "0003",
        name: "Leg Extension (Mashine)3",
        sets: [Set(isComplete: false)],
        exerciseGroup: 'Legs'),
    ExerciseComplete(
        id: "0004",
        name: "Leg Extension (Mashine)4",
        sets: [Set(isComplete: false)],
        exerciseGroup: 'Legs'),
    ExerciseComplete(
        id: "0005",
        name: "Leg Extension (Mashine)5",
        sets: [Set(isComplete: false)],
        exerciseGroup: 'Legs'),
    ExerciseComplete(
        id: "0006",
        name: "Leg Extension (Mashine)6",
        sets: [Set(isComplete: false)],
        exerciseGroup: 'Legs'),
  ];

  var exerciseList = <Exercise>[
    Exercise(
      id: "0001",
      exerciseGroup: "legs",
      name: "Leg Extension (Mashine)1",
      mediaItem: MediaItem(),
    ),
    Exercise(
      id: "0002",
      exerciseGroup: "legs",
      name: "Leg Extension (Mashine)2",
      mediaItem: MediaItem(),
    ),
    Exercise(
      id: "0003",
      exerciseGroup: "legs",
      name: "Leg Extension (Mashine)3",
      mediaItem: MediaItem(),
    ),
    Exercise(
      id: "0004",
      exerciseGroup: "legs",
      name: "Leg Extension (Mashine)4",
      mediaItem: MediaItem(),
    ),
    Exercise(
      id: "0005",
      exerciseGroup: "legs",
      name: "Leg Extension (Mashine)5",
      mediaItem: MediaItem(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 60,
        leading: TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Center(
          child: Text("Add Exercise",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              textAlign: TextAlign.center),
        ),
        actions: [
          TextButton(
            child: const Text("Create"),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Search exercise',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Recent Exercises",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Colors.grey),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      // print(exerciseList[index].id);
                      var exerciseComplete = exerciseCompleteList.where(
                          (element) => element.id == exerciseList[index].id);
                      Navigator.of(context).pop(exerciseComplete.first);
                    },
                    child: SimpleExerciseTile(exercise: exerciseList[index]));
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: exerciseList.length,
            ),
          )
        ]),
      ),
    );
  }
}
