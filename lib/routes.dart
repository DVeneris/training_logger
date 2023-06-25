import 'package:flutter/material.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/workout.dart';
import 'package:training_tracker/widgets/user/username.dart';
import 'package:training_tracker/widgets/workout/exercise_creator.dart';
import 'package:training_tracker/widgets/user/register.dart';
import 'package:training_tracker/widgets/user/user_screen.dart';
import 'package:training_tracker/widgets/workout/exercise_list.dart';
import 'package:training_tracker/widgets/workout/history_page.dart';
import 'package:training_tracker/widgets/user/login.dart';
import 'package:training_tracker/widgets/workout/workout.dart';
import 'package:training_tracker/widgets/workout/workoutCreator.dart';
import 'package:training_tracker/widgets/workout/workout_overview.dart';
import 'package:training_tracker/widgets/workout/workout_template_list.dart';

import 'main.dart';

class RouteGenerator {
// 2.
  static const String homePage = '/';
  static const String singleWorkout = '/singleWorkout';
  static const String exerciseList = '/exerciseList';
  static const String workoutOverview = '/workoutOverview';
  static const String workoutCreator = '/workoutCreator';
  static const String register = '/register';
  static const String login = '/login';
  static const String exerciseCreator = '/exerciseCreator';
  static const String usernameGetter = '/usernameGetter';

// 3.
  RouteGenerator._();
// 3.
  static List<Route> generateInitialRoutes(String name) {
    return <Route>[
      MaterialPageRoute(
        //builder: (_) => const SingleWorkout(),
        builder: (_) => const MyHomePage(),
      )
    ];
  }

  static Route<dynamic> generateRoute<T>(RouteSettings settings) {
    final args = settings.arguments as Map<String, T>?;
//4.
    switch (settings.name) {
      case homePage: //5
        return MaterialPageRoute(
          // builder: (_) => const SingleWorkout(),
          builder: (_) => const MyHomePage(),
        );
      case singleWorkout:
        return MaterialPageRoute(
          builder: (_) => SingleWorkout(
            workout: args!['workout'] as WorkoutDTO,
          ),
        );
      case exerciseList:
        return MaterialPageRoute(
          builder: (_) => const ExcerciseList(),
        );
      case workoutOverview:
        return MaterialPageRoute(
          builder: (_) => WorkoutOverView(
            workout: args!['workout'] as WorkoutDTO,
          ),
        );
      case workoutCreator:
        return MaterialPageRoute(
          builder: (_) => const SingleWorkoutCreator(),
        );
      // case register:
      //   return MaterialPageRoute(
      //     builder: (_) => const RegistersScreen(),
      //   );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case exerciseCreator:
        return MaterialPageRoute(
          builder: (_) => const ExerciseCreator(),
        );
      case usernameGetter:
        return MaterialPageRoute(
          builder: (_) => const UserNameGetter(),
        );
      default:
        throw FormatException("Route not found");
    }
  }
}

class ScreenArguments<T> {
  final T args;

  ScreenArguments({required this.args});
}
/*
There must be a route named '/' which has to map to the first page that’s being shown when
your app starts. It’s a requirement, not a just a good practice.

1. Actually this class is just a "wrapper" for a single static function because declaring global
functions is possible, but it’s not a good idea.generateRoute() is the main actor.

2. Each page of the app is uniquely identified by a string; it’s the same thing you’re used to
see on the internet where web pages are identified by URLs. In this case:
• The WorkoutHistory route is associated with the '/' path
• The SingleWorkout route is associated with the '/singleWorkout' path
Do you want to press on a button and show the RandomPage widget? It’s very easy, you
just need to write...
Navigator.of(context)?.pushNamed(RouteGenerator.randomPage);
... and the new screen appears. The pushNamed() method takes a path, which is linked to
a page, and navigates to it; in this case it looks for '/random' and shows the widget that’s
been assigned to it.

3. The settings parameter carries some info gathered by the Navigator.of method such as
the name of the route. This part is very important because it’s were you map an URI (the
path) to the route/screen.
4. The MaterialPageRoute<T> class replaces one screen with another by using an Android
slide transition. The equivalent class for the cupertino package is CupertinoPageRoute<T>
which does the same job but with an iOS slide transition.



 */