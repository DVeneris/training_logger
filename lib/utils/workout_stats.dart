import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/providers/workout_provider.dart';

class WorkoutStats extends StatelessWidget {
  const WorkoutStats({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WorkoutProvider>(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Text(
                  "Total Time",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                Selector<WorkoutProvider, int>(
                  selector: (_, service) => service.workoutTime,
                  builder: (context, selNames, child) {
                    return Text(
                      provider.workoutTime.toString(),
                    );
                  },
                  shouldRebuild: (previous, next) => true,
                ),
              ],
            ),
            Column(
              children: [
                const Text(
                  "Total Weight",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                Selector<WorkoutProvider, int>(
                  selector: (_, service) => service.totalWeight,
                  builder: (context, selNames, child) {
                    return Text(provider.totalWeight.toString());
                  },
                  shouldRebuild: (previous, next) => true,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
