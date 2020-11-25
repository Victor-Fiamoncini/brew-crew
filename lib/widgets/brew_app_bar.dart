import 'package:flutter/material.dart';

class BrewAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(0);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        brightness: Brightness.dark,
        elevation: 0,
      ),
    );
  }
}
