import 'package:brew_crew/pages/home/brew_tile.dart';
import 'package:brew_crew/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/brew.dart';

class BrewList extends StatefulWidget {
	@override
	_BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
	@override
	Widget build(BuildContext context) {
		final brews = Provider.of<List<Brew>>(context);

		return brews == null ? Loading() : ListView.builder(
			itemCount: brews.length,
			itemBuilder: (BuildContext content, int index) => BrewTile(brew: brews[index])
		);
	}
}
