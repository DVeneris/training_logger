import 'package:flutter/material.dart';

class ExcerciseList extends StatelessWidget {
  const ExcerciseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 60,
        leading: TextButton(
          child: Text("Cancel"),
          onPressed: () {},
        ),
        title: Center(
          child: Text("Add Exercise",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              textAlign: TextAlign.center),
        ),
        actions: [
          TextButton(
            child: Text("Create"),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Search exercise',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: const [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Recent Exercises",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Colors.grey),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 15),
            child: Row(
              children: [
                const CircleAvatar(
                  maxRadius: 20,
                  minRadius: 10,
                  backgroundImage: AssetImage("assets/a.jpg"),
                  backgroundColor: Colors.transparent,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Leg Extension (Mashine)",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Legs",
                        style: TextStyle(
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
          ),
        ]),
      ),
    );
  }
}
