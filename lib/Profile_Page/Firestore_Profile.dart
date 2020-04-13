import 'package:cloud_firestore/cloud_firestore.dart';

class BackendProfile {
  static bool isEmpo = true;
  final user;
  BackendProfile({
    this.user,
  });

  Future<String> getRef() async {
    String ref;
    DocumentSnapshot ds = await Firestore.instance
        .collection("Employers")
        .document(user.uid)
        .get();
    isEmpo = ds.exists;
    ref = isEmpo ? "Employers" : "Employees";
    return ref;
  }
}
