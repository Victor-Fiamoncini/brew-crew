import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:brew_crew/services/firebase_auth_service.dart';
import 'package:brew_crew/services/firebase_database_service.dart';
import 'package:brew_crew/models/brew.dart';

import 'package:brew_crew/pages/home/brew_list.dart';
import 'package:brew_crew/pages/home/brew_settings.dart';

class Home extends StatelessWidget {
  final _firebaseAuthService = FirebaseAuthService();

  Future<void> _signOutButtonPressed() async {
    await _firebaseAuthService.signOut();
  }

  void _settingsButtonPressed(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 60,
          ),
          child: BrewSettings(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      value: FirebaseDatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: const Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: [
            FlatButton.icon(
              onPressed: () {
                _settingsButtonPressed(context);
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              label: const Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            FlatButton.icon(
              onPressed: () {
                _signOutButtonPressed();
              },
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
