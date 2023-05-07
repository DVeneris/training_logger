import 'package:flutter/material.dart';
import 'package:training_tracker/routes.dart';

import '../../utils/kawaii_textbox.dart';

class RegistersScreen extends StatefulWidget {
  const RegistersScreen({super.key});

  @override
  State<RegistersScreen> createState() => _RegistersScreenState();
}

class _RegistersScreenState extends State<RegistersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.android_rounded,
                size: 100,
              ),
              const SizedBox(
                height: 60,
              ),
              //em
              const Text(
                "Sign up",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: KawaiiTextbox(hint: "Username")),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: KawaiiTextbox(hint: "Email")),
              const SizedBox(
                height: 20,
              ),
              //password textfield
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: KawaiiTextbox(
                    hint: "Pasword",
                    canHideData: true,
                  )),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: KawaiiTextbox(
                      hint: "Confirm Pasword", canHideData: true)),
              const SizedBox(
                height: 10,
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
                      "sign up",
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
                  const Text("Already have an account? "),
                  GestureDetector(
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        RouteGenerator.login,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
