import 'package:brew_crew/styles/theme.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors['primary'],
      appBar: AppBar(
        backgroundColor: colors['secundary'],
        elevation: 0,
        title: const Text('Sign in to Brew Crew'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 50,
        ),
        child: RaisedButton(
          onPressed: () {},
          child: const Text('Sign in anon'),
        ),
      ),
    );
  }
}
