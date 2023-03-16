import 'package:flutter/material.dart';
import 'package:training_tracker/routes.dart';
import 'package:training_tracker/widgets/exercise_list.dart';
import 'package:training_tracker/widgets/history_page.dart';
import 'package:training_tracker/widgets/workout.dart';
import 'package:training_tracker/widgets/workout_history_card.dart';
import 'package:training_tracker/widgets/workout_template_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => "Random App",
      onGenerateInitialRoutes: RouteGenerator.generateInitialRoutes,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return const WorkoutTemplateList();
//   }
// }
