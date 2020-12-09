import 'package:brew_crew/app/constants/sugars.dart' as constants;
import 'package:brew_crew/app/models/brew.dart';
import 'package:brew_crew/app/models/user.dart';
import 'package:brew_crew/app/services/firebase_database_service.dart';
import 'package:brew_crew/app/validators/brew_settings_validator.dart';
import 'package:brew_crew/app/widgets/screen_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewSettings extends StatefulWidget {
  @override
  _BrewSettingsState createState() => _BrewSettingsState();
}

class _BrewSettingsState extends State<BrewSettings> {
  final _updateBrewFormKey = GlobalKey<FormState>();
  String _currentName;
  String _currentSugars;
  int _currentStrength;

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
        Widget brewSettingsChild = ScreenLoading();

        if (snapshot.hasData) {
          final brew = snapshot.data;

          brewSettingsChild = Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 2,
            ),
            child: Form(
              key: _updateBrewFormKey,
              child: Column(
                children: [
                  Text(
                    'Update your brew settings',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      hintStyle: const TextStyle(fontSize: 18),
                      filled: true,
                      fillColor: Colors.white,
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
                    validator: BrewSettingsValidator.name,
                    onChanged: (value) {
                      setState(() => _currentName = value);
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _currentSugars ?? brew.sugars,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).accentColor,
                    ),
                    elevation: 0,
                    dropdownColor: Colors.white,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
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
                    ),
                    items: constants.sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    validator: BrewSettingsValidator.sugars,
                    onChanged: (value) {
                      setState(() => _currentSugars = value);
                    },
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Slider(
                      value: (_currentStrength ?? brew.strength).toDouble(),
                      activeColor:
                          Colors.brown[_currentStrength ?? brew.strength],
                      inactiveColor:
                          Colors.brown[_currentStrength ?? brew.strength],
                      min: 100,
                      max: 900,
                      divisions: 8,
                      onChanged: (value) {
                        setState(() => _currentStrength = value.round());
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 60,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(26),
              topRight: Radius.circular(26),
            ),
          ),
          child: brewSettingsChild,
        );
      },
    );
  }
}
