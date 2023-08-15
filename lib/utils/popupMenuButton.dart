import 'package:flutter/material.dart';

enum PopUpOptions { delete, edit }

enum PopupOperationOptions { delete, edit, both }

class CustomPopupMenuButton extends StatefulWidget {
  final Function(PopUpOptions) onItemSelection;
  final PopupOperationOptions operation;
  const CustomPopupMenuButton(
      {required this.onItemSelection, required this.operation, super.key});

  @override
  State<CustomPopupMenuButton> createState() => CustomPopupMenuButtonState();
}

class CustomPopupMenuButtonState extends State<CustomPopupMenuButton> {
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
    widget.onItemSelection(PopUpOptions.values[value]);
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
        itemBuilder: (ctx) {
          if (widget.operation == PopupOperationOptions.delete) {
            return [
              _buildPopupMenuItem('Delete', Icons.delete, 0),
            ];
          }
          if (widget.operation == PopupOperationOptions.edit) {
            return [
              _buildPopupMenuItem('edit', Icons.edit, 1),
            ];
          }
          if (widget.operation == PopupOperationOptions.both) {
            return [
              _buildPopupMenuItem('Delete', Icons.delete, 0),
              _buildPopupMenuItem('edit', Icons.edit, 1),
            ];
          }
          return [];
        });
  }
}
