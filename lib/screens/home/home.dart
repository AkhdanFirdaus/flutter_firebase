import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Brew Crew"),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await _authService.signOut();
            },
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            icon: Icon(Icons.person),
            label: Text("Logout"),
          )
        ],
      ),
      body: Text("Home"),
    );
  }
}
