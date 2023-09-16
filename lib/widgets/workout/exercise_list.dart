import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/DTOS/exercise_dto.dart';
import 'package:training_tracker/DTOS/exercise_options_dto.dart';
import 'package:training_tracker/DTOS/media-item-dto.dart';
import 'package:training_tracker/DTOS/workout_dto.dart';
import 'package:training_tracker/models/enums/enums.dart';
import 'package:training_tracker/models/exercise_set.dart';
import 'package:training_tracker/models/exercise.dart';
import 'package:training_tracker/models/media_item.dart';
import 'package:training_tracker/providers/exercise_creator_provider.dart';
import 'package:training_tracker/providers/exercise_list_provider.dart';
import 'package:training_tracker/providers/workout_creator_provider.dart';
import 'package:training_tracker/providers/workout_provider.dart';
import 'package:training_tracker/routes.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/exercise_service.dart';
import 'package:training_tracker/utils/simpleExerciseTile.dart';
import 'package:training_tracker/widgets/workout/workout.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ExcerciseList extends StatelessWidget {
  const ExcerciseList({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutProvider =
        Provider.of<WorkoutProvider>(context, listen: false);
    final exerciseListProvider =
        Provider.of<ExerciseListProvider>(context, listen: false);
    final workoutCreatorProvider =
        Provider.of<WorkoutCreatorProvider>(context, listen: false);

    return FutureBuilder<List<ExerciseDTO>>(
      future:
          exerciseListProvider.getExerciseList(), // Your asynchronous function
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.blue,
              size: 100,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leadingWidth: 60,
              leading: TextButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: const Center(
                child: Text("Add Exercise",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center),
              ),
              // actions: [
              //   TextButton(
              //     child: const Text("Create"),
              //     onPressed: () async {
              //       Provider.of<ExerciseCreatorProvider>(context, listen: false)
              //           .exercise = ExerciseDTO();
              //       Navigator.of(context)
              //           .pushNamed(RouteGenerator.exerciseCreator);
              //     },
              //   )
              // ],
            ),
            body: Selector<ExerciseListProvider, List<ExerciseDTO>>(
              selector: (_, service) => service.exerciseList,
              builder: (context, list, child) {
                return Container(
                  color: Colors.white,
                  child: Column(children: [
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: TextField(
                    //           decoration: InputDecoration(
                    //             filled: true,
                    //             prefixIcon: const Icon(Icons.search),
                    //             border: OutlineInputBorder(
                    //               borderSide: BorderSide.none,
                    //               borderRadius: BorderRadius.circular(10.0),
                    //             ),
                    //             hintText: 'Search exercise',
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Exercises",
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
                              onTap: () {
                                var exerciseComplete = exerciseListProvider
                                    .exerciseList
                                    .where((element) =>
                                        element.id == list[index].id);
                                if (exerciseListProvider.calledByCreator) {
                                  workoutCreatorProvider.pushExercise(
                                      ExerciseOptionsDTO(
                                          exercise: exerciseComplete.first));
                                  Provider.of<ExerciseListProvider>(context,
                                          listen: false)
                                      .calledByCreator = false;
                                } else {
                                  workoutProvider.pushExercise(
                                      ExerciseOptionsDTO(
                                          exercise: exerciseComplete.first));
                                }

                                Navigator.of(context).pop();
                              },
                              child: SimpleExerciseTile(exercise: list[index]));
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: list.length,
                      ),
                    )
                  ]),
                );
              },
              shouldRebuild: (previous, next) => true,
            ),
          );
        }
      },
    );

    //
  }
}

// FutureBuilder<List<ExerciseDTO>>(
//   future: exerciseListProvider.getExerciseList(),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       //loading icon
//       return const Text(
//         'loading',
//         textDirection: TextDirection.ltr,
//       );
//     } else if (snapshot.hasError) {
//       return const Text(
//         'error',
//         textDirection: TextDirection.ltr,
//       );
//       //show error
//     } else if (snapshot.hasData) {
//       var exerciseList = snapshot.data!;
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           leadingWidth: 60,
//           leading: TextButton(
//             child: const Text("Cancel"),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           title: const Center(
//             child: Text("Add Exercise",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                 ),
//                 textAlign: TextAlign.center),
//           ),
//           actions: [
//             TextButton(
//               child: const Text("Create"),
//               onPressed: () async {
//                 Provider.of<ExerciseCreatorProvider>(context, listen: false)
//                     .exercise = ExerciseDTO();
//                 Navigator.of(context)
//                     .pushNamed(RouteGenerator.exerciseCreator);
//                 // setState(() {});
//               },
//             )
//           ],
//         ),
//         body: Container(
//           color: Colors.white,
//           child: Column(children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         filled: true,
//                         prefixIcon: const Icon(Icons.search),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide.none,
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         hintText: 'Search exercise',
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const Row(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     "Recent Exercises",
//                     style: TextStyle(
//                         fontWeight: FontWeight.normal,
//                         fontSize: 15,
//                         color: Colors.grey),
//                   ),
//                 ),
//               ],
//             ),
//             Expanded(
//               child: ListView.separated(
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                       onTap: () {
//                         var exerciseComplete = exerciseList.where(
//                             (element) =>
//                                 element.id == exerciseList[index].id);
//                         workoutProvider.pushExercise(ExerciseOptionsDTO(
//                             exercise: exerciseComplete.first));
//                         Navigator.of(context).pop();
//                       },
//                       child: SimpleExerciseTile(
//                           exercise: exerciseList[index]));
//                 },
//                 separatorBuilder: (context, index) {
//                   return const Divider();
//                 },
//                 itemCount: exerciseList.length,
//               ),
//             )
//           ]),
//         ),
//       );
//     } else {
//       //no data found
//       return const Text(
//         'no data',
//         textDirection: TextDirection.ltr,
//       );
//     }
//   },
// );
