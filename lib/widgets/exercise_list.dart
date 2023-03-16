import 'package:flutter/material.dart';
import 'package:training_tracker/widgets/simpleExerciseTile.dart';
import 'package:training_tracker/widgets/workout.dart';

class ExcerciseList extends StatefulWidget {
  const ExcerciseList({super.key});

  @override
  State<ExcerciseList> createState() => _ExcerciseListState();
}

class _ExcerciseListState extends State<ExcerciseList> {
  var exerciseList = <Exercise>[
    Exercise(
      exerciseGroup: "legs",
      name: "Leg Extension (Mashine)",
      mediaItem: MediaItem(),
    ),
    Exercise(
      exerciseGroup: "legs",
      name: "Leg Extension (Mashine)",
      mediaItem: MediaItem(),
    ),
    Exercise(
      exerciseGroup: "legs",
      name: "Leg Extension (Mashine)",
      mediaItem: MediaItem(),
    ),
    Exercise(
      exerciseGroup: "legs",
      name: "Leg Extension (Mashine)",
      mediaItem: MediaItem(),
    ),
    Exercise(
      exerciseGroup: "legs",
      name: "Leg Extension (Mashine)",
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
          onPressed: () {},
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
                  child: SimpleExerciseTile(exercise: exerciseList[index]),
                  onDoubleTap: () {},
                );
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
