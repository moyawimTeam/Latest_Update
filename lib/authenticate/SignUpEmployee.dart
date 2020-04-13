import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:two/Data.dart';
import 'package:two/Main_Page/Main_view.dart';
import 'package:two/authenticate/SignIn.dart';
import 'package:two/services/auth.dart';
import 'package:two/sharing/constants.dart';
import 'package:two/sharing/loading.dart';

class SignUpEmployee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'إنشاء حساب';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
            child: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
            },
            highlightColor: Colors.green,
          ),
          backgroundColor: Colors.green,
          title: Text(appTitle,
              style: TextStyle(
                fontSize: 24.0,
              )),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  final customeFontSize = 20.0;
  bool loading = false;
  final AuthService _auth = AuthService();
//  final _firestore = Firestore.instance;

  String currentcity = 'بيروت';
  String currentJob = 'بلاط';
  DocumentReference userID;

  String email = '';
  String password = '';
  String error = '';

  String firstname = '';
  String lastname = '';
  String phonenumber = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return loading
        ? Loading()
        : Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ListView(
                  padding: EdgeInsets.only(bottom: 10.0, right: 20.0, left: 30),
                  children: <Widget>[
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        style: TextStyle(fontSize: customeFontSize),
                        decoration: textInputDecoration.copyWith(
                            alignLabelWithHint: false,
                            errorStyle: TextStyle(color: Colors.red.shade500),
                            hintText: "ادخل الإسم الأول",
                            labelText: " الإسم الأول"),
                        validator: (val) =>
                            val.isEmpty ? 'الرجاء إدخال الإسم الأول' : null,
                        onChanged: (String val) {
                          setState(() {
                            firstname = val;
                          });
                        },
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        style: TextStyle(fontSize: customeFontSize),
                        decoration: textInputDecoration.copyWith(
                            alignLabelWithHint: false,
                            errorStyle: TextStyle(color: Colors.red.shade500),
                            hintText: "ادخل إسم العائلة",
                            labelText: " إسم العائلة"),
                        validator: (val) =>
                            val.isEmpty ? 'الرجاء إدخال اسم العائلة' : null,
                        onChanged: (String val) {
                          setState(() {
                            lastname = val;
                          });
                        },
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: customeFontSize),
                        decoration: textInputDecoration.copyWith(
                            alignLabelWithHint: false,
                            errorStyle: TextStyle(color: Colors.red.shade500),
                            hintText: "ادخل البريد الإلكتروني",
                            labelText: "البريد الإلكتروني"),
                        validator: (String val) =>
                            EmailValidator.validate(email)
                                ? null
                                : 'أدخل البريد الالكتروني',
                        onChanged: (String val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        style: TextStyle(fontSize: customeFontSize),
                        obscureText: true,
                        textAlign: TextAlign.right,
                        decoration: textInputDecoration.copyWith(
                          hintText: "ادخل كلمة المرور",
                          labelText: "كلمة المرور",
                        ),
                        validator: (String val) => val.length < 6
                            ? 'كلمة السر يجب أن تكون 6 أحرف او/و أرقام على الأقل'
                            : null,
                        onChanged: (String val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        style: TextStyle(fontSize: customeFontSize),
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.right,
                        decoration: textInputDecoration.copyWith(
                          hintText: "ادخل رقم الهاتف",
                          labelText: "رقم الهاتف",
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'الرجاء إدخال رقم الهاتف';
                          }
                          return null;
                        },
                        onChanged: (String val) {
                          setState(() {
                            phonenumber = val;
                          });
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      verticalDirection: VerticalDirection.down,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                "اختر وظيفة",
                                style: TextStyle(
                                    fontSize: 22.0, letterSpacing: 4.0),
                                textDirection: TextDirection.rtl,
                              ),
                              padding: EdgeInsets.all(20.0),
                            ),
                            DropdownButton(
                                items: jobsList.map((var dropItems) {
                                  return DropdownMenuItem(
                                      value: dropItems, child: Text(dropItems));
                                }).toList(),
                                onChanged: (item) {
                                  setState(() {
                                    currentJob = item;
                                  });
                                },
                                value: currentJob)
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                "اختر منطقة",
                                style: TextStyle(
                                    fontSize: 22.0, letterSpacing: 4.0),
                                textDirection: TextDirection.rtl,
                              ),
                              padding: EdgeInsets.all(20.0),
                            ),
                            DropdownButton(
                                items: cities.map((var dropItems) {
                                  return DropdownMenuItem(
                                      value: dropItems, child: Text(dropItems));
                                }).toList(),
                                onChanged: (var item) {
                                  setState(() {
                                    currentcity = item;
                                  });
                                },
                                value: currentcity)
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: RaisedButton(
                        colorBrightness: Brightness.light,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.green),
                        ),
                        textTheme: ButtonTextTheme.primary,
                        color: Colors.green,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .registerWithEmailAndPasswordEmployee(
                                    email,
                                    password,
                                    firstname,
                                    lastname,
                                    currentJob,
                                    currentcity,
                                    phonenumber,
                                    description);
                            if (result == null) {
                              setState(() {
                                loading = false;
                              });
                              setState(() => error =
                                  'تعذر التسجيل تأكد من حسابك و كلمة السر');
                            } else {
                              setState(() {
                                loading = false;
                              });
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return MainView();
                              }));
                            }
//                            userID = await AuthService().getUserDoc();
                          }
                        },
                        child: Text(
                          'إنشاء حساب',
                          style: TextStyle(fontSize: customeFontSize),
                        ),
                      ),
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ]),
            ));
  }
}
