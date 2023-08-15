import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/providers/user_provider.dart';
import 'package:training_tracker/routes.dart';
import 'package:training_tracker/services/auth.dart';

import '../../utils/profile_edit_textbox.dart';
import '../../utils/social_tile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(
              Icons.android,
              size: 100,
            ),
            const SizedBox(
              height: 60,
            ),
            const Text(
              "Hello!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextButton(
                onPressed: () async {
                  await provider.anonLoginUser();
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Center(
                      child: Text(
                    "Continue as guest",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("Or Continue with"),
                ),
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            // SocialTile(
            //   assetUrl: "assets/facebook-logo.png",
            // ),
            // SizedBox(
            //   width: 20,
            // ),
            // SocialTile(
            //   onClickFunction: AuthService().googleLogin,
            //   assetUrl: "assets/google_logo.png",
            // ),
            // ]),
          ]),
        ),
      ),
    );
  }
}
