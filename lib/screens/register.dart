import 'package:flutter/material.dart';
import 'package:graftr/services/auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
        title: Text('Grafter'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
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
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() {
                          error = 'please provide a valid email';
                          loading = false;
                        });
                      }
                    }
                  },
                  child: Text('Register')),
              Text(error, style: TextStyle(color: Colors.red)),
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
