import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  const Alert({this.title, this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).accentColor,
        ),
      ),
      content: Container(
        padding: const EdgeInsets.all(2),
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Close',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ],
    );
  }
}
