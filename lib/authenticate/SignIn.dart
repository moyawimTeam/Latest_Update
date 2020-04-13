import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:two/authenticate/SignUpEmployee.dart';
import 'package:two/authenticate/SignUpEmployer.dart';
import 'package:two/services/auth.dart';
import 'package:two/sharing/constants.dart';
import 'package:two/sharing/loading.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  @override
  void deactivate() {
    super.deactivate();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'ابحث عن عاملين يوميين',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        )),
                  ),
//            Image(image: AssetImage('wallpaper/labor-force.jpg')),
                  Container(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Column(children: <Widget>[
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          validator: (String val) =>
                              EmailValidator.validate(email)
                                  ? null
                                  : 'أدخل البريد الالكتروني',
                          textAlign: TextAlign.right,
                          decoration: textInputDecoration.copyWith(
                            hintText: 'أدخل رقم هاتفك أو بريدك الالكتروني',
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          onChanged: (String val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          validator: (String val) =>
                              val.isEmpty ? 'االرجاء ادخال كلمة المرور' : null,
//                      textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          decoration: textInputDecoration.copyWith(
                            hintText: 'أدخل كلمة المرور',
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          obscureText: true,
                          onChanged: (String val) {
                            setState(() {
                              password = val;
                            }); //
                          },
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Container(
                          height: 40.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.green,
                            color: Colors.green,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  dynamic result =
                                      await _auth.loginWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() => error =
                                        'تعذر التسجيل تأكد من حسابك و كلمة السر');
                                  }
                                }
                              },
                              child: Center(
                                child: Text('تسجيل الدخول',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat')),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                        Container(
                            height: 40.0, child: Text(':اذا لم يكن لديك حساب')),
                        //SizedBox(height: 20.0,),
                        Container(
                          height: 40.0,
                          color: Colors.transparent,
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1.0),
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Center(
                                child: Text('سجل عبر حسابك في الفايسبوك',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat')),
                              )),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          height: 40.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.green,
                            color: Colors.green,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return EmployerPage();
                                }));
                              },
                              child: Center(
                                child: Text('قم بالتسجيل كصاحب عمل',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat')),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
//                  Container(
//                      height: 40.0,
//                      child: Text('او')
//                  ),
                        //SizedBox(height: 20.0,),
                        Container(
                          height: 40.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.green,
                            color: Colors.green,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SignUpEmployee();
                                }));
                              },
                              child: Center(
                                child: Text('قم بالتسجيل كمياوم',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat')),
                              ),
                            ),
                          ),
                        ),
                        //SizedBox(height: 20.0,),
                      ]))
                ],
              ),
            ));
  }
}
