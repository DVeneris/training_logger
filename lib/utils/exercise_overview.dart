import 'package:flutter/material.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/models/exercise_set.dart';

import '../widgets/workout/workout.dart';

class ExerciseOverviewSingle extends StatelessWidget {
  final ExerciseDTO exercise;

  const ExerciseOverviewSingle({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    exercise.mediaItem != null
                        ? ClipOval(
                            child: Image.network(
                            exercise.mediaItem!.url!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                          ))
                        : const CircleAvatar(
                            maxRadius: 20,
                            minRadius: 10,
                            backgroundImage: AssetImage("assets/no_media.png"),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        exercise.name,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 1, child: Text("Set")),
            Expanded(flex: 1, child: Text("Previous")),
            Expanded(flex: 2, child: Center(child: Text("Weight"))),
            Expanded(flex: 2, child: Center(child: Text("Reps"))),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: exercise.currentSets.length,
          itemBuilder: (context, index) {
            var set = exercise.currentSets.isNotEmpty
                ? exercise.currentSets[index]
                : ExerciseSet();

            var prevSet = ExerciseSet();
            if (index < exercise.previousSets.length) {
              prevSet = exercise.previousSets.isNotEmpty
                  ? exercise.previousSets[index]
                  : ExerciseSet();
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 1,
                      child: Text("${exercise.currentSets.indexOf(set) + 1}")),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: prevSet.reps != null || prevSet.weight != null
                          ? Text('${prevSet.weight} x ${prevSet.reps}')
                          : const Text('-'),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Text(set.weight ?? "")),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Text(set.reps ?? "")),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
