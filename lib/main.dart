import 'package:flutter/material.dart';
import 'package:training_tracker/routes.dart';
import 'package:training_tracker/widgets/user/user_screen.dart';
import 'package:training_tracker/widgets/workout/exercise_list.dart';
import 'package:training_tracker/widgets/workout/history_page.dart';
import 'package:training_tracker/widgets/workout/workout.dart';
import 'package:training_tracker/utils/workout_history_card.dart';
import 'package:training_tracker/widgets/workout/workoutCreator.dart';
import 'package:training_tracker/widgets/workout/workout_template_list.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const List<Widget> _pages = <Widget>[
    WorkoutHistory(),
    WorkoutTemplateList(),
    UserView()
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
