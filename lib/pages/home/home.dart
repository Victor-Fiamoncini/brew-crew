import 'package:flutter/material.dart';

import 'package:brew_crew/services/firebase_auth_service.dart';
import 'package:brew_crew/styles/theme.dart';

class Home extends StatelessWidget {
  final _firebaseAuthService = FirebaseAuthService();

  Future<void> _signOutButtonPressed() async {
    await _firebaseAuthService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors['primary'],
      appBar: AppBar(
        title: const Text('Brew Crew'),
        backgroundColor: colors['secundary'],
        elevation: 0,
        actions: [
          FlatButton.icon(
            onPressed: () {
              _signOutButtonPressed();
            },
            icon: const Icon(Icons.person),
            label: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
