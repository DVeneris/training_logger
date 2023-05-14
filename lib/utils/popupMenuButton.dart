import 'package:flutter/material.dart';

enum Options { delete }

class CustomPopupMenuButton extends StatefulWidget {
  final Function(Options) onItemSelection;
  const CustomPopupMenuButton({required this.onItemSelection, super.key});

  @override
  State<CustomPopupMenuButton> createState() => CustomPopupMenuButtonState();
}

class CustomPopupMenuButtonState extends State<CustomPopupMenuButton> {
//  var _popupMenuItemIndex = 0;

  PopupMenuItem _buildPopupMenuItem(
      String title, IconData iconData, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            iconData,
            color: Colors.blue,
          ),
          Text(title),
        ],
      ),
    );
  }

  _onMenuItemSelected(int value) {
    // setState(() {
    //   _popupMenuItemIndex = value;
    // });

    widget.onItemSelection(Options.values[value]);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert, color: Colors.blue),
      onSelected: (value) {
        _onMenuItemSelected(value as int);
      },
      offset: const Offset(-20, 40),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      itemBuilder: (ctx) => [
        _buildPopupMenuItem('Delete', Icons.delete, 0),
      ],
    );
  }
}
