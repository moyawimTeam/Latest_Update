import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two/services/auth.dart';
import 'package:two/wrapper/wrapper.dart';

import 'Models/User.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          home: Wrapper(),
        ),
      ),
    );
  }
}
