import 'package:flutter/material.dart';
import 'package:grafter/services/auth.dart';

class LogIn extends StatefulWidget {
  final Function toggleAuthScreen;
  const LogIn({Key? key, required this.toggleAuthScreen}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grafter'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text('Log in to Grafter'),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Email'),
                validator: ((value) =>
                    value!.isEmpty ? 'Enter an email' : null),
                onChanged: (value) => {setState(() => email = value)},
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Password'),
                validator: ((value) => value!.length < 6
                    ? 'Password must be at least 6 characters'
                    : null),
                obscureText: true,
                onChanged: (value) => {setState(() => password = value)},
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() {
                          error = 'email and password not recognised';
                          loading = false;
                        });
                      }
                    }
                  },
                  child: const Text('Log in')),
              Text(error, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 20.0),
              const Text('New around here?'),
              ElevatedButton(
                  onPressed: () {
                    widget.toggleAuthScreen();
                  },
                  child: const Text('Register')),
            ],
          ),
        ),
      ),
    );
  }
}
