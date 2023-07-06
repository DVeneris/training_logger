import 'package:flutter/material.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/user-service.dart';
import 'package:training_tracker/utils/kawaii_textbox.dart';

class UserNameGetter extends StatefulWidget {
  const UserNameGetter({super.key});

  @override
  State<UserNameGetter> createState() => _UserNameGetterState();
}

class _UserNameGetterState extends State<UserNameGetter> {
  String username = "";
  bool _usernameExists = false;
  @override
  void initState() {
    _usernameExists = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: KawaiiTextbox(
              hint: "User Name",
              hasError: _usernameExists,
              errorMessage: "This username already exists",
              onChange: ((data) => setState(() {
                    username = data;
                  })),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () async {
                  //   var user = AuthService().user;
                  await UserService().createUser("testUser");
                  // var users = await UserService().getUsersByUsername(username);
                  // if (users.isEmpty) {
                  //   _usernameExists = false;

                  Navigator.of(context).pop(username);
                  // } else {
                  //   setState(() {
                  //     _usernameExists = true;
                  //   });
                  //}
                  //close all routes
                  //---todo///
                },
                child: const Text("Save"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
