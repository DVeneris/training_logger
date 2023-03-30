import 'package:flutter/material.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(children: [
            const SizedBox(
              height: 50,
            ),
            const CircleAvatar(
              backgroundImage: AssetImage("assets/a.jpg"),
              radius: 50,
            ),
            const Text(
              "Dveneris",
              style: TextStyle(fontSize: 20),
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
                  child: const Center(
                      child: Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ),
            const Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            //list tiles/////
            // ListTile(
            //   leading: Container(
            //     width: 40,
            //     height: 40,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(100),
            //         color: Colors.blue[100]),
            //     child: const Icon(
            //       Icons.settings,
            //       color: Colors.blue,
            //     ),
            //   ),
            //   title: const Text("Settings"),
            //   trailing: Container(
            //     width: 40,
            //     height: 40,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(100),
            //         color: Colors.grey[100]),
            //     child: Icon(
            //       Icons.chevron_right,
            //       color: Colors.grey[700],
            //     ),
            //   ),
            // ),
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
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
            )
          ]),
        ),
      ),
    );
  }
}