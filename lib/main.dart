import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/pages/wrapper.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Brew Crew',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.brown,
          primarySwatch: Colors.brown,
          hintColor: Colors.brown,
          textSelectionColor: Colors.brown,
          textSelectionHandleColor: Colors.brown,
          cursorColor: Colors.brown,
        ),
        home: Wrapper(),
      ),
    );
  }
}
