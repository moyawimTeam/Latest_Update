import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two/Main_Page/Main_view.dart';
import 'package:two/Models/User.dart';
import 'package:two/authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if (user == null) {
      return Authenticate();
    } else {
      return MainView();
    }
  }
}
