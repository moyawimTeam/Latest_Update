import 'package:flutter/material.dart';
import 'package:two/authenticate/SignIn.dart';
import 'package:two/services/auth.dart';

class Test extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton.icon(
          icon: Icon(
            Icons.person,
            size: 50,
          ),
          label: Text(
            'Logout',
            style: TextStyle(fontSize: 50),
          ),
          onPressed: () async {
            await _auth.signout();
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return LoginPage();
            }));
          },
        ),
      ),
    );
  }
}
