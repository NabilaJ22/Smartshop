import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _name = TextEditingController();

  void _register() {
    if (_formKey.currentState!.validate()) {
      if (_password.text != _confirmPassword.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Passwords don't match")),
        );
        return;
      }

      // For now, just show success and navigate back to login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _name,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter your name' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter email' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter password' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _confirmPassword,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Confirm your password' : null,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _register,
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
