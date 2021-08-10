import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import 'authenticate/authenticate.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    print(user);
    if (user == null) {
      return Authenticate();
    }
    return Home();
  }
}
