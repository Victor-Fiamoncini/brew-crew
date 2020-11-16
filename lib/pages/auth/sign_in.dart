import 'package:flutter/material.dart';

import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/utils/loading.dart';

import 'package:brew_crew/models/user.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String _email = '';
  String _password = '';
  String _error = '';

  void _whenToggleViewIsPressed() => widget.toggleView();

  String _emailValidator(String value) {
    return value.isEmpty ? 'Enter an email' : null;
  }

  String _passwordValidator(String value) {
    return value.length < 6 ? 'Enter a password greater than 6 chars' : null;
  }

  Future<void> _whenFormButtonIsPressed() async {
    if (_formKey.currentState.validate()) {
      setState(() => _loading = true);
      User res =
          await _authService.signInWithEmailAndPassword(_email, _password);

      if (res == null) {
        setState(() {
          _error = 'Could not sign in with those credentials';
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[300],
              elevation: 0.0,
              title: Text('Sign in'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person, color: Colors.white),
                  label: Text('Sign up', style: TextStyle(color: Colors.white)),
                  onPressed: _whenToggleViewIsPressed,
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    TextFormField(
                      validator: _emailValidator,
                      onChanged: (value) {
                        setState(() => _email = value);
                      },
                      style: TextStyle(color: Colors.brown),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.brown[300]),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      validator: _passwordValidator,
                      onChanged: (value) {
                        setState(() => _password = value);
                      },
                      style: TextStyle(color: Colors.brown),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.brown[300]),
                      ),
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      color: Colors.brown[600],
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _whenFormButtonIsPressed,
                    ),
                    SizedBox(height: 20),
                    Text(
                      _error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
