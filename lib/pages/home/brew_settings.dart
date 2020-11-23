import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _updateBrewFormKey,
      child: Column(
        children: [
          const Text(
            'Update your brew settings',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
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
            value: _currentSugars ?? '0',
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
          RaisedButton(
            color: Colors.brown[400],
            onPressed: () {},
            child: const Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
