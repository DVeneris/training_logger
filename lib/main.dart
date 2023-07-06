import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:training_tracker/routes.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/database-repository.dart';
import 'package:training_tracker/widgets/image/image.dart';
import 'package:training_tracker/widgets/user/login.dart';
import 'package:training_tracker/widgets/user/user_screen.dart';
import 'package:training_tracker/widgets/workout/exercise_list.dart';
import 'package:training_tracker/widgets/workout/history_page.dart';
import 'package:training_tracker/widgets/workout/workout.dart';
import 'package:training_tracker/utils/workout_history_card.dart';
import 'package:training_tracker/widgets/workout/workoutCreator.dart';
import 'package:training_tracker/widgets/workout/workout_template_list.dart';
import 'dart:async';

import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization =
      Firebase.initializeApp(); //connection to firebase

  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return const Text(
              'error',
              textDirection: TextDirection.ltr,
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              onGenerateTitle: (context) => "Random App",
              onGenerateInitialRoutes: RouteGenerator.generateInitialRoutes,
              onGenerateRoute: RouteGenerator.generateRoute,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
            );
          }
          // Otherwise, show something whilst waiting for initialization to complete
          return const Text('loading', textDirection: TextDirection.ltr);
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const List<Widget> _pages = <Widget>[
    UserView(),
    WorkoutHistory(),
    // ImageTest(),
    WorkoutTemplateList(),
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text(
            "Waiting",
            textDirection: TextDirection.ltr,
          );
        } else if (snapshot.hasError) {
          return const Text(
            "error",
            textDirection: TextDirection.ltr,
          );
        } else if (snapshot.hasData) {
          // _selectedIndex = 0;
          return Scaffold(
            body: _pages.elementAt(_selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.fitness_center_rounded),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: '',
                ),
              ],
              backgroundColor: Colors.blue[100],
              selectedIconTheme: IconThemeData(color: Colors.blue, size: 30),
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.blue,
              onTap: _onItemTapped,
            ),
          );
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
