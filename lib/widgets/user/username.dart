import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/providers/user_provider.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/user-service.dart';
import 'package:training_tracker/utils/profile_edit_textbox.dart';

class UserNameGetter extends StatefulWidget {
  const UserNameGetter({super.key});

  @override
  State<UserNameGetter> createState() => _UserNameGetterState();
}

class _UserNameGetterState extends State<UserNameGetter> {
  String username = "";
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: ProfileEditTextbox(
              hint: "User Name",
              hasError: context.watch<UserProvider>().userExists == false,
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
                  // await provider.anonLoginUser(username);
                  // await provider.checkIfUserExist(username);
                  //  var user = AuthService().user;
                  // var userExists = await UserService()
                  //     .checkIfUserExistsandCreateUser(username);

                  //   Navigator.of(context).pop(username);
                  // } else {
                  //   setState(() {
                  //     _usernameExists = true;
                  //   });
                  // }
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
