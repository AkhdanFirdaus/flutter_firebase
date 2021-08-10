import 'package:brew_crew/shared/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';
import 'screens/wrapper.dart';
import 'services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brew Crew',
      theme: AppTheme.defaultTheme,
      home: StreamProvider<User?>.value(
        initialData: null,
        value: AuthService().user,
        child: Wrapper(),
      ),
    );
  }
}
