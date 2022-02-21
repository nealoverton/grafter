import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grafter'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        alignment: Alignment.center,
        child: Form(
          // key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('Welcome'),
              Text('Enter email and password to register'),
              TextFormField(
                decoration: InputDecoration(hintText: 'Email'),
                validator: ((value) =>
                    value!.isEmpty ? 'Enter an email' : null),
                onChanged: (value) => {setState(() => email = value)},
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Password'),
                validator: ((value) => value!.length < 6
                    ? 'Enter a password at least 6 characters long'
                    : null),
                obscureText: true,
                onChanged: (value) => {setState(() => password = value)},
              ),
              ElevatedButton(onPressed: () => {}, child: Text('Register')),
              SizedBox(height: 20.0),
              Text('Already have an account? Log in here:'),
              ElevatedButton(onPressed: () => {}, child: Text('Log in')),
            ],
          ),
        ),
      ),
    );
  }
}
