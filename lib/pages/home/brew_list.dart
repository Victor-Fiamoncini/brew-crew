import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:brew_crew/models/brew.dart';

import 'package:brew_crew/pages/home/brew_item.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context) ?? [];

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return BrewItem(brew: brews[index]);
      },
    );
  }
}
