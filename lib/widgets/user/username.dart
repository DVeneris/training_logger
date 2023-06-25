import 'package:flutter/material.dart';
import 'package:training_tracker/services/user-service.dart';
import 'package:training_tracker/utils/kawaii_textbox.dart';

class UserNameGetter extends StatefulWidget {
  const UserNameGetter({super.key});

  @override
  State<UserNameGetter> createState() => _UserNameGetterState();
}

class _UserNameGetterState extends State<UserNameGetter> {
  String username = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: KawaiiTextbox(
              hint: "User Name",
              onChange: ((data) => setState(() {
                    username = data;
                  })),
            ),
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () async {
                    var user = await UserService().getUserByUsername(username);
                    if (user == null) {
                      await UserService().createUser(username);
                    }
                    //close all routes
                    //---todo///
                  },
                  child: const Text("Save"))
            ],
          )
        ],
      ),
    );
  }
}
