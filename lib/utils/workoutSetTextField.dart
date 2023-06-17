import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WorkoutSetTextield extends StatefulWidget {
  Function(String) onChange;
  final String text;
  final String hint;

  WorkoutSetTextield(
      {required this.onChange,
      required this.text,
      required this.hint,
      super.key});

  @override
  State<WorkoutSetTextield> createState() => _WorkoutSetTextieldState();
}

class _WorkoutSetTextieldState extends State<WorkoutSetTextield> {
  final numberController = TextEditingController();
  @override
  void initState() {
    super.initState();

    numberController.addListener(_passLatestValue);
    numberController.text = widget.text;
  }

  void _passLatestValue() {
    widget.onChange(numberController.text);
  }

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 30,
      child: TextField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        controller: numberController,
        textAlign: TextAlign.center,
        maxLength: 5,
        decoration: InputDecoration(
          hintText: widget.hint,
          filled: true,
          contentPadding: const EdgeInsets.all(5.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide.none,
          ),
          // focusedBorder: const OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //   borderSide: BorderSide.none,
          // ),
          counterText: "",
        ),
      ),
    );
  }
}
