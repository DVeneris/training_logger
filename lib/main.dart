import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/DTOS/user-dto.dart';
import 'package:training_tracker/DTOS/user_profile_dto.dart';
import 'package:training_tracker/providers/auth_provider.dart';
import 'package:training_tracker/providers/exercise_creator_provider.dart';
import 'package:training_tracker/providers/exercise_list_provider.dart';
import 'package:training_tracker/providers/workout_creator_provider.dart';
import 'package:training_tracker/providers/workout_history_provider.dart';
import 'package:training_tracker/providers/workout_provider.dart';
import 'package:training_tracker/providers/user_provider.dart';
import 'package:training_tracker/providers/workout_template_list_provider.dart';
import 'package:training_tracker/routes.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/database-repository.dart';
import 'package:training_tracker/services/exercise_service.dart';
import 'package:training_tracker/services/user-service.dart';
import 'package:training_tracker/services/workout_history_service.dart';
import 'package:training_tracker/services/workout_service.dart';
import 'package:training_tracker/widgets/user/login.dart';
import 'package:training_tracker/widgets/user/user_screen.dart';
import 'package:training_tracker/widgets/workout/exercise_list.dart';
import 'package:training_tracker/widgets/workout/history_page.dart';
import 'package:training_tracker/widgets/workout/workout.dart';
import 'package:training_tracker/utils/workout_history_card.dart';
import 'package:training_tracker/widgets/workout/workoutCreator.dart';
import 'package:training_tracker/widgets/workout/workout_template_list.dart';
import 'dart:async';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WorkoutProvider(WorkoutService()),
        ),
        ChangeNotifierProvider(
          create: (_) => ExerciseCreatorProvider(ExerciseService()),
        ),
        ChangeNotifierProvider(
          create: (_) => ExerciseListProvider(AuthService(), ExerciseService()),
        ),
        ChangeNotifierProvider(
          create: (_) => WorkoutCreatorProvider(WorkoutService()),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              WorkoutTemplateListProvider(AuthService(), WorkoutService()),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(AuthService(), UserService()),
        ),
        ChangeNotifierProvider(
          create: (_) => WorkoutHistoryProvider(
              AuthService(), WorkoutHistoryService(), ExerciseService()),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(AuthService()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
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
          return const Text(
            "",
            textDirection: TextDirection.ltr,
          );
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
    WorkoutHistory(),
    WorkoutTemplateList(),
    UserView(),
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return FutureBuilder<UserDTO?>(
      future: userProvider.getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.blue,
              size: 100,
            ),
          );
        } else if (snapshot.hasError) {
          authProvider.signOut(() {});
          return const LoginScreen();
        } else if (snapshot.hasData) {
          if (snapshot.data == null) {
            Navigator.of(context).pushNamed(RouteGenerator.login);
          }
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
              selectedIconTheme:
                  const IconThemeData(color: Colors.blue, size: 30),
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
