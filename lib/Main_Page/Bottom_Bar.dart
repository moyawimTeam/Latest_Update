import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two/Models/User.dart';
import 'package:two/Profile_Page/Firestore_Profile.dart';
import 'package:two/Profile_Page/My_Profile_Page.dart';
import 'package:two/Test_Pages/test.dart';
import 'package:two/messaging/messaging_page.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new BottomNavigationBar(
      backgroundColor: Colors.blue[500],
      items: [
        BottomNavigationBarItem(
            icon: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Test();
                  }));
                },
                iconSize: 30,
                color: Colors.black,
              ),
            ),
            title: new Text('الإعدادات',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black))),
        BottomNavigationBarItem(
            icon: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () async {
                  final user = Provider.of<User>(context, listen: false);
                  String ref = await BackendProfile(user: user).getRef();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MyProfilePage(
                      ref: ref,
                    );
                  }));
                },
                iconSize: 30,
                color: Colors.black,
              ),
            ),
            title: new Text(
              'صفحتك',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            )),
        BottomNavigationBarItem(
            icon: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.chat),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Messaging();
                  }));
                },
                iconSize: 25,
                color: Colors.black,
              ),
            ),
            title: new Text(
              'محادثة',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            )),
        BottomNavigationBarItem(
            icon: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.home),
                onPressed: () {},
                iconSize: 30,
              ),
            ),
            title: new Text(
              'الرئيسية',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
      ],
      onTap: (int x) => debugPrint('index $x'),
      type: BottomNavigationBarType.fixed,
      fixedColor: Colors.black,

      //fixedColor: Colors.blue,
    );
  }
}
