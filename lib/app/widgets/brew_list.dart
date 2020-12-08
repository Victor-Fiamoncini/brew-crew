import 'package:brew_crew/app/models/brew.dart';
import 'package:brew_crew/app/widgets/brew_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context) ?? [];

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 16),
      cacheExtent: (200 * brews.length).toDouble(),
      itemCount: brews.length,
      itemBuilder: (context, index) => BrewListItem(brew: brews[index]),
    );
  }
}
