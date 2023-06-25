import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class KawaiiTextbox extends StatefulWidget {
  final String? hint;
  final bool? canHideData;
  final Function(String) onChange;

  const KawaiiTextbox(
      {super.key, this.hint, this.canHideData, required this.onChange});

  @override
  State<KawaiiTextbox> createState() => _KawaiiTextboxState();
}

class _KawaiiTextboxState extends State<KawaiiTextbox> {
  final TextEditingController _kawaiiEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _kawaiiEditingController.addListener(() => _onControllerChange());
  }

  _onControllerChange() {
    widget.onChange(_kawaiiEditingController.text);
  }

  @override
  void dispose() {
    super.dispose();
    _kawaiiEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: TextField(
          controller: _kawaiiEditingController,
          obscureText: widget.canHideData ?? false,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hint,
          ),
        ),
      ),
    );
  }
}
