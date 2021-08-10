import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/brew.dart';
import '../../services/auth.dart';
import '../../services/database.dart';
import 'brew_list.dart';
import 'settings_form.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 60,
              vertical: 20,
            ),
            child: SettingsForm(),
          );
        },
      );
    }

    return StreamProvider<List<Brew>>.value(
      initialData: [],
      value: DatabaseService().brews,
      child: Scaffold(
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
            ),
            TextButton.icon(
              onPressed: () => _showSettingsPanel(),
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
              icon: Icon(Icons.settings),
              label: Text("Settings"),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
