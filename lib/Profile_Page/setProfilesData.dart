//import 'package:cloud_firestore/cloud_firestore.dart';
//
//class SetEmployeeData {
//  final DocumentSnapshot myDoc;
//  const SetEmployeeData({
//    this.myDoc,
//  });
//
//  Future<String> getFirstName() async {
//    try {
//      return await myDoc.data['name'];
//    } catch (e) {
//      print(e);
//      return "";
//    }
//  }
//
//  Future<String> getLastName() async {
//    try {
//      return await myDoc.data['lastname'];
//    } catch (e) {
//      print(e);
//      return "";
//    }
//  }
//
//  Future<String> getPhoneNb() async {
//    try {
//      return await myDoc.data['phone number'];
//    } catch (e) {
//      print(e);
//      return "";
//    }
//  }
//
//  Future<String> getJobName() async {
//    try {
//      return await myDoc.data['job'];
//    } catch (e) {
//      print(e);
//      return "";
//    }
//  }
//
//  Future<String> getCityName() async {
//    try {
//      return await myDoc.data['city'];
//    } catch (e) {
//      print(e);
//      return "";
//    }
//  }
//
//  Future<String> getDescription() async {
//    try {
//      return await myDoc.data['description'];
//    } catch (e) {
//      print(e);
//      return "";
//    }
//  }
//}
