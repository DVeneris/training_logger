import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/DTOS/user-dto.dart';
import 'package:training_tracker/DTOS/user_profile_dto.dart';
import 'package:training_tracker/providers/auth_provider.dart';
import 'package:training_tracker/providers/user_provider.dart';
import 'package:training_tracker/routes.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/user-service.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return FutureBuilder<UserDTO>(
        future: userProvider.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text(
              'loading',
              textDirection: TextDirection.ltr,
            );
          } else if (snapshot.hasError) {
            return const Text(
              'error',
              textDirection: TextDirection.ltr,
            );
            //show error
          } else if (snapshot.hasData) {
            var user = snapshot.data;
            if (user == null) {
              authProvider.signOut(() {});
            }
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(children: [
                    const SizedBox(
                      height: 50,
                    ),
                    user!.mediaItem != null && user.mediaItem!.url != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(user.mediaItem!.url!))
                        : const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage("assets/no_media.png"),
                          ),
                    Text(
                      user.userName,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 200,
                      child: TextButton(
                        onPressed: () {},
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20)),
                          child: GestureDetector(
                            onTap: () async {
                              userProvider.userProfile = UserProfileDTO(
                                  description: userProvider.user.description,
                                  link: userProvider.user.link,
                                  name: userProvider.user.name,
                                  mediaItem: userProvider.user.mediaItem);

                              await Navigator.of(context)
                                  .pushNamed(RouteGenerator.profileEdit);
                            },
                            child: const Center(
                                child: Text(
                              "Edit Profile",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                    ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.blue[100]),
                          child: const Icon(
                            Icons.logout_outlined,
                            color: Colors.blue,
                          ),
                        ),
                        title: GestureDetector(
                          onTap: () async {
                            await authProvider.signOut(() {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/', (route) => false);
                            });
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(color: Colors.red),
                          ),
                        ))
                  ]),
                ),
              ),
            );
          } else {
            //no data found
            return const Text(
              'no data',
              textDirection: TextDirection.ltr,
            );
          }
        });
  }
}
