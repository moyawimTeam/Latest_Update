import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseOperations {
  final String uid;
  DatabaseOperations({this.uid});

  Future updateEmployeeData(String firstname, String lastname, String job,
      String city, String phonenb, String description) async {
    final CollectionReference jobCollection =
        Firestore.instance.collection('Employees');
    return await jobCollection.document(uid).setData({
      'name': firstname,
      'lastname': lastname,
      'phone number': phonenb,
      'description': description,
      'job': job,
      'city': city,
    });
  }

  Future updateEmployerData(
      String firstname, String lastname, String phonenb) async {
    final CollectionReference jobCollection =
        Firestore.instance.collection('Employers');
    return await jobCollection.document(uid).setData({
      'name': firstname,
      'lastname': lastname,
      'phone number': phonenb,
    });
  }
}
