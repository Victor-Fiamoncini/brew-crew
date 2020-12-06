import 'package:brew_crew/app/models/user.dart';
import 'package:brew_crew/app/views/home.dart';
import 'package:brew_crew/app/views/sign_in.dart';
import 'package:brew_crew/app/views/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
