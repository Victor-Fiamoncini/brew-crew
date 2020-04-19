import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
	final Function toggleView;

	SignIn({ this.toggleView });

	@override
	_SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
	final AuthService _authService = AuthService();
	final _formKey = GlobalKey<FormState>();
	String _email = '';
	String _password = '';
	String _error = '';

	void _whenToggleViewIsPressed() => widget.toggleView();

	String _emailValidator(String value) => value.isEmpty ? 'Enter an email' : null;

	String _passwordValidator(String value) =>
		value.length < 6 ? 'Enter a password greater than 6 chars' : null;

	void _whenFormButtonIsPressed() async {
		if (_formKey.currentState.validate()) {
			dynamic res = await _authService.signInWithEmailAndPassword(_email, _password);

			if (res == null)
				setState(() => _error = 'Could not sign in with those credentials');
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.brown[100],
			appBar: AppBar(
				backgroundColor: Colors.brown[300],
				elevation: 0.0,
				title: Text('Sign in'),
				actions: <Widget>[
					FlatButton.icon(
						icon: Icon(Icons.person, color: Colors.white),
						label: Text('Sign up', style: TextStyle(color: Colors.white)),
						onPressed: _whenToggleViewIsPressed,
					)
				],
			),
			body: Container(
				padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
				child: Form(
					key: _formKey,
					child: Column(
						children: <Widget>[
							SizedBox(height: 20),
							TextFormField(
								validator: _emailValidator,
								onChanged: (String value) => setState(() => _email = value),
							),
							SizedBox(height: 20),
							TextFormField(
								obscureText: true,
								validator: _passwordValidator,
								onChanged: (String value) => setState(() => _password = value),
							),
							SizedBox(height: 20),
							RaisedButton(
								color: Colors.brown[600],
								child: Text(
									'Sign in',
									style: TextStyle(color: Colors.white)
								),
								onPressed: _whenFormButtonIsPressed,
							),
							SizedBox(height: 20),
							Text(_error, style: TextStyle(color: Colors.red, fontSize: 14))
						],
					),
				),
			),
		);
	}
}
