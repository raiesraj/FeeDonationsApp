import 'package:flutter/material.dart';

class ShowDialog extends StatelessWidget {
  const ShowDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select an option'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: (){},
            title: Text("option1"),
          ),
          ListTile(
            onTap:(){},
            title: Text("option2"),
          ),
        ],
      ),
    );
  }
}
