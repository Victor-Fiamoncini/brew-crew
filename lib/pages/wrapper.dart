import 'package:brew_crew/pages/auth/auth.dart';
import 'package:brew_crew/pages/home/home.dart';
import 'package:brew_crew/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Auth();
    }

    return Home();
  }
}
