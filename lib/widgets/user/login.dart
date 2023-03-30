import 'package:flutter/material.dart';

import '../../utils/kawaii_textbox.dart';
import '../../utils/social_tile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
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
            //em
            const Text(
              "Hello Again!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(
              height: 30,
            ),
            //email textfield
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: KawaiiTextbox(hint: "Username")),
            const SizedBox(
              height: 20,
            ),
            //password textfield
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: KawaiiTextbox(
                  hint: "Password",
                  canHideData: true,
                )),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.grey[700]),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextButton(
                onPressed: () {},
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Center(
                      child: Text(
                    "sign in",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Not a member? "),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Register now!",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              children: const [
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
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              SocialTile(
                assetUrl: "assets/facebook-logo.png",
              ),
              SizedBox(
                width: 20,
              ),
              SocialTile(
                assetUrl: "assets/google_logo.png",
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
