import 'package:flutter/material.dart';
import 'package:training_tracker/DTOS/user-dto.dart';
import 'package:training_tracker/DTOS/user_profile_dto.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/user-service.dart';

import '../../utils/kawaii_textbox.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  bool isSaving = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.chevron_left_rounded),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Edit Profile"),
      ),
      body: FutureBuilder<UserDTO>(
          future: UserService().getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              //loading icon
              return const Text(
                'loading',
                textDirection: TextDirection.ltr,
              );
            } else if (snapshot.hasError) {
              return const Text(
                'error in snapshot',
                textDirection: TextDirection.ltr,
              );
              //show error
            } else if (snapshot.hasData) {
              var user = snapshot.data;
              if (user == null) {
                AuthService().signOut(); //test this
              }
              var userprofiledata = UserProfileDTO(
                  description: user!.description,
                  link: user.link,
                  name: user.name);
              return Column(children: [
                SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/no_media.png"),
                      ),
                      Positioned(
                          bottom: 0,
                          right: -25,
                          child: RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            fillColor: Color(0xFFF5F6F9),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.blue,
                            ),
                            padding: EdgeInsets.all(1.0),
                            shape: CircleBorder(),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Name"),
                KawaiiTextbox(
                  initialValue: userprofiledata.name,
                  onChange: (change) {
                    userprofiledata.name = change;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Description"),
                KawaiiTextbox(
                  initialValue: userprofiledata.description,
                  onChange: (change) {
                    userprofiledata.description = change;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Link"),
                KawaiiTextbox(
                  initialValue: userprofiledata.link,
                  onChange: (change) {
                    userprofiledata.link = change;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextButton(
                    onPressed: () async {
                      setState(() {
                        isSaving = true;
                      });
                      await UserService().updateUser(userprofiledata);
                      setState(() {
                        isSaving = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12)),
                      child: GestureDetector(
                        onTap: () {},
                        child: Center(
                            child: Text(
                          "${isSaving ? 'saving...' : 'Save'}",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                ),
              ]);
            } else {
              //no data found
              return const Text(
                'no data',
                textDirection: TextDirection.ltr,
              );
            }
          }),
    );
  }
}
