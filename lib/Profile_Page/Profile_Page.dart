import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:main_page/main.dart';

class ProfilePage extends StatelessWidget {
  final String job1;
  final String desc1;
  final String name1;
  final String lastname1;
  final String phonenb1;
  final String city;

  const ProfilePage({
    Key key,
    @required this.job1,
    @required this.desc1,
    @required this.name1,
    @required this.lastname1,
    @required this.phonenb1,
    @required this.city,
  })  : assert(job1 != null),
        assert(desc1 != null),
        assert(name1 != null),
        assert(lastname1 != null),
        assert(phonenb1 != null),
        assert(city != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          leading: new Container(), // to remove back arrow
          title: new Text('الصفحة الشخصية'),
          centerTitle: true,
          elevation: 6.0,
          actions: <Widget>[
            new IconButton(
              //alignment: Alignment.centerRight,
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: Builder(
          builder: (context) => Container(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundColor: Colors.lightBlue,
                        radius: 70,
                        child: ClipOval(
                          child: SizedBox(
                            width: 180.0,
                            height: 180.0,
                            child: Image.network(
                              "https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60.0),
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.camera,
                          size: 20.0,
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    'الملف الشخصي',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    color: Colors.blue,
                  ),
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'الاسم : ' + name1,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'اسم العائلة : ' + lastname1,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'رقم الهاتف : ' + phonenb1,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'العمل : ' + job1,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'المدينة : ' + city,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    color: Colors.blue,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Text(
                          'تعريف : ' + desc1,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    'الصور',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
//                  GridView(), For pictures later
              ],
            ),
          ),
        ));
  }
}
