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
	String _currentName = '';
	String _currentSugar = '0';
	int _currentStrength = 100;

	String _nameValidator(String value) => value.isEmpty ? 'Enter an name' : null;

	String _sugarsValidator(String value) => value.isEmpty ? 'Enter an sugar' : null;

	String _strengthValidator(String value) => value.isEmpty ? 'Enter an sugar' : null;

	void _whenDropdownButtonChange(String value) => setState(() => _currentSugar = value);

	void _whenSliderChange(double value) => setState(() => _currentStrength = value.toInt());

	void _whenFormButtonIsPressed() async {
		print(_currentName);
		print(_currentSugar);
		print(_currentStrength);
	}

	@override
	Widget build(BuildContext context) {
		final user = Provider.of<User>(context);

		return StreamBuilder<UserData>(
			stream: DatabaseService(uid: user.uid).userData,
			builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
				if (snapshot.hasData) {
					UserData userData = snapshot.data;

					return Form(
						key: _formKey,
						child: Column(
							children: <Widget>[
								Text(
									'Update your brew settings',
									style: TextStyle(fontSize: 18, color: Colors.white),
								),
								SizedBox(height: 20),
								TextFormField(
									initialValue: userData.name,
									validator: _nameValidator,
									onChanged: (String value) => setState(() => _currentName = value),
									cursorColor: Colors.white,
									style: TextStyle(color: Colors.white),
									decoration: InputDecoration(
										hintText: 'Name',
										hintStyle: TextStyle(color: Colors.white),
									),
								),
								SizedBox(height: 20),
								DropdownButtonFormField(
									value: _currentSugar ?? userData.sugars,
									onChanged: _whenDropdownButtonChange,
									iconEnabledColor: Colors.white,
									isExpanded: true,
									items: sugars.map((String sugar) => DropdownMenuItem(
										value: sugar,
										child: Text('$sugar', style: TextStyle(color: Colors.brown)),
									)).toList(),
								),
								SizedBox(height: 20),
								Slider(
									min: 100,
									max: 900,
									divisions: 8,
									activeColor: Colors.brown[(_currentStrength ?? userData.strength) >= 500 ? 600 : 400],
									inactiveColor: Colors.brown[(_currentStrength ?? userData.strength) >= 500 ? 600 : 400],
									value: (_currentStrength ?? userData.strength).toDouble(),
									label: (_currentStrength ?? userData.strength).toString(),
									onChanged: _whenSliderChange,
								),
								SizedBox(height: 20),
								RaisedButton(
									color: Colors.white,
									textColor: Colors.white,
									child: Text('Update', style: TextStyle(color: Colors.brown)),
									onPressed: _whenFormButtonIsPressed,
								)
							],
						),
					);
				}

				return Loading();
			}
		);
	}
}
