import 'package:brew_crew/services/firebase_auth_service.dart';
import 'package:brew_crew/widgets/brew_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({this.toggleGuestView});

  final Function toggleGuestView;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _firebaseAuthService = FirebaseAuthService(FirebaseAuth.instance);
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
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: BrewAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 60,
          vertical: 80,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Text(
                'Brew Crew',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Form(
              key: _signUpFormKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 25,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'E-mail',
                        hintStyle: const TextStyle(fontSize: 20),
                        filled: true,
                        fillColor: Colors.brown[50],
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      validator: _emailValidator,
                      onChanged: (value) {
                        setState(() => email = value);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 25,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      textInputAction: TextInputAction.go,
                      onFieldSubmitted: (_) => _signUpFormButtonPressed(),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(fontSize: 20),
                        filled: true,
                        fillColor: Colors.brown[50],
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      validator: _passwordValidator,
                      onChanged: (value) {
                        setState(() => password = value);
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  RaisedButton(
                    color: Colors.brown[400],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                    elevation: 25,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    onPressed: () => _signUpFormButtonPressed(),
                    child: Text(
                      loading ? '...' : 'Sign Up',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    error,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Already registered?',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: ' Sign in here',
                    style: TextStyle(
                      color: Colors.brown[500],
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => widget.toggleGuestView(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
