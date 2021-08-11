import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../services/database/brew_database.dart';
import '../../shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    return StreamBuilder<UserBrewData>(
      stream: BrewDatabaseService(uid: user!.uid).userBrewData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserBrewData userData = snapshot.data!;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Update your brew settings.',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                TextFormField(
                  initialValue: userData.name,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                  decoration: InputDecoration(
                    hintText: "Name",
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String?>(
                  value: _currentSugars ?? userData.sugars,
                  onChanged: (val) => setState(() => _currentSugars = val),
                  items: sugars.map(
                    (sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text("$sugar sugars"),
                      );
                    },
                  ).toList(),
                  hint: Text("Choose Sugars"),
                ),
                SizedBox(height: 20),
                Slider(
                  min: 100,
                  max: 900,
                  divisions: 8,
                  activeColor:
                      Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor:
                      Colors.brown[_currentStrength ?? userData.strength],
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  onChanged: (val) =>
                      setState(() => _currentStrength = val.round()),
                ),
                SizedBox(height: 20),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await BrewDatabaseService(uid: user.uid).updateData(
                          sugars: _currentSugars ?? userData.sugars,
                          name: _currentName ?? userData.name,
                          strength: _currentStrength ?? userData.strength,
                        );
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                    ),
                    child: Text("Update"),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
