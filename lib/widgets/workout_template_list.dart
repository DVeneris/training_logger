import 'package:flutter/material.dart';

import '../routes.dart';

class WorkoutTemplateList extends StatelessWidget {
  const WorkoutTemplateList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 60,
        title: const Center(
          child: Text("Workout",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              textAlign: TextAlign.center),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "My Templates",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              Icon(Icons.add)
            ],
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 120,
              maxHeight: 180,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "New Workout Template",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Icon(Icons.more_horiz)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: Row(
                            children: const [
                              Text(
                                "1 x Bench press",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("Start"),
                  )
                ]),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
