import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/providers/workout_provider.dart';

class WorkoutStats extends StatelessWidget {
  const WorkoutStats({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WorkoutProvider>(context);

    return Row(
      children: [
        Selector<WorkoutProvider, int>(
          selector: (_, service) => service.workoutTime,
          builder: (context, selNames, child) {
            return Text(provider.workoutTime.toString());
          },
          shouldRebuild: (previous, next) => true,
        ),
        const Text("----------------"),
        Selector<WorkoutProvider, int>(
          selector: (_, service) => service.totalWeight,
          builder: (context, selNames, child) {
            return Text(provider.totalWeight.toString());
          },
          shouldRebuild: (previous, next) => true,
        ),
      ],
    );
  }
}
