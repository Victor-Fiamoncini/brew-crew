import 'package:brew_crew/app/models/brew.dart';
import 'package:flutter/material.dart';

class BrewListItem extends StatelessWidget {
  const BrewListItem({this.brew});

  final Brew brew;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(38),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.brown[brew.strength],
          backgroundImage: const AssetImage('lib/app/assets/coffee_icon.png'),
        ),
        title: Text(
          brew.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text('Takes ${brew.sugars} sugar(s)'),
      ),
    );
  }
}
