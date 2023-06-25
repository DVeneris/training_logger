import 'package:flutter/material.dart';

import '../../utils/kawaii_textbox.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.chevron_left_rounded),
        title: const Text("Edit Profile"),
      ),
      body: Column(children: [
        const SizedBox(
          height: 20,
        ),
        // const KawaiiTextbox(hint: "Username"),
        // const SizedBox(
        //   height: 10,
        // ),
        // const KawaiiTextbox(hint: "Email"),
        // const SizedBox(
        //   height: 10,
        // ),
        // const KawaiiTextbox(hint: "Password"),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: TextButton(
            onPressed: () {},
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(12)),
              child: const Center(
                  child: Text(
                "Save",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        ),
      ]),
    );
  }
}
