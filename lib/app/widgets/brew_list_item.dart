import 'package:brew_crew/app/models/brew.dart';
import 'package:flutter/material.dart';

class BrewListItem extends StatelessWidget {
  const BrewListItem({this.brew});

  final Brew brew;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Card(
        elevation: 25,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
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
      ),
    );
  }
}
