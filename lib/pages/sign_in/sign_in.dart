import 'package:brew_crew/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';

import 'package:brew_crew/styles/theme.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _firebaseAuthService = FirebaseAuthService();

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
          onPressed: () async {
            final response = await _firebaseAuthService.signInAnonymously();

            print(response.uid);
          },
          child: const Text('Sign in anon'),
        ),
      ),
    );
  }
}
