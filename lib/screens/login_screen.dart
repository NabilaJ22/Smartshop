import 'package:flutter/material.dart';
import '../utils/shared_prefs.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  String dummyEmail = 'user@test.com';
  String dummyPassword = '123456';

  void _login() {
    if (_formKey.currentState!.validate()) {
      if (_email.text == dummyEmail && _password.text == dummyPassword) {
        SharedPrefs.setLogin(true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid credentials')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter email' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter password' : null,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
              SizedBox(height: 12),
              Text('Use: user@test.com / 123456'),
            ],
          ),
        ),
      ),
    );
  }
}
