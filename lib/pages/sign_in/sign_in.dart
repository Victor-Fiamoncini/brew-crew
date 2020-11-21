import 'package:brew_crew/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';

import 'package:brew_crew/styles/theme.dart';
import 'package:flutter/services.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _firebaseAuthService = FirebaseAuthService();

  String email = 'victor.fiamoncini@gmail.com';
  String password = 'admin1234';

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
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'E-mail',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: colors['secundary'],
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() => email = value);
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: 'Password',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: colors['secundary'],
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() => password = value);
                },
              ),
              const SizedBox(height: 20),
              RaisedButton(
                color: colors['secundary'],
                onPressed: () async {},
                child: Text(
                  'Sign In',
                  style: TextStyle(color: colors['white']),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
