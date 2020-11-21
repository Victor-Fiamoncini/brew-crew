import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:brew_crew/pages/home/home.dart';
import 'package:brew_crew/pages/sign_in/sign_in.dart';
import 'package:brew_crew/pages/sign_up/sign_up.dart';

import 'package:brew_crew/models/user.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool showSignIn = true;

  void toggleGuestView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user != null) {
      return Home();
    }

    if (showSignIn) {
      return SignIn(toggleGuestView: toggleGuestView);
    }

    return SignUp(toggleGuestView: toggleGuestView);
  }
}
