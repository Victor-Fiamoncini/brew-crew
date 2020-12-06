import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/firebase_auth_service.dart';
import 'package:brew_crew/views/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: FirebaseAuthService(FirebaseAuth.instance).authStateChanges,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Google',
          brightness: Brightness.light,
          primaryColor: Colors.brown[100],
          accentColor: Colors.brown[400],
          hintColor: Colors.brown[500],
          cursorColor: Colors.brown[500],
          bottomAppBarColor: Colors.brown[400],
        ),
        home: Wrapper(),
      ),
    );
  }
}
