import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:two/Main_Page/Main_view.dart';
import 'package:two/authenticate/SignIn.dart';
import 'package:two/services/auth.dart';
import 'package:two/sharing/constants.dart';
import 'package:two/sharing/loading.dart';

class EmployerPage extends StatefulWidget {
  @override
  _EmployerState createState() => _EmployerState();
}

class _EmployerState extends State<EmployerPage> {
  final appTitle = 'إنشاء حساب';
  @override
  Widget build(BuildContext context) {
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
            highlightColor: Colors.blue,
          ),
          backgroundColor: Colors.green.shade700,
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
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final AuthService _auth = AuthService();
//  final _firestore = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';

  String firstname = '';
  String lastname = '';
  String phonenumber = '';
  DocumentReference userID;

  get customeFontSize => null;
  @override
  Widget build(BuildContext context) {
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
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: RaisedButton(
                        colorBrightness: Brightness.light,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.blue),
                        ),
                        textTheme: ButtonTextTheme.primary,
                        color: Colors.green.shade500,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .registerWithEmailAndPasswordEmployer(
                              email,
                              password,
                              firstname,
                              lastname,
                              phonenumber,
                            );
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
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return MainView();
                              }));
                            }
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
