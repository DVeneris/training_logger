import 'package:flutter/material.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/widgets/workout/workout.dart';

class SimpleExerciseTile extends StatelessWidget {
  final ExerciseDTO exercise;
  const SimpleExerciseTile({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 15),
      child: Row(
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
                  ),
                )
              : const CircleAvatar(
                  maxRadius: 20,
                  minRadius: 10,
                  backgroundImage: AssetImage("assets/no_media.png"),
                ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
                Text(
                  exercise.exerciseGroup.name,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
