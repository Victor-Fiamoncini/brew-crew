import 'package:flutter/material.dart';

import 'package:brew_crew/widgets/loading.dart';

import 'package:brew_crew/services/firebase_auth_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({this.toggleGuestView});

  final Function toggleGuestView;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _firebaseAuthService = FirebaseAuthService();
  final _signUpFormKey = GlobalKey<FormState>();
  String email;
  String password;
  String error = '';
  bool loading = false;

  String _emailValidator(String value) {
    if (value.isEmpty || !value.contains('@')) {
      return 'Please, fill with some valid e-mail';
    }

    return null;
  }

  String _passwordValidator(String value) {
    if (value.isEmpty || value.length < 6) {
      return 'Please, fill a password with a 6 or more chars';
    }

    return null;
  }

  Future<void> _signUpFormButtonPressed() async {
    if (_signUpFormKey.currentState.validate()) {
      setState(() => loading = true);

      final cleanedEmail = email.trim();
      final cleanedPassword = password.trim();

      try {
        await _firebaseAuthService.signUpWithEmailAndPassword(
          cleanedEmail,
          cleanedPassword,
        );
      } catch (e) {
        setState(() => error = e.toString());
      }

      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Loading();
    }

    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: const Text('Sign Up to Brew Crew'),
        actions: [
          FlatButton.icon(
            onPressed: () {
              widget.toggleGuestView();
            },
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: const Text(
              'Sign In',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 50,
        ),
        child: Form(
          key: _signUpFormKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'E-mail',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.brown[400],
                      width: 2,
                    ),
                  ),
                ),
                validator: _emailValidator,
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
                      color: Colors.brown[400],
                      width: 2,
                    ),
                  ),
                ),
                validator: _passwordValidator,
                onChanged: (value) {
                  setState(() => password = value);
                },
              ),
              const SizedBox(height: 20),
              RaisedButton(
                color: Colors.brown[400],
                onPressed: () {
                  _signUpFormButtonPressed();
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                error,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
