import 'package:brew_crew/app/models/brew.dart';
import 'package:brew_crew/app/services/firebase_auth_service.dart';
import 'package:brew_crew/app/services/firebase_database_service.dart';
import 'package:brew_crew/app/widgets/brew_app_bar.dart';
import 'package:brew_crew/app/widgets/brew_list.dart';
import 'package:brew_crew/app/widgets/brew_settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final _firebaseAuthService = FirebaseAuthService(FirebaseAuth.instance);

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
        backgroundColor: Theme.of(context).primaryColor,
        appBar: BrewAppBar(),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    color: Colors.brown[400],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 18,
                    ),
                    elevation: 25,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    onPressed: () => _settingsButtonPressed(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'Settings',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RaisedButton(
                    color: Colors.brown[400],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 18,
                    ),
                    elevation: 25,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    onPressed: () => _signOutButtonPressed(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BrewList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
