import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  String _currentName;
  String _currentSugar;
  int _currentStrength;

  String _nameValidator(String value) {
    return value.isEmpty ? 'Enter an name' : null;
  }

  void _whenDropdownButtonChange(String value) {
    setState(() => _currentSugar = value);
  }

  void _whenSliderChange(double value) {
    setState(() => _currentStrength = value.toInt());
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your brew settings',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40),
                TextFormField(
                  initialValue: userData.name,
                  validator: _nameValidator,
                  onChanged: (value) {
                    setState(() => _currentName = value);
                  },
                  cursorColor: Colors.brown,
                  style: TextStyle(color: Colors.brown),
                  decoration: InputDecoration(
                    hintText: 'Name',
                    hintStyle: TextStyle(color: Colors.brown),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  value: _currentSugar ?? userData.sugars,
                  onChanged: _whenDropdownButtonChange,
                  iconEnabledColor: Colors.brown,
                  isExpanded: true,
                  items: sugars.map(
                    (sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text(
                          '$sugar',
                          style: TextStyle(color: Colors.brown),
                        ),
                      );
                    },
                  ).toList(),
                ),
                SizedBox(height: 40),
                Container(
                  width: double.infinity,
                  child: Slider(
                    min: 100,
                    max: 900,
                    divisions: 8,
                    activeColor: Colors.brown[
                        (_currentStrength ?? userData.strength) >= 500
                            ? 600
                            : 400],
                    inactiveColor: Colors.brown[
                        (_currentStrength ?? userData.strength) >= 500
                            ? 600
                            : 400],
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    label: (_currentStrength ?? userData.strength).toString(),
                    onChanged: _whenSliderChange,
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.white,
                    textColor: Colors.white,
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.brown),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugar ?? userData.sugars,
                          _currentName ?? userData.name,
                          _currentStrength ?? userData.strength,
                        );

                        Navigator.pop(context);
                      }
                    },
                  ),
                )
              ],
            ),
          );
        }

        return Loading();
      },
    );
  }
}
