import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:brew_crew/pages/wrapper.dart';
import 'package:brew_crew/services/firebase_auth_service.dart';
import 'package:brew_crew/models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: FirebaseAuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
