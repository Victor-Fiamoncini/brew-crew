import 'package:brew_crew/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:brew_crew/pages/sign_in/sign_in.dart';
import 'package:brew_crew/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return user != null ? Home() : SignIn();
  }
}
