import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:two/Models/User.dart';

import 'Pop_Up_Update.dart';

class MyProfilePage extends StatefulWidget {
  final String ref;
  const MyProfilePage({this.ref});
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return widget.ref == "Employees"
        ? EmployeeProfilePage(widget: widget, user: user)
        : EmployerProfilePage(widget: widget, user: user);
  }
}

class EmployerProfilePage extends StatefulWidget {
  const EmployerProfilePage({
    Key key,
    @required this.widget,
    @required this.user,
  }) : super(key: key);

  final MyProfilePage widget;
  final User user;

  @override
  _EmployerProfilePageState createState() => _EmployerProfilePageState();
}

class _EmployerProfilePageState extends State<EmployerProfilePage> {
  File image;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = image;
      print('Image Path $image');
    });
  }

  Future UpLoadic(BuildContext context) async {
    String fileName = basename(image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      print("تم تحميل الصورة");
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Profile Picture Uploaded'),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    DocumentReference reference =
        Firestore.instance.collection('Employers').document(widget.user.uid);
    return StreamBuilder(
        stream: reference.snapshots(),
        builder: (context, snapshot) {
          var userDocument = snapshot.data;
          print(userDocument);
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
                                  child: (image != null)
                                      ? Image.file(
                                          image,
                                          fit: BoxFit.fill,
                                        )
                                      : Image.network(
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
                              onPressed: () {
                                getImage();
                                UpLoadic(context);
                              },
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
                                    'الاسم : ' + userDocument['name'],
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.pen,
                                      size: 15.0,
                                    ),
                                    onPressed: () {
                                      createAlertDialog(
                                        context,
                                        'الاسم',
                                      ).then((value) => reference.updateData({
                                            'name': value,
                                          }));
                                    },
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    'اسم العائلة : ' + userDocument['lastname'],
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.pen,
                                      size: 15.0,
                                    ),
                                    onPressed: () {
                                      createAlertDialog(
                                        context,
                                        'اسم العائلة: ',
                                      ).then((value) => reference.updateData({
                                            'lastname': value,
                                          }));
                                    },
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    'رقم الهاتف : ' +
                                        userDocument['phone number'],
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.pen,
                                      size: 15.0,
                                    ),
                                    onPressed: () {
                                      createAlertDialog(
                                        context,
                                        'رقم الهاتف : ',
                                      ).then((value) => reference.updateData({
                                            'phone number': value,
                                          }));
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
//                  GridView(), For pictures later
                    ],
                  ),
                ),
              ));
        });
  }
}

class EmployeeProfilePage extends StatelessWidget {
  const EmployeeProfilePage({
    Key key,
    @required this.widget,
    @required this.user,
  }) : super(key: key);

  final MyProfilePage widget;
  final User user;

  @override
  Widget build(BuildContext context) {
    DocumentReference ref =
        Firestore.instance.collection('Employees').document(user.uid);
    return StreamBuilder(
        stream: Firestore.instance
            .collection(widget.ref)
            .document(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          var userDocument = snapshot.data;
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
                                    'الاسم : ' + userDocument['name'],
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.pen,
                                      size: 15.0,
                                    ),
                                    onPressed: () {
                                      createAlertDialog(
                                        context,
                                        'الاسم',
                                      ).then((value) => ref.updateData({
                                            'name': value,
                                          }));
                                    },
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    'اسم العائلة : ' + userDocument['lastname'],
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.pen,
                                      size: 15.0,
                                    ),
                                    onPressed: () {
                                      createAlertDialog(
                                        context,
                                        'اسم العائلة ',
                                      ).then((value) => ref.updateData({
                                            'lastname': value,
                                          }));
                                    },
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    'رقم الهاتف : ' +
                                        userDocument['phone number'],
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.pen,
                                      size: 15.0,
                                    ),
                                    onPressed: () {
                                      createAlertDialog(
                                        context,
                                        'رقم الهاتف ',
                                      ).then((value) => ref.updateData({
                                            'phone number': value,
                                          }));
                                    },
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    'العمل : ' + userDocument['job'] ?? '',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.pen,
                                      size: 15.0,
                                    ),
                                    onPressed: () {
                                      createAlertDialog(
                                        context,
                                        'العمل ',
                                      ).then((value) => ref.updateData({
                                            'job': value,
                                          }));
                                    },
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    'المدينة : ' + userDocument['city'] ?? '',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.pen,
                                      size: 15.0,
                                    ),
                                    onPressed: () {
                                      createAlertDialog(
                                        context,
                                        'المدينة',
                                      ).then((value) => ref.updateData({
                                            'city': value,
                                          }));
                                    },
                                  )
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
                                'تعريف : ' + userDocument['description'] ?? '',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.pen,
                                  size: 15.0,
                                ),
                                onPressed: () {
                                  createAlertDialog(
                                    context,
                                    'تعريف',
                                  ).then((value) => ref.updateData({
                                        'description': value,
                                      }));
                                },
                              ),
                            )
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
        });
  }
}
