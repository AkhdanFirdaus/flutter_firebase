import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;

  SignUp({required this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text("Sign Up to Brew Crew"),
              actions: [
                TextButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                  icon: Icon(Icons.person),
                  label: Text("Sign In"),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 50,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter an email" : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (val) => val!.length < 6
                          ? "Enter password 6 chars long"
                          : null,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    FractionallySizedBox(
                      widthFactor: 1,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result =
                                _authService.registerWithEmailPassword(
                              email: email,
                              password: password,
                            );
                            if (result == null) {
                              setState(() {
                                error = "Please provide a valid email";
                                loading = true;
                              });
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pink[400],
                        ),
                        child: Text("Sign Up"),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
