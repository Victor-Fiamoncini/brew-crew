import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:brew_crew/services/firebase_database_service.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';

import 'package:brew_crew/widgets/loading.dart';

class BrewSettings extends StatefulWidget {
  @override
  _BrewSettingsState createState() => _BrewSettingsState();
}

class _BrewSettingsState extends State<BrewSettings> {
  final _updateBrewFormKey = GlobalKey<FormState>();
  final sugars = ['0', '1', '2', '3', '4'];
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  String _nameValidator(String value) {
    if (value.isEmpty) {
      return 'Please, fill with some valid name';
    }

    return null;
  }

  Future<void> _updateBrewFromButtonPressed(
    String uid,
    String name,
    String sugars,
    int strength,
  ) async {
    if (_updateBrewFormKey.currentState.validate()) {
      final firebaseDatabaseService = FirebaseDatabaseService(uid: uid);

      await firebaseDatabaseService.updateUserBrewData(
        _currentSugars ?? sugars,
        _currentName ?? name,
        _currentStrength ?? strength,
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<Brew>(
      stream: FirebaseDatabaseService(uid: user.uid).brew,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        }

        final brew = snapshot.data;

        return Form(
          key: _updateBrewFormKey,
          child: Column(
            children: [
              const Text(
                'Update your brew settings',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              TextFormField(
                keyboardType: TextInputType.text,
                initialValue: brew.name,
                decoration: InputDecoration(
                  hintText: 'Name',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.brown[400],
                      width: 2,
                    ),
                  ),
                ),
                validator: _nameValidator,
                onChanged: (value) {
                  setState(() => _currentName = value);
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _currentSugars ?? brew.sugars,
                items: sugars.map((sugar) {
                  return DropdownMenuItem(
                    value: sugar,
                    child: Text('$sugar sugars'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _currentSugars = value);
                },
              ),
              const SizedBox(height: 20),
              Slider(
                value: (_currentStrength ?? brew.strength).toDouble(),
                activeColor: Colors.brown[_currentStrength ?? brew.strength],
                inactiveColor: Colors.brown[_currentStrength ?? brew.strength],
                min: 100,
                max: 900,
                divisions: 8,
                onChanged: (value) {
                  setState(() => _currentStrength = value.round());
                },
              ),
              const SizedBox(height: 20),
              RaisedButton(
                color: Colors.brown[400],
                onPressed: () {
                  _updateBrewFromButtonPressed(
                    user.uid,
                    brew.name,
                    brew.sugars,
                    brew.strength,
                  );
                },
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
